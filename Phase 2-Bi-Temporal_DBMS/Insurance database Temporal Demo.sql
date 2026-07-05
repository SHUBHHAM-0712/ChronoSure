SET search_path TO insurance;

-- ╔══════════════════════════════════════════════════════════════╗
-- ║  BI-TEMPORAL LIFECYCLE OPERATIONS                          ║
-- ║  Each operation triggers the versioning trigger, creating  ║
-- ║  a historical snapshot in the _history shadow table.       ║
-- ║  This demonstrates both Valid Time and Transaction Time.   ║
-- ╚══════════════════════════════════════════════════════════════╝

-- ═══════════════════════════════════════════════════════════════
-- CUSTOMER ADDRESS MIGRATIONS
-- Simulates customers moving to new cities over time.
-- Each UPDATE auto-archives the old record to customer_history
-- with version_number, valid_from/to, and transaction timestamps.
-- ═══════════════════════════════════════════════════════════════

-- Alice moves from Seattle to Manhattan for work
CALL insurance.update_customer_address(1, 'Manhattan', '10002');

-- Robert relocates to Brooklyn
CALL insurance.update_customer_address(3, 'Brooklyn', '11201');

-- John moves to Austin TX for tech job
CALL insurance.update_customer_address(5, 'Austin', '73301');

-- Linda retires to San Diego
CALL insurance.update_customer_address(8, 'San Diego', '92101');

-- Lisa moves to Nashville
CALL insurance.update_customer_address(12, 'Nashville', '37201');

-- Jessica relocates to Sacramento
CALL insurance.update_customer_address(15, 'Sacramento', '95814');

-- Karen moves to Tampa FL
CALL insurance.update_customer_address(20, 'Tampa', '33601');

-- Betty moves to Charlotte NC
CALL insurance.update_customer_address(25, 'Charlotte', '28201');

-- Sandra relocates for family
CALL insurance.update_customer_address(30, 'Raleigh', '27601');

-- Kimberly moves to Salt Lake City
CALL insurance.update_customer_address(35, 'Salt Lake City', '84101');

-- Donna moves to Tucson AZ
CALL insurance.update_customer_address(40, 'Tucson', '85701');

-- Amanda relocates to Omaha NE
CALL insurance.update_customer_address(45, 'Omaha', '68101');

-- Deborah moves to Pittsburgh
CALL insurance.update_customer_address(50, 'Pittsburgh', '15201');

-- Sharon moves to Las Vegas
CALL insurance.update_customer_address(55, 'Las Vegas', '89101');

-- Cynthia relocates to Richmond VA
CALL insurance.update_customer_address(60, 'Richmond', '23219');

-- Alice moves again from Manhattan to Jersey City
CALL insurance.update_customer_address(1, 'Jersey City', '07302');

-- John moves back to Dallas from Austin
CALL insurance.update_customer_address(5, 'Dallas', '75201');

-- Lisa moves from Nashville to Memphis
CALL insurance.update_customer_address(12, 'Memphis', '38101');

-- Karen moves from Tampa to Orlando
CALL insurance.update_customer_address(20, 'Orlando', '32801');

-- Sandra moves from Raleigh to Durham
CALL insurance.update_customer_address(30, 'Durham', '27701');

-- ═══════════════════════════════════════════════════════════════
-- CUSTOMER PHONE NUMBER UPDATES
-- Demonstrates another dimension of customer data versioning.
-- ═══════════════════════════════════════════════════════════════

CALL insurance.update_customer_phone(2, '555-781-5176');
CALL insurance.update_customer_phone(7, '555-483-3500');
CALL insurance.update_customer_phone(10, '555-803-8770');
CALL insurance.update_customer_phone(14, '555-168-2494');
CALL insurance.update_customer_phone(22, '555-951-2398');
CALL insurance.update_customer_phone(33, '555-195-8075');
CALL insurance.update_customer_phone(41, '555-198-7105');
CALL insurance.update_customer_phone(48, '555-931-3131');
CALL insurance.update_customer_phone(56, '555-669-1982');
CALL insurance.update_customer_phone(63, '555-700-6400');
CALL insurance.update_customer_phone(70, '555-786-3002');
CALL insurance.update_customer_phone(77, '555-520-6793');
CALL insurance.update_customer_phone(84, '555-994-7929');
CALL insurance.update_customer_phone(91, '555-988-1842');
CALL insurance.update_customer_phone(98, '555-394-6119');

-- ═══════════════════════════════════════════════════════════════
-- POLICY RENEWALS
-- When a policy is renewed, the old version is archived to
-- policy_history with its original end_date and premium,
-- while the active record gets the new terms.
-- ═══════════════════════════════════════════════════════════════

-- Policy 4: Premium increases from $1500.00 to $1605.00 (+7%)
CALL insurance.renew_policy(4, (CURRENT_DATE + INTERVAL '4 years')::DATE, 1605.0);

-- Policy 14: Premium increases from $3000.00 to $3270.00 (+9%)
CALL insurance.renew_policy(14, (CURRENT_DATE + INTERVAL '4 years')::DATE, 3270.0);

