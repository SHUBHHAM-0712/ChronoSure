-- ==============================================================================
-- PHASE 7: TEMPORAL QUERY SUPPORT
-- ==============================================================================
-- This script creates the Views needed to abstract the Bi-Temporal architecture 
-- for the application layer. It also provides a comprehensive library of 
-- Time-Travel Queries for reporting and auditing.
-- ==============================================================================

SET search_path TO insurance;

-- ==============================================================================
-- 1. CURRENT STATE VIEWS (Fast Paths)
-- ==============================================================================
-- These views abstract the active tables. Legacy applications can query these 
-- views exactly as they would query standard tables, entirely unaware of history.

CREATE OR REPLACE VIEW insurance.current_customer AS
SELECT * FROM insurance.customer WHERE is_current = TRUE;

CREATE OR REPLACE VIEW insurance.current_policy AS
SELECT * FROM insurance.policy WHERE is_current = TRUE;

CREATE OR REPLACE VIEW insurance.current_claim AS
SELECT * FROM insurance.claim WHERE is_current = TRUE;

CREATE OR REPLACE VIEW insurance.current_payment AS
SELECT * FROM insurance.payment WHERE is_current = TRUE;

CREATE OR REPLACE VIEW insurance.current_agent AS
SELECT * FROM insurance.agent WHERE is_current = TRUE;


-- ==============================================================================
-- 2. TIMELINE VIEWS (Time-Travel Enablers)
-- ==============================================================================
-- These views seamlessly union the active table with the history table, allowing 
-- a single query to traverse the entire lifespan of a record.
-- Columns are explicitly listed to exclude the `history_id` surrogate key.

CREATE OR REPLACE VIEW insurance.v_customer_timeline AS
SELECT customer_id, date_of_birth, first_name, last_name, phone_number, email, city, zipcode, agent_id,
       valid_from, valid_to, transaction_from, transaction_to, version_number, is_current, modified_by, change_reason
FROM insurance.customer
UNION ALL
SELECT customer_id, date_of_birth, first_name, last_name, phone_number, email, city, zipcode, agent_id,
       valid_from, valid_to, transaction_from, transaction_to, version_number, is_current, modified_by, change_reason
FROM insurance.customer_history;

CREATE OR REPLACE VIEW insurance.v_policy_timeline AS
SELECT policy_id, start_date, end_date, premium, coverage, branch_id, agent_id,
       valid_from, valid_to, transaction_from, transaction_to, version_number, is_current, modified_by, change_reason
FROM insurance.policy
UNION ALL
SELECT policy_id, start_date, end_date, premium, coverage, branch_id, agent_id,
       valid_from, valid_to, transaction_from, transaction_to, version_number, is_current, modified_by, change_reason
FROM insurance.policy_history;

CREATE OR REPLACE VIEW insurance.v_agent_timeline AS
SELECT agent_id, first_name, last_name, phone_number, email, city, zipcode, branch_id,
       valid_from, valid_to, transaction_from, transaction_to, version_number, is_current, modified_by, change_reason
FROM insurance.agent
UNION ALL
SELECT agent_id, first_name, last_name, phone_number, email, city, zipcode, branch_id,
       valid_from, valid_to, transaction_from, transaction_to, version_number, is_current, modified_by, change_reason
FROM insurance.agent_history;

CREATE OR REPLACE VIEW insurance.v_claim_timeline AS
SELECT claim_id, amount_issued, date_issued, claim_status,
       valid_from, valid_to, transaction_from, transaction_to, version_number, is_current, modified_by, change_reason
FROM insurance.claim
UNION ALL
SELECT claim_id, amount_issued, date_issued, claim_status,
       valid_from, valid_to, transaction_from, transaction_to, version_number, is_current, modified_by, change_reason
FROM insurance.claim_history;

CREATE OR REPLACE VIEW insurance.v_customer_policy_timeline AS
SELECT customer_id, policy_id,
       valid_from, valid_to, transaction_from, transaction_to, version_number, is_current, modified_by, change_reason
FROM insurance.customer_policy
UNION ALL
SELECT customer_id, policy_id,
       valid_from, valid_to, transaction_from, transaction_to, version_number, is_current, modified_by, change_reason
FROM insurance.customer_policy_history;


