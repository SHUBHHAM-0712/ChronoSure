SET search_path TO insurance;

-- Attach versioning triggers to all tables
DROP TRIGGER IF EXISTS bitemporal_company_branch ON insurance.company_branch;
CREATE TRIGGER bitemporal_company_branch
BEFORE UPDATE OR DELETE ON insurance.company_branch
FOR EACH ROW EXECUTE FUNCTION insurance.bitemporal_versioning_fn();

DROP TRIGGER IF EXISTS bitemporal_agent ON insurance.agent;
CREATE TRIGGER bitemporal_agent
BEFORE UPDATE OR DELETE ON insurance.agent
FOR EACH ROW EXECUTE FUNCTION insurance.bitemporal_versioning_fn();

DROP TRIGGER IF EXISTS bitemporal_customer ON insurance.customer;
CREATE TRIGGER bitemporal_customer
BEFORE UPDATE OR DELETE ON insurance.customer
FOR EACH ROW EXECUTE FUNCTION insurance.bitemporal_versioning_fn();

DROP TRIGGER IF EXISTS bitemporal_policy ON insurance.policy;
CREATE TRIGGER bitemporal_policy
BEFORE UPDATE OR DELETE ON insurance.policy
FOR EACH ROW EXECUTE FUNCTION insurance.bitemporal_versioning_fn();

DROP TRIGGER IF EXISTS bitemporal_payment ON insurance.payment;
CREATE TRIGGER bitemporal_payment
BEFORE UPDATE OR DELETE ON insurance.payment
FOR EACH ROW EXECUTE FUNCTION insurance.bitemporal_versioning_fn();

DROP TRIGGER IF EXISTS bitemporal_claim ON insurance.claim;
CREATE TRIGGER bitemporal_claim
BEFORE UPDATE OR DELETE ON insurance.claim
FOR EACH ROW EXECUTE FUNCTION insurance.bitemporal_versioning_fn();

DROP TRIGGER IF EXISTS bitemporal_health_policy_detail ON insurance.health_policy_detail;
CREATE TRIGGER bitemporal_health_policy_detail
BEFORE UPDATE OR DELETE ON insurance.health_policy_detail
FOR EACH ROW EXECUTE FUNCTION insurance.bitemporal_versioning_fn();

DROP TRIGGER IF EXISTS bitemporal_car_policy_detail ON insurance.car_policy_detail;
CREATE TRIGGER bitemporal_car_policy_detail
BEFORE UPDATE OR DELETE ON insurance.car_policy_detail
FOR EACH ROW EXECUTE FUNCTION insurance.bitemporal_versioning_fn();

DROP TRIGGER IF EXISTS bitemporal_home_policy_detail ON insurance.home_policy_detail;
CREATE TRIGGER bitemporal_home_policy_detail
BEFORE UPDATE OR DELETE ON insurance.home_policy_detail
FOR EACH ROW EXECUTE FUNCTION insurance.bitemporal_versioning_fn();

DROP TRIGGER IF EXISTS bitemporal_customer_policy ON insurance.customer_policy;
CREATE TRIGGER bitemporal_customer_policy
BEFORE UPDATE OR DELETE ON insurance.customer_policy
FOR EACH ROW EXECUTE FUNCTION insurance.bitemporal_versioning_fn();

DROP TRIGGER IF EXISTS bitemporal_claim_policy ON insurance.claim_policy;
CREATE TRIGGER bitemporal_claim_policy
BEFORE UPDATE OR DELETE ON insurance.claim_policy
FOR EACH ROW EXECUTE FUNCTION insurance.bitemporal_versioning_fn();