-- Policy 15: Premium increases from $1000.00 to $1100.00 (+10%)
CALL insurance.renew_policy(15, (CURRENT_DATE + INTERVAL '3 years')::DATE, 1100.0);

-- Policy 20: Premium increases from $1200.00 to $1284.00 (+7%)
CALL insurance.renew_policy(20, (CURRENT_DATE + INTERVAL '3 years')::DATE, 1284.0);

-- Policy 28: Premium increases from $2000.00 to $2280.00 (+14%)
CALL insurance.renew_policy(28, (CURRENT_DATE + INTERVAL '5 years')::DATE, 2280.0);

-- Policy 29: Premium increases from $1800.00 to $1998.00 (+11%)
CALL insurance.renew_policy(29, (CURRENT_DATE + INTERVAL '3 years')::DATE, 1998.0);

-- Policy 35: Premium increases from $2000.00 to $2140.00 (+7%)
CALL insurance.renew_policy(35, (CURRENT_DATE + INTERVAL '5 years')::DATE, 2140.0);

-- Policy 36: Premium increases from $800.00 to $920.00 (+15%)
CALL insurance.renew_policy(36, (CURRENT_DATE + INTERVAL '3 years')::DATE, 920.0);

-- Policy 45: Premium increases from $800.00 to $848.00 (+6%)
CALL insurance.renew_policy(45, (CURRENT_DATE + INTERVAL '5 years')::DATE, 848.0);

-- Policy 46: Premium increases from $3500.00 to $3955.00 (+13%)
CALL insurance.renew_policy(46, (CURRENT_DATE + INTERVAL '3 years')::DATE, 3955.0);

-- Policy 48: Premium increases from $1800.00 to $1998.00 (+11%)
CALL insurance.renew_policy(48, (CURRENT_DATE + INTERVAL '4 years')::DATE, 1998.0);

-- Policy 55: Premium increases from $2500.00 to $2800.00 (+12%)
CALL insurance.renew_policy(55, (CURRENT_DATE + INTERVAL '4 years')::DATE, 2800.0);

-- Policy 62: Premium increases from $800.00 to $856.00 (+7%)
CALL insurance.renew_policy(62, (CURRENT_DATE + INTERVAL '4 years')::DATE, 856.0);

-- Policy 65: Premium increases from $1800.00 to $1962.00 (+9%)
CALL insurance.renew_policy(65, (CURRENT_DATE + INTERVAL '5 years')::DATE, 1962.0);

-- Policy 72: Premium increases from $1500.00 to $1650.00 (+10%)
CALL insurance.renew_policy(72, (CURRENT_DATE + INTERVAL '5 years')::DATE, 1650.0);

-- Policy 74: Premium increases from $800.00 to $912.00 (+14%)
CALL insurance.renew_policy(74, (CURRENT_DATE + INTERVAL '3 years')::DATE, 912.0);

-- Policy 78: Premium increases from $800.00 to $840.00 (+5%)
CALL insurance.renew_policy(78, (CURRENT_DATE + INTERVAL '3 years')::DATE, 840.0);

-- Policy 79: Premium increases from $3500.00 to $3745.00 (+7%)
CALL insurance.renew_policy(79, (CURRENT_DATE + INTERVAL '5 years')::DATE, 3745.0);

-- Policy 80: Premium increases from $800.00 to $840.00 (+5%)
CALL insurance.renew_policy(80, (CURRENT_DATE + INTERVAL '5 years')::DATE, 840.0);

-- Policy 82: Premium increases from $2500.00 to $2650.00 (+6%)
CALL insurance.renew_policy(82, (CURRENT_DATE + INTERVAL '4 years')::DATE, 2650.0);

-- Policy 85: Premium increases from $1500.00 to $1680.00 (+12%)
CALL insurance.renew_policy(85, (CURRENT_DATE + INTERVAL '5 years')::DATE, 1680.0);

-- Policy 89: Premium increases from $1500.00 to $1665.00 (+11%)
CALL insurance.renew_policy(89, (CURRENT_DATE + INTERVAL '4 years')::DATE, 1665.0);

-- Policy 92: Premium increases from $1500.00 to $1710.00 (+14%)
CALL insurance.renew_policy(92, (CURRENT_DATE + INTERVAL '4 years')::DATE, 1710.0);

-- Policy 98: Premium increases from $3500.00 to $3885.00 (+11%)
CALL insurance.renew_policy(98, (CURRENT_DATE + INTERVAL '4 years')::DATE, 3885.0);

-- Policy 99: Premium increases from $1200.00 to $1296.00 (+8%)
CALL insurance.renew_policy(99, (CURRENT_DATE + INTERVAL '5 years')::DATE, 1296.0);

-- ═══════════════════════════════════════════════════════════════
-- POLICY AGENT TRANSFERS
-- When an agent leaves or a customer requests a transfer,
-- the policy is reassigned. The old agent assignment is
-- archived in policy_history.
-- ═══════════════════════════════════════════════════════════════

