-- 
-- The automation triggers from Phase 5 will seamlessly intercept all updates made 
-- by these procedures and manage the historical versioning automatically.

SET search_path TO insurance;

-- Adding claim_status to support approve/reject workflows.
ALTER TABLE insurance.claim ADD COLUMN IF NOT EXISTS claim_status VARCHAR(50) NOT NULL DEFAULT 'PENDING';
ALTER TABLE insurance.claim_history ADD COLUMN IF NOT EXISTS claim_status VARCHAR(50);

CREATE OR REPLACE PROCEDURE insurance.create_customer(
    p_first_name VARCHAR,
    p_last_name VARCHAR,
    p_dob DATE,
    p_phone VARCHAR,
    p_email VARCHAR,
    p_city VARCHAR,
    p_zipcode VARCHAR,
    p_agent_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_first_name IS NULL OR p_last_name IS NULL THEN
        RAISE EXCEPTION 'First name and last name are required.';
    END IF;

    INSERT INTO insurance.customer (first_name, last_name, date_of_birth, phone_number, email, city, zipcode, agent_id, change_reason)
    VALUES (p_first_name, p_last_name, p_dob, p_phone, p_email, p_city, p_zipcode, p_agent_id, 'Customer Created');
END;
$$;

CREATE OR REPLACE PROCEDURE insurance.update_customer(
    p_customer_id INT,
    p_first_name VARCHAR DEFAULT NULL,
    p_last_name VARCHAR DEFAULT NULL,
    p_dob DATE DEFAULT NULL,
    p_email VARCHAR DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE insurance.customer 
    SET first_name = COALESCE(p_first_name, first_name),
        last_name = COALESCE(p_last_name, last_name),
        date_of_birth = COALESCE(p_dob, date_of_birth),
        email = COALESCE(p_email, email),
        change_reason = 'General Customer Update'
    WHERE customer_id = p_customer_id;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Customer ID % not found.', p_customer_id;
    END IF;
END;
$$;

CREATE OR REPLACE PROCEDURE insurance.update_customer_address(
    p_customer_id INT,
    p_city VARCHAR,
    p_zipcode VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE insurance.customer 
    SET city = p_city,
        zipcode = p_zipcode,
        change_reason = 'Address Update'
    WHERE customer_id = p_customer_id;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Customer ID % not found.', p_customer_id;
    END IF;
END;
$$;

CREATE OR REPLACE PROCEDURE insurance.update_customer_phone(
    p_customer_id INT,
    p_phone VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE insurance.customer 
    SET phone_number = p_phone,
        change_reason = 'Phone Update'
    WHERE customer_id = p_customer_id;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Customer ID % not found.', p_customer_id;
    END IF;
END;
$$;

-- 3. POLICY MANAGEMENT

CREATE OR REPLACE PROCEDURE insurance.create_policy(
    p_start_date DATE,
    p_end_date DATE,
    p_premium NUMERIC,
    p_coverage NUMERIC,
    p_branch_id INT,
    p_agent_id INT,
    p_customer_id INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_policy_id INT;
BEGIN
    IF p_end_date <= p_start_date THEN
        RAISE EXCEPTION 'End date must be strictly after start date.';
    END IF;
    IF p_premium < 0 OR p_coverage < 0 THEN
        RAISE EXCEPTION 'Premium and coverage must be non-negative.';
    END IF;

    -- Insert Policy
    INSERT INTO insurance.policy (start_date, end_date, premium, coverage, branch_id, agent_id, change_reason)
    VALUES (p_start_date, p_end_date, p_premium, p_coverage, p_branch_id, p_agent_id, 'Policy Created')
    RETURNING policy_id INTO v_policy_id;
    
    -- Bridge Link to Customer
    INSERT INTO insurance.customer_policy (customer_id, policy_id, change_reason)
    VALUES (p_customer_id, v_policy_id, 'Policy Created');
END;
$$;

CREATE OR REPLACE PROCEDURE insurance.update_policy(
    p_policy_id INT,
    p_premium NUMERIC DEFAULT NULL,
    p_coverage NUMERIC DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_premium < 0 OR p_coverage < 0 THEN
        RAISE EXCEPTION 'Premium and coverage must be non-negative.';
    END IF;

    UPDATE insurance.policy 
    SET premium = COALESCE(p_premium, premium),
        coverage = COALESCE(p_coverage, coverage),
        change_reason = 'General Policy Update'
    WHERE policy_id = p_policy_id;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Policy ID % not found.', p_policy_id;
    END IF;
END;
$$;

CREATE OR REPLACE PROCEDURE insurance.renew_policy(
    p_policy_id INT,
    p_new_end_date DATE,
    p_new_premium NUMERIC DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_current_end DATE;
BEGIN
    SELECT end_date INTO v_current_end FROM insurance.policy WHERE policy_id = p_policy_id;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Policy ID % not found.', p_policy_id;
    END IF;
    
    IF p_new_end_date <= v_current_end THEN
        RAISE EXCEPTION 'Renewal end date (%) must be strictly after current end date (%).', p_new_end_date, v_current_end;
    END IF;

    UPDATE insurance.policy 
    SET end_date = p_new_end_date,
        premium = COALESCE(p_new_premium, premium),
        change_reason = 'Policy Renewed'
    WHERE policy_id = p_policy_id;
END;
$$;

CREATE OR REPLACE PROCEDURE insurance.transfer_policy(
    p_policy_id INT,
    p_new_agent_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE insurance.policy 
    SET agent_id = p_new_agent_id,
        change_reason = 'Policy Transferred to New Agent'
    WHERE policy_id = p_policy_id;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Policy ID % not found.', p_policy_id;
    END IF;
END;
$$;

CREATE OR REPLACE PROCEDURE insurance.close_policy(
    p_policy_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE insurance.policy 
    SET end_date = CURRENT_DATE,
        change_reason = 'Policy Gracefully Closed'
    WHERE policy_id = p_policy_id;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Policy ID % not found.', p_policy_id;
    END IF;
END;
$$;

CREATE OR REPLACE PROCEDURE insurance.cancel_policy(
    p_policy_id INT,
    p_reason VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE insurance.policy 
    SET end_date = CURRENT_DATE,
        change_reason = 'Policy Cancelled: ' || p_reason
    WHERE policy_id = p_policy_id;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Policy ID % not found.', p_policy_id;
    END IF;
END;
$$;

-- 4. FINANCIAL & CLAIM OPERATIONS

CREATE OR REPLACE PROCEDURE insurance.register_claim(
    p_policy_id INT,
    p_amount_issued NUMERIC,
    p_date_issued DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_coverage NUMERIC;
    v_claim_id INT;
BEGIN
    -- Validate policy exists and check coverage limit
    SELECT coverage INTO v_coverage FROM insurance.policy WHERE policy_id = p_policy_id;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Policy ID % not found.', p_policy_id;
    END IF;

    IF p_amount_issued > v_coverage THEN
        RAISE EXCEPTION 'Claim amount (%) exceeds maximum policy coverage (%).', p_amount_issued, v_coverage;
    END IF;

    -- Insert Claim
    INSERT INTO insurance.claim (amount_issued, date_issued, claim_status, change_reason)
    VALUES (p_amount_issued, p_date_issued, 'PENDING', 'Claim Registered')
    RETURNING claim_id INTO v_claim_id;
    
    -- Bridge Link to Policy
    INSERT INTO insurance.claim_policy (claim_id, policy_id, change_reason)
    VALUES (v_claim_id, p_policy_id, 'Claim Registered');
END;
$$;

CREATE OR REPLACE PROCEDURE insurance.approve_claim(
    p_claim_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE insurance.claim 
    SET claim_status = 'APPROVED',
        change_reason = 'Claim Approved'
    WHERE claim_id = p_claim_id AND claim_status = 'PENDING';
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Claim ID % not found or not currently in PENDING state.', p_claim_id;
    END IF;
END;
$$;

CREATE OR REPLACE PROCEDURE insurance.reject_claim(
    p_claim_id INT,
    p_reason VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE insurance.claim 
    SET claim_status = 'REJECTED',
        change_reason = 'Claim Rejected: ' || p_reason
    WHERE claim_id = p_claim_id AND claim_status = 'PENDING';
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Claim ID % not found or not currently in PENDING state.', p_claim_id;
    END IF;
END;
$$;

CREATE OR REPLACE PROCEDURE insurance.record_payment(
    p_policy_id INT,
    p_customer_id INT,
    p_amount NUMERIC,
    p_bank_account VARCHAR,
    p_payment_date DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- NOTE: The payment_check_fn trigger (implemented in Phase 2/4) will inherently 
    -- validate that this amount exactly matches the policy premium. If it doesn't, 
    -- that trigger will RAISE EXCEPTION and gracefully abort this procedure transaction.
    
    INSERT INTO insurance.payment (bank_account_number, payment_date, amount, customer_id, policy_id, change_reason)
    VALUES (p_bank_account, p_payment_date, p_amount, p_customer_id, p_policy_id, 'Payment Recorded');
END;
$$;