-- ==============================================================================
-- 3. TIME-TRAVEL QUERY DEMONSTRATIONS (For Judges)
-- ==============================================================================
-- These queries are fully executable and demonstrate the power of the 
-- Bi-Temporal architecture using the sample data generated in this project.

-- ──────────────────────────────────────────────────────────────────────────────
-- DEMO 1: The "Where did they live?" Address Timeline (Valid Time)
-- ──────────────────────────────────────────────────────────────────────────────
-- Let's track the complete relocation history for Alice (Customer 1),
-- who moved from Seattle -> Manhattan -> Jersey City.
-- We can see exactly when each address was valid.
SELECT 
    version_number AS "Version",
    city AS "City",
    zipcode AS "ZIP",
    change_reason AS "Reason for Change",
    valid_from::TIMESTAMP(0) AS "Lived Here From",
    valid_to::TIMESTAMP(0) AS "Lived Here Until",
    is_current AS "Current Address?"
FROM insurance.v_customer_timeline 
WHERE customer_id = 1
ORDER BY version_number ASC;

-- ──────────────────────────────────────────────────────────────────────────────
-- DEMO 2: The "How much were they paying?" Premium History 
-- ──────────────────────────────────────────────────────────────────────────────
-- Policy 15 was renewed. Let's see the evolutionary history of this policy's
-- premium and duration.
SELECT 
    version_number AS "Version",
    premium AS "Premium ($)",
    start_date AS "Policy Start",
    end_date AS "Policy End",
    change_reason AS "Reason for Change",
    is_current AS "Active Policy?"
FROM insurance.v_policy_timeline 
WHERE policy_id = 15 
ORDER BY version_number ASC;

-- ──────────────────────────────────────────────────────────────────────────────
-- DEMO 3: Claim Adjudication Lifecycle (Audit Trail)
-- ──────────────────────────────────────────────────────────────────────────────
-- Claim 31 was registered and subsequently approved. This query shows the 
-- exact lifecycle of the claim from PENDING to APPROVED.
SELECT 
    version_number AS "Version",
    claim_status AS "Status",
    amount_issued AS "Amount ($)",
    change_reason AS "Action Taken",
    transaction_from::TIMESTAMP(0) AS "Action Timestamp"
FROM insurance.v_claim_timeline 
WHERE claim_id = 31 
ORDER BY version_number ASC;

-- ──────────────────────────────────────────────────────────────────────────────
-- DEMO 4: The "Time Machine" — AS OF Query
-- ──────────────────────────────────────────────────────────────────────────────
-- If we want to see the database EXACTLY as it was before the temporal DML 
-- script ran (i.e., at Version 1 for all customers), we can query the timeline
-- views with a specific historical timestamp.
--
-- Note: To run this dynamically, replace the timestamp string below with a 
-- time BEFORE you ran the 'Temporal Demo' script, but AFTER you ran 'DML (Baseline)'.
-- For example, setting the clock back by 5 minutes from now:
SELECT 
    customer_id, 
    first_name, 
    last_name, 
    city, 
    phone_number
FROM insurance.v_customer_timeline
WHERE (CURRENT_TIMESTAMP - INTERVAL '5 minutes') BETWEEN transaction_from AND transaction_to
ORDER BY customer_id LIMIT 10;

-- ──────────────────────────────────────────────────────────────────────────────
-- DEMO 5: Logical Delete Recovery (Backward Compatibility Proof)
-- ──────────────────────────────────────────────────────────────────────────────
-- In the Temporal Demo, a legacy application issued a raw DELETE on 
-- customer_policy (Customer 1, Policy 1). The trigger caught it, archived it, 
-- and let the delete happen.
-- 
-- The record is GONE from the active table:
-- SELECT * FROM insurance.customer_policy WHERE customer_id = 1 AND policy_id = 1; (Returns 0 rows)
--
-- But we can completely recover and audit the deletion from the timeline view:
SELECT 
    customer_id, 
    policy_id, 
    change_reason AS "Action That Caused Archival",
    is_current AS "Is Active in DB?",
    transaction_from::TIMESTAMP(0) AS "Original Insertion Time",
    transaction_to::TIMESTAMP(0) AS "Time of Deletion"
FROM insurance.v_customer_policy_timeline
WHERE customer_id = 1 AND policy_id = 1
ORDER BY version_number ASC;