CALL insurance.transfer_policy(15, 2);
CALL insurance.transfer_policy(37, 8);
CALL insurance.transfer_policy(40, 13);
CALL insurance.transfer_policy(45, 20);
CALL insurance.transfer_policy(56, 2);
CALL insurance.transfer_policy(63, 1);
CALL insurance.transfer_policy(68, 7);
CALL insurance.transfer_policy(76, 10);
CALL insurance.transfer_policy(86, 7);
CALL insurance.transfer_policy(87, 25);

-- ═══════════════════════════════════════════════════════════════
-- POLICY CANCELLATIONS & CLOSURES
-- Demonstrates graceful policy closure and forced cancellations.
-- Old policy state is archived before modification.
-- ═══════════════════════════════════════════════════════════════

CALL insurance.close_policy(83);
CALL insurance.close_policy(84);
CALL insurance.close_policy(88);
CALL insurance.close_policy(89);
CALL insurance.close_policy(90);
CALL insurance.cancel_policy(60, 'Customer requested cancellation - switching provider');
CALL insurance.cancel_policy(64, 'Non-payment of premium for 90 days');
CALL insurance.cancel_policy(65, 'Fraudulent claim investigation');
CALL insurance.cancel_policy(73, 'Customer relocated internationally');
CALL insurance.cancel_policy(75, 'Vehicle sold - coverage no longer needed');

-- ═══════════════════════════════════════════════════════════════
-- RENEWAL PAYMENTS
-- After policies are renewed with new premiums, customers
-- make payments at the new premium amount.
-- ═══════════════════════════════════════════════════════════════

CALL insurance.record_payment(4, 4, 1605.00, 'BANK-508244633', CURRENT_DATE);
CALL insurance.record_payment(14, 14, 3270.00, 'BANK-671855941', CURRENT_DATE);
CALL insurance.record_payment(15, 15, 1100.00, 'BANK-855561271', CURRENT_DATE);
CALL insurance.record_payment(20, 20, 1284.00, 'BANK-347079497', CURRENT_DATE);
CALL insurance.record_payment(28, 28, 2280.00, 'BANK-637152602', CURRENT_DATE);
CALL insurance.record_payment(29, 29, 1998.00, 'BANK-699924859', CURRENT_DATE);
CALL insurance.record_payment(35, 35, 2140.00, 'BANK-994807263', CURRENT_DATE);
CALL insurance.record_payment(36, 36, 920.00, 'BANK-817311263', CURRENT_DATE);
CALL insurance.record_payment(45, 45, 848.00, 'BANK-965650861', CURRENT_DATE);
CALL insurance.record_payment(46, 46, 3955.00, 'BANK-480284107', CURRENT_DATE);
CALL insurance.record_payment(48, 48, 1998.00, 'BANK-177390472', CURRENT_DATE);
CALL insurance.record_payment(55, 55, 2800.00, 'BANK-526351920', CURRENT_DATE);
CALL insurance.record_payment(62, 62, 856.00, 'BANK-896760809', CURRENT_DATE);
CALL insurance.record_payment(65, 65, 1962.00, 'BANK-145421708', CURRENT_DATE);
CALL insurance.record_payment(72, 72, 1650.00, 'BANK-568387228', CURRENT_DATE);

-- ═══════════════════════════════════════════════════════════════
-- NEW CLAIMS AFTER TEMPORAL CHANGES
-- Filed after address changes and renewals have occurred,
-- demonstrating that bi-temporal history captures the exact
-- state of the customer/policy at the time of the claim.
-- ═══════════════════════════════════════════════════════════════

CALL insurance.register_claim(2, 5053.21, CURRENT_DATE);
CALL insurance.register_claim(5, 6670.45, CURRENT_DATE);
CALL insurance.register_claim(21, 14526.80, CURRENT_DATE);
CALL insurance.register_claim(26, 3406.22, CURRENT_DATE);
CALL insurance.register_claim(27, 14266.60, CURRENT_DATE);
CALL insurance.register_claim(28, 7441.36, CURRENT_DATE);
CALL insurance.register_claim(30, 8930.52, CURRENT_DATE);
CALL insurance.register_claim(37, 6065.94, CURRENT_DATE);
CALL insurance.register_claim(41, 7113.96, CURRENT_DATE);
CALL insurance.register_claim(45, 2482.08, CURRENT_DATE);

-- Approve half of the new claims
CALL insurance.approve_claim(31);
CALL insurance.approve_claim(32);
CALL insurance.approve_claim(33);
CALL insurance.approve_claim(34);
CALL insurance.approve_claim(35);

-- ═══════════════════════════════════════════════════════════════
-- BACKWARD COMPATIBILITY — LEGACY APP SIMULATION
-- A legacy application runs a raw DELETE, completely unaware
-- of bi-temporal architecture. The versioning trigger intercepts
-- this, archives the record, and performs a logical delete.
-- ═══════════════════════════════════════════════════════════════

-- Legacy app deletes a customer-policy link (triggers archival)
DELETE FROM insurance.customer_policy WHERE customer_id = 1 AND policy_id = 1;
