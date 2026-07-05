SET search_path TO insurance;

-- Temporal Views (DQL Structure)
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
