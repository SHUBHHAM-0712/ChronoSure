SET search_path TO insurance;

-- ======================================================================
-- PHASE 2 BASELINE SAMPLE DATA -- ~100 entries per entity
-- Generated with realistic US insurance industry data
-- ======================================================================

-- ======================================================================
-- 1. COMPANY BRANCHES (10 offices across the US)
-- ======================================================================
INSERT INTO insurance.company_branch (employee_count, city, zipcode) VALUES (50, 'Seattle', '98104');
INSERT INTO insurance.company_branch (employee_count, city, zipcode) VALUES (17, 'Portland', '97205');
INSERT INTO insurance.company_branch (employee_count, city, zipcode) VALUES (11, 'San Francisco', '94109');
INSERT INTO insurance.company_branch (employee_count, city, zipcode) VALUES (27, 'Los Angeles', '90001');
INSERT INTO insurance.company_branch (employee_count, city, zipcode) VALUES (25, 'Dallas', '75201');
INSERT INTO insurance.company_branch (employee_count, city, zipcode) VALUES (24, 'Houston', '77001');
INSERT INTO insurance.company_branch (employee_count, city, zipcode) VALUES (18, 'Chicago', '60601');
INSERT INTO insurance.company_branch (employee_count, city, zipcode) VALUES (16, 'New York', '10001');
INSERT INTO insurance.company_branch (employee_count, city, zipcode) VALUES (44, 'Boston', '02101');
INSERT INTO insurance.company_branch (employee_count, city, zipcode) VALUES (15, 'Denver', '80201');

-- ======================================================================
-- 2. INSURANCE AGENTS (30 -- 3 per branch)
-- ======================================================================
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('James', 'Smith', '555-704-7912', 'james.smith@insurancecorp.com', 'Seattle', '98104', 1);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Mary', 'Johnson', '555-132-1488', 'mary.johnson@insurancecorp.com', 'Seattle', '98104', 1);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Robert', 'Williams', '555-195-4582', 'robert.williams@insurancecorp.com', 'Seattle', '98104', 1);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Patricia', 'Brown', '555-338-9279', 'patricia.brown@insurancecorp.com', 'Portland', '97205', 2);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('John', 'Jones', '555-716-1434', 'john.jones@insurancecorp.com', 'Portland', '97205', 2);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Jennifer', 'Garcia', '555-674-4257', 'jennifer.garcia@insurancecorp.com', 'Portland', '97205', 2);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Michael', 'Miller', '555-833-9928', 'michael.miller@insurancecorp.com', 'San Francisco', '94109', 3);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Linda', 'Davis', '555-529-4611', 'linda.davis@insurancecorp.com', 'San Francisco', '94109', 3);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('David', 'Rodriguez', '555-559-5557', 'david.rodriguez@insurancecorp.com', 'San Francisco', '94109', 3);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Elizabeth', 'Martinez', '555-928-1106', 'elizabeth.martinez@insurancecorp.com', 'Los Angeles', '90001', 4);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('William', 'Hernandez', '555-877-3615', 'william.hernandez@insurancecorp.com', 'Los Angeles', '90001', 4);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Barbara', 'Lopez', '555-814-7924', 'barbara.lopez@insurancecorp.com', 'Los Angeles', '90001', 4);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Richard', 'Gonzalez', '555-448-5552', 'richard.gonzalez@insurancecorp.com', 'Dallas', '75201', 5);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Susan', 'Wilson', '555-259-4527', 'susan.wilson@insurancecorp.com', 'Dallas', '75201', 5);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Joseph', 'Anderson', '555-881-6514', 'joseph.anderson@insurancecorp.com', 'Dallas', '75201', 5);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Jessica', 'Thomas', '555-204-2519', 'jessica.thomas@insurancecorp.com', 'Houston', '77001', 6);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Thomas', 'Taylor', '555-489-2584', 'thomas.taylor@insurancecorp.com', 'Houston', '77001', 6);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Sarah', 'Moore', '555-467-6635', 'sarah.moore@insurancecorp.com', 'Houston', '77001', 6);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Christopher', 'Jackson', '555-718-5333', 'christopher.jackson@insurancecorp.com', 'Chicago', '60601', 7);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Karen', 'Martin', '555-926-1711', 'karen.martin@insurancecorp.com', 'Chicago', '60601', 7);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Daniel', 'Lee', '555-847-8527', 'daniel.lee@insurancecorp.com', 'Chicago', '60601', 7);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Lisa', 'Perez', '555-649-3045', 'lisa.perez@insurancecorp.com', 'New York', '10001', 8);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Matthew', 'Thompson', '555-487-2291', 'matthew.thompson@insurancecorp.com', 'New York', '10001', 8);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Nancy', 'White', '555-665-5803', 'nancy.white@insurancecorp.com', 'New York', '10001', 8);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Anthony', 'Harris', '555-949-6925', 'anthony.harris@insurancecorp.com', 'Boston', '02101', 9);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Betty', 'Sanchez', '555-691-4150', 'betty.sanchez@insurancecorp.com', 'Boston', '02101', 9);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Mark', 'Clark', '555-821-2139', 'mark.clark@insurancecorp.com', 'Boston', '02101', 9);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Margaret', 'Ramirez', '555-146-4733', 'margaret.ramirez@insurancecorp.com', 'Denver', '80201', 10);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Steven', 'Lewis', '555-891-5741', 'steven.lewis@insurancecorp.com', 'Denver', '80201', 10);
INSERT INTO insurance.agent (first_name, last_name, phone_number, email, city, zipcode, branch_id)
VALUES ('Sandra', 'Robinson', '555-181-4814', 'sandra.robinson@insurancecorp.com', 'Denver', '80201', 10);

-- ======================================================================
-- 3. CUSTOMERS (100 -- created via stored procedure)
-- ======================================================================
CALL insurance.create_customer('Jennifer', 'Davis', '1961-07-09', '555-564-6977', 'jennifer.davis@email.com', 'Seattle', '98104', 1);
CALL insurance.create_customer('Michael', 'Rodriguez', '1965-06-12', '555-314-5374', 'michael.rodriguez@email.com', 'Portland', '97205', 2);
CALL insurance.create_customer('Linda', 'Martinez', '1999-11-21', '555-173-3803', 'linda.martinez@email.com', 'San Francisco', '94109', 3);
CALL insurance.create_customer('David', 'Hernandez', '1989-12-08', '555-267-8573', 'david.hernandez@email.com', 'Los Angeles', '90001', 4);
CALL insurance.create_customer('Elizabeth', 'Lopez', '1979-05-21', '555-804-4598', 'elizabeth.lopez@email.com', 'Dallas', '75201', 5);
CALL insurance.create_customer('William', 'Gonzalez', '1998-06-27', '555-886-1916', 'william.gonzalez@email.com', 'Houston', '77001', 6);
CALL insurance.create_customer('Barbara', 'Wilson', '1969-01-26', '555-423-7572', 'barbara.wilson@email.com', 'Chicago', '60601', 7);
CALL insurance.create_customer('Richard', 'Anderson', '1972-02-07', '555-680-6155', 'richard.anderson@email.com', 'New York', '10001', 8);
CALL insurance.create_customer('Susan', 'Thomas', '1968-11-16', '555-505-8517', 'susan.thomas@email.com', 'Boston', '02101', 9);
CALL insurance.create_customer('Joseph', 'Taylor', '1964-05-05', '555-352-9830', 'joseph.taylor@email.com', 'Denver', '80201', 10);
CALL insurance.create_customer('Jessica', 'Moore', '1971-12-19', '555-538-7543', 'jessica.moore@email.com', 'Miami', '33101', 11);
CALL insurance.create_customer('Thomas', 'Jackson', '1978-04-05', '555-621-9085', 'thomas.jackson@email.com', 'Atlanta', '30301', 12);
CALL insurance.create_customer('Sarah', 'Martin', '1960-01-28', '555-212-3504', 'sarah.martin@email.com', 'Phoenix', '85001', 13);
CALL insurance.create_customer('Christopher', 'Lee', '1995-03-26', '555-796-7916', 'christopher.lee@email.com', 'Minneapolis', '55401', 14);
CALL insurance.create_customer('Karen', 'Perez', '1993-02-13', '555-490-8668', 'karen.perez@email.com', 'Detroit', '48201', 15);
CALL insurance.create_customer('Daniel', 'Thompson', '1988-05-18', '555-981-1188', 'daniel.thompson@email.com', 'Seattle', '98104', 16);
CALL insurance.create_customer('Lisa', 'White', '1998-12-04', '555-798-9797', 'lisa.white@email.com', 'Portland', '97205', 17);
CALL insurance.create_customer('Matthew', 'Harris', '1972-11-11', '555-214-5808', 'matthew.harris@email.com', 'San Francisco', '94109', 18);
CALL insurance.create_customer('Nancy', 'Sanchez', '1982-03-15', '555-103-5315', 'nancy.sanchez@email.com', 'Los Angeles', '90001', 19);
CALL insurance.create_customer('Anthony', 'Clark', '1987-03-17', '555-208-5889', 'anthony.clark@email.com', 'Dallas', '75201', 20);
CALL insurance.create_customer('Betty', 'Ramirez', '1995-09-20', '555-303-3504', 'betty.ramirez@email.com', 'Houston', '77001', 21);
CALL insurance.create_customer('Mark', 'Lewis', '1978-03-18', '555-897-9689', 'mark.lewis@email.com', 'Chicago', '60601', 22);
CALL insurance.create_customer('Margaret', 'Robinson', '1955-10-11', '555-600-1319', 'margaret.robinson@email.com', 'New York', '10001', 23);
CALL insurance.create_customer('Steven', 'Walker', '1962-06-27', '555-926-6038', 'steven.walker@email.com', 'Boston', '02101', 24);
CALL insurance.create_customer('Sandra', 'Young', '1970-01-08', '555-999-2290', 'sandra.young@email.com', 'Denver', '80201', 25);
CALL insurance.create_customer('Andrew', 'Allen', '1960-12-16', '555-935-2133', 'andrew.allen@email.com', 'Miami', '33101', 26);
CALL insurance.create_customer('Ashley', 'King', '1989-03-05', '555-775-8787', 'ashley.king@email.com', 'Atlanta', '30301', 27);
CALL insurance.create_customer('Paul', 'Wright', '1990-03-09', '555-640-7932', 'paul.wright@email.com', 'Phoenix', '85001', 28);
CALL insurance.create_customer('Dorothy', 'Scott', '1968-09-25', '555-847-4295', 'dorothy.scott@email.com', 'Minneapolis', '55401', 29);
CALL insurance.create_customer('Joshua', 'Torres', '2000-05-13', '555-787-7118', 'joshua.torres@email.com', 'Detroit', '48201', 30);
CALL insurance.create_customer('Kimberly', 'Nguyen', '1983-09-15', '555-223-5061', 'kimberly.nguyen@email.com', 'Seattle', '98104', 1);
CALL insurance.create_customer('Kenneth', 'Hill', '1969-02-11', '555-121-4770', 'kenneth.hill@email.com', 'Portland', '97205', 2);
CALL insurance.create_customer('Emily', 'Flores', '1992-04-01', '555-172-1964', 'emily.flores@email.com', 'San Francisco', '94109', 3);
CALL insurance.create_customer('Kevin', 'Green', '1969-02-02', '555-980-6413', 'kevin.green@email.com', 'Los Angeles', '90001', 4);
CALL insurance.create_customer('Donna', 'Adams', '1959-09-08', '555-385-8953', 'donna.adams@email.com', 'Dallas', '75201', 5);
CALL insurance.create_customer('Brian', 'Nelson', '1968-09-05', '555-840-8744', 'brian.nelson@email.com', 'Houston', '77001', 6);
CALL insurance.create_customer('Michelle', 'Baker', '1970-08-26', '555-516-4119', 'michelle.baker@email.com', 'Chicago', '60601', 7);
CALL insurance.create_customer('George', 'Hall', '1961-02-22', '555-541-6804', 'george.hall@email.com', 'New York', '10001', 8);
CALL insurance.create_customer('Carol', 'Rivera', '1982-07-15', '555-984-1887', 'carol.rivera@email.com', 'Boston', '02101', 9);
CALL insurance.create_customer('Timothy', 'Campbell', '1998-11-21', '555-200-1993', 'timothy.campbell@email.com', 'Denver', '80201', 10);
CALL insurance.create_customer('Amanda', 'Mitchell', '1980-12-11', '555-919-2790', 'amanda.mitchell@email.com', 'Miami', '33101', 11);
CALL insurance.create_customer('Ronald', 'Carter', '1970-04-07', '555-649-8350', 'ronald.carter@email.com', 'Atlanta', '30301', 12);
CALL insurance.create_customer('Melissa', 'Roberts', '1963-07-06', '555-385-8579', 'melissa.roberts@email.com', 'Phoenix', '85001', 13);
CALL insurance.create_customer('Edward', 'Phillips', '1970-02-15', '555-927-2604', 'edward.phillips@email.com', 'Minneapolis', '55401', 14);
CALL insurance.create_customer('Deborah', 'Evans', '1958-11-18', '555-956-1241', 'deborah.evans@email.com', 'Detroit', '48201', 15);
CALL insurance.create_customer('Jason', 'Turner', '1960-04-06', '555-516-8956', 'jason.turner@email.com', 'Seattle', '98104', 16);
CALL insurance.create_customer('Stephanie', 'Diaz', '1985-04-28', '555-510-1960', 'stephanie.diaz@email.com', 'Portland', '97205', 17);
CALL insurance.create_customer('Jeffrey', 'Parker', '1965-07-01', '555-499-5345', 'jeffrey.parker@email.com', 'San Francisco', '94109', 18);
CALL insurance.create_customer('Rebecca', 'Cruz', '1984-05-14', '555-813-8973', 'rebecca.cruz@email.com', 'Los Angeles', '90001', 19);
CALL insurance.create_customer('Ryan', 'Edwards', '1964-04-10', '555-322-1958', 'ryan.edwards@email.com', 'Dallas', '75201', 20);
CALL insurance.create_customer('Sharon', 'Collins', '1992-12-18', '555-162-6138', 'sharon.collins@email.com', 'Houston', '77001', 21);
CALL insurance.create_customer('Jacob', 'Reyes', '1958-01-19', '555-588-9238', 'jacob.reyes@email.com', 'Chicago', '60601', 22);
CALL insurance.create_customer('Laura', 'Stewart', '1988-03-02', '555-620-2312', 'laura.stewart@email.com', 'New York', '10001', 23);
CALL insurance.create_customer('Gary', 'Morris', '1966-02-20', '555-169-4853', 'gary.morris@email.com', 'Boston', '02101', 24);
CALL insurance.create_customer('Cynthia', 'Morales', '1980-02-19', '555-352-1651', 'cynthia.morales@email.com', 'Denver', '80201', 25);
CALL insurance.create_customer('Nicholas', 'Murphy', '1994-02-14', '555-773-9565', 'nicholas.murphy@email.com', 'Miami', '33101', 26);
CALL insurance.create_customer('Kathleen', 'Cook', '1975-05-07', '555-785-6147', 'kathleen.cook@email.com', 'Atlanta', '30301', 27);
CALL insurance.create_customer('Eric', 'Rogers', '1970-05-13', '555-234-5915', 'eric.rogers@email.com', 'Phoenix', '85001', 28);
CALL insurance.create_customer('Amy', 'Gutierrez', '1984-06-25', '555-174-1152', 'amy.gutierrez@email.com', 'Minneapolis', '55401', 29);
CALL insurance.create_customer('Jonathan', 'Ortiz', '1984-10-19', '555-202-2200', 'jonathan.ortiz@email.com', 'Detroit', '48201', 30);
CALL insurance.create_customer('Angela', 'Morgan', '1989-04-17', '555-371-3170', 'angela.morgan@email.com', 'Seattle', '98104', 1);
CALL insurance.create_customer('Stephen', 'Cooper', '1977-02-08', '555-478-5669', 'stephen.cooper@email.com', 'Portland', '97205', 2);
CALL insurance.create_customer('Shirley', 'Peterson', '1965-08-27', '555-656-5956', 'shirley.peterson@email.com', 'San Francisco', '94109', 3);
CALL insurance.create_customer('Larry', 'Bailey', '1994-11-17', '555-108-5905', 'larry.bailey@email.com', 'Los Angeles', '90001', 4);
CALL insurance.create_customer('Anna', 'Reed', '1997-02-05', '555-370-2891', 'anna.reed@email.com', 'Dallas', '75201', 5);
CALL insurance.create_customer('Justin', 'Kelly', '1961-12-18', '555-259-5462', 'justin.kelly@email.com', 'Houston', '77001', 6);
CALL insurance.create_customer('Brenda', 'Howard', '1973-10-07', '555-834-6617', 'brenda.howard@email.com', 'Chicago', '60601', 7);
CALL insurance.create_customer('Scott', 'Ramos', '1968-11-21', '555-973-5325', 'scott.ramos@email.com', 'New York', '10001', 8);
CALL insurance.create_customer('Pamela', 'Kim', '1987-08-09', '555-966-1832', 'pamela.kim@email.com', 'Boston', '02101', 9);
CALL insurance.create_customer('Brandon', 'Cox', '1960-11-14', '555-949-5533', 'brandon.cox@email.com', 'Denver', '80201', 10);
CALL insurance.create_customer('Emma', 'Ward', '1957-01-11', '555-889-3143', 'emma.ward@email.com', 'Miami', '33101', 11);
CALL insurance.create_customer('Benjamin', 'Richardson', '1995-05-06', '555-859-8239', 'benjamin.richardson@email.com', 'Atlanta', '30301', 12);
CALL insurance.create_customer('Nicole', 'Watson', '1990-12-14', '555-674-1158', 'nicole.watson@email.com', 'Phoenix', '85001', 13);
CALL insurance.create_customer('Samuel', 'Brooks', '1962-02-23', '555-252-9938', 'samuel.brooks@email.com', 'Minneapolis', '55401', 14);
CALL insurance.create_customer('Helen', 'Chavez', '1957-06-19', '555-665-3426', 'helen.chavez@email.com', 'Detroit', '48201', 15);
CALL insurance.create_customer('Gregory', 'Wood', '1982-03-02', '555-415-6974', 'gregory.wood@email.com', 'Seattle', '98104', 16);
CALL insurance.create_customer('Samantha', 'James', '1957-06-07', '555-798-5088', 'samantha.james@email.com', 'Portland', '97205', 17);
CALL insurance.create_customer('Alexander', 'Bennett', '1997-02-12', '555-898-7658', 'alexander.bennett@email.com', 'San Francisco', '94109', 18);
CALL insurance.create_customer('Katherine', 'Gray', '1994-12-05', '555-342-3662', 'katherine.gray@email.com', 'Los Angeles', '90001', 19);
CALL insurance.create_customer('Patrick', 'Mendoza', '1966-07-01', '555-283-6442', 'patrick.mendoza@email.com', 'Dallas', '75201', 20);
CALL insurance.create_customer('Christine', 'Ruiz', '1981-11-28', '555-852-5065', 'christine.ruiz@email.com', 'Houston', '77001', 21);
CALL insurance.create_customer('Frank', 'Hughes', '1972-03-26', '555-818-2771', 'frank.hughes@email.com', 'Chicago', '60601', 22);
CALL insurance.create_customer('Debra', 'Price', '1979-01-28', '555-581-4644', 'debra.price@email.com', 'New York', '10001', 23);
CALL insurance.create_customer('Raymond', 'Alvarez', '1967-08-12', '555-412-4728', 'raymond.alvarez@email.com', 'Boston', '02101', 24);
CALL insurance.create_customer('Rachel', 'Castillo', '1969-01-22', '555-297-7528', 'rachel.castillo@email.com', 'Denver', '80201', 25);
CALL insurance.create_customer('Jack', 'Sanders', '1976-05-28', '555-171-5573', 'jack.sanders@email.com', 'Miami', '33101', 26);
CALL insurance.create_customer('Carolyn', 'Patel', '1977-11-17', '555-509-9785', 'carolyn.patel@email.com', 'Atlanta', '30301', 27);
CALL insurance.create_customer('Dennis', 'Myers', '1976-01-04', '555-998-5279', 'dennis.myers@email.com', 'Phoenix', '85001', 28);
CALL insurance.create_customer('Janet', 'Long', '1966-10-09', '555-139-2776', 'janet.long@email.com', 'Minneapolis', '55401', 29);
CALL insurance.create_customer('Jerry', 'Ross', '1993-07-12', '555-846-6139', 'jerry.ross@email.com', 'Detroit', '48201', 30);
CALL insurance.create_customer('Catherine', 'Foster', '1982-10-17', '555-218-7311', 'catherine.foster@email.com', 'Seattle', '98104', 1);
CALL insurance.create_customer('Tyler', 'Jimenez', '1991-04-09', '555-145-8144', 'tyler.jimenez@email.com', 'Portland', '97205', 2);
CALL insurance.create_customer('Maria', 'Powell', '1955-09-26', '555-651-4228', 'maria.powell@email.com', 'San Francisco', '94109', 3);
CALL insurance.create_customer('Aaron', 'Smith', '1978-07-03', '555-780-6409', 'aaron.smith@email.com', 'Los Angeles', '90001', 4);
CALL insurance.create_customer('Heather', 'Johnson', '1994-06-22', '555-968-3041', 'heather.johnson@email.com', 'Dallas', '75201', 5);
CALL insurance.create_customer('James', 'Williams', '1974-09-10', '555-782-7691', 'james.williams@email.com', 'Houston', '77001', 6);
CALL insurance.create_customer('Mary', 'Brown', '1975-07-23', '555-402-3085', 'mary.brown@email.com', 'Chicago', '60601', 7);
CALL insurance.create_customer('Robert', 'Jones', '1967-07-22', '555-488-3851', 'robert.jones@email.com', 'New York', '10001', 8);
CALL insurance.create_customer('Patricia', 'Garcia', '1994-10-10', '555-515-9977', 'patricia.garcia@email.com', 'Boston', '02101', 9);
CALL insurance.create_customer('John', 'Miller', '1955-05-10', '555-315-8043', 'john.miller@email.com', 'Denver', '80201', 10);

-- ======================================================================
-- 4. INSURANCE POLICIES (100 -- one per customer)
--    Mix of Health, Auto, and Home policies
-- ======================================================================
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '365 days')::DATE, (CURRENT_DATE - INTERVAL '365 days' + INTERVAL '12 months')::DATE, 3500.00, 200000.00, 1, 1, 1);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '256 days')::DATE, (CURRENT_DATE - INTERVAL '256 days' + INTERVAL '12 months')::DATE, 2500.00, 500000.00, 1, 2, 2);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '116 days')::DATE, (CURRENT_DATE - INTERVAL '116 days' + INTERVAL '6 months')::DATE, 3000.00, 150000.00, 1, 3, 3);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '77 days')::DATE, (CURRENT_DATE - INTERVAL '77 days' + INTERVAL '12 months')::DATE, 1500.00, 200000.00, 2, 4, 4);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '131 days')::DATE, (CURRENT_DATE - INTERVAL '131 days' + INTERVAL '12 months')::DATE, 1500.00, 100000.00, 2, 5, 5);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '155 days')::DATE, (CURRENT_DATE - INTERVAL '155 days' + INTERVAL '12 months')::DATE, 600.00, 25000.00, 2, 6, 6);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '67 days')::DATE, (CURRENT_DATE - INTERVAL '67 days' + INTERVAL '12 months')::DATE, 3500.00, 500000.00, 3, 7, 7);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '226 days')::DATE, (CURRENT_DATE - INTERVAL '226 days' + INTERVAL '12 months')::DATE, 2000.00, 100000.00, 3, 8, 8);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '105 days')::DATE, (CURRENT_DATE - INTERVAL '105 days' + INTERVAL '6 months')::DATE, 2000.00, 100000.00, 3, 9, 9);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '142 days')::DATE, (CURRENT_DATE - INTERVAL '142 days' + INTERVAL '12 months')::DATE, 800.00, 250000.00, 4, 10, 10);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '55 days')::DATE, (CURRENT_DATE - INTERVAL '55 days' + INTERVAL '24 months')::DATE, 3000.00, 150000.00, 4, 11, 11);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '263 days')::DATE, (CURRENT_DATE - INTERVAL '263 days' + INTERVAL '12 months')::DATE, 1200.00, 50000.00, 4, 12, 12);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '256 days')::DATE, (CURRENT_DATE - INTERVAL '256 days' + INTERVAL '24 months')::DATE, 2500.00, 200000.00, 5, 13, 13);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '310 days')::DATE, (CURRENT_DATE - INTERVAL '310 days' + INTERVAL '12 months')::DATE, 3000.00, 150000.00, 5, 14, 14);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '260 days')::DATE, (CURRENT_DATE - INTERVAL '260 days' + INTERVAL '12 months')::DATE, 1000.00, 500000.00, 5, 15, 15);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '296 days')::DATE, (CURRENT_DATE - INTERVAL '296 days' + INTERVAL '12 months')::DATE, 1200.00, 150000.00, 6, 16, 16);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '255 days')::DATE, (CURRENT_DATE - INTERVAL '255 days' + INTERVAL '6 months')::DATE, 1200.00, 150000.00, 6, 17, 17);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '169 days')::DATE, (CURRENT_DATE - INTERVAL '169 days' + INTERVAL '12 months')::DATE, 1500.00, 100000.00, 6, 18, 18);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '100 days')::DATE, (CURRENT_DATE - INTERVAL '100 days' + INTERVAL '12 months')::DATE, 1800.00, 50000.00, 7, 19, 19);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '108 days')::DATE, (CURRENT_DATE - INTERVAL '108 days' + INTERVAL '12 months')::DATE, 1200.00, 250000.00, 7, 20, 20);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '238 days')::DATE, (CURRENT_DATE - INTERVAL '238 days' + INTERVAL '12 months')::DATE, 800.00, 250000.00, 7, 21, 21);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '242 days')::DATE, (CURRENT_DATE - INTERVAL '242 days' + INTERVAL '6 months')::DATE, 3000.00, 150000.00, 8, 22, 22);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '229 days')::DATE, (CURRENT_DATE - INTERVAL '229 days' + INTERVAL '24 months')::DATE, 1200.00, 250000.00, 8, 23, 23);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '274 days')::DATE, (CURRENT_DATE - INTERVAL '274 days' + INTERVAL '6 months')::DATE, 600.00, 250000.00, 8, 24, 24);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '229 days')::DATE, (CURRENT_DATE - INTERVAL '229 days' + INTERVAL '12 months')::DATE, 1800.00, 150000.00, 9, 25, 25);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '309 days')::DATE, (CURRENT_DATE - INTERVAL '309 days' + INTERVAL '24 months')::DATE, 3000.00, 250000.00, 9, 26, 26);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '142 days')::DATE, (CURRENT_DATE - INTERVAL '142 days' + INTERVAL '12 months')::DATE, 1200.00, 500000.00, 9, 27, 27);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '44 days')::DATE, (CURRENT_DATE - INTERVAL '44 days' + INTERVAL '12 months')::DATE, 2000.00, 500000.00, 10, 28, 28);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '114 days')::DATE, (CURRENT_DATE - INTERVAL '114 days' + INTERVAL '12 months')::DATE, 1800.00, 250000.00, 10, 29, 29);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '231 days')::DATE, (CURRENT_DATE - INTERVAL '231 days' + INTERVAL '24 months')::DATE, 1000.00, 25000.00, 10, 30, 30);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '43 days')::DATE, (CURRENT_DATE - INTERVAL '43 days' + INTERVAL '6 months')::DATE, 3500.00, 250000.00, 1, 1, 31);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '266 days')::DATE, (CURRENT_DATE - INTERVAL '266 days' + INTERVAL '12 months')::DATE, 2000.00, 75000.00, 1, 2, 32);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '224 days')::DATE, (CURRENT_DATE - INTERVAL '224 days' + INTERVAL '12 months')::DATE, 600.00, 150000.00, 1, 3, 33);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '197 days')::DATE, (CURRENT_DATE - INTERVAL '197 days' + INTERVAL '12 months')::DATE, 1200.00, 500000.00, 2, 4, 34);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '245 days')::DATE, (CURRENT_DATE - INTERVAL '245 days' + INTERVAL '12 months')::DATE, 2000.00, 150000.00, 2, 5, 35);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '39 days')::DATE, (CURRENT_DATE - INTERVAL '39 days' + INTERVAL '24 months')::DATE, 800.00, 500000.00, 2, 6, 36);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '144 days')::DATE, (CURRENT_DATE - INTERVAL '144 days' + INTERVAL '6 months')::DATE, 600.00, 200000.00, 3, 7, 37);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '156 days')::DATE, (CURRENT_DATE - INTERVAL '156 days' + INTERVAL '12 months')::DATE, 600.00, 25000.00, 3, 8, 38);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '152 days')::DATE, (CURRENT_DATE - INTERVAL '152 days' + INTERVAL '12 months')::DATE, 600.00, 75000.00, 3, 9, 39);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '318 days')::DATE, (CURRENT_DATE - INTERVAL '318 days' + INTERVAL '12 months')::DATE, 2500.00, 50000.00, 4, 10, 40);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '218 days')::DATE, (CURRENT_DATE - INTERVAL '218 days' + INTERVAL '12 months')::DATE, 2500.00, 150000.00, 4, 11, 41);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '88 days')::DATE, (CURRENT_DATE - INTERVAL '88 days' + INTERVAL '12 months')::DATE, 3500.00, 200000.00, 4, 12, 42);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '326 days')::DATE, (CURRENT_DATE - INTERVAL '326 days' + INTERVAL '6 months')::DATE, 1500.00, 50000.00, 5, 13, 43);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '233 days')::DATE, (CURRENT_DATE - INTERVAL '233 days' + INTERVAL '12 months')::DATE, 1500.00, 250000.00, 5, 14, 44);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '82 days')::DATE, (CURRENT_DATE - INTERVAL '82 days' + INTERVAL '12 months')::DATE, 800.00, 100000.00, 5, 15, 45);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '91 days')::DATE, (CURRENT_DATE - INTERVAL '91 days' + INTERVAL '24 months')::DATE, 3500.00, 500000.00, 6, 16, 46);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '302 days')::DATE, (CURRENT_DATE - INTERVAL '302 days' + INTERVAL '12 months')::DATE, 600.00, 200000.00, 6, 17, 47);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '289 days')::DATE, (CURRENT_DATE - INTERVAL '289 days' + INTERVAL '12 months')::DATE, 1800.00, 50000.00, 6, 18, 48);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '280 days')::DATE, (CURRENT_DATE - INTERVAL '280 days' + INTERVAL '6 months')::DATE, 600.00, 250000.00, 7, 19, 49);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '355 days')::DATE, (CURRENT_DATE - INTERVAL '355 days' + INTERVAL '12 months')::DATE, 2000.00, 200000.00, 7, 20, 50);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '120 days')::DATE, (CURRENT_DATE - INTERVAL '120 days' + INTERVAL '24 months')::DATE, 1000.00, 250000.00, 7, 21, 51);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '268 days')::DATE, (CURRENT_DATE - INTERVAL '268 days' + INTERVAL '12 months')::DATE, 1500.00, 500000.00, 8, 22, 52);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '195 days')::DATE, (CURRENT_DATE - INTERVAL '195 days' + INTERVAL '12 months')::DATE, 3500.00, 100000.00, 8, 23, 53);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '260 days')::DATE, (CURRENT_DATE - INTERVAL '260 days' + INTERVAL '12 months')::DATE, 800.00, 150000.00, 8, 24, 54);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '202 days')::DATE, (CURRENT_DATE - INTERVAL '202 days' + INTERVAL '6 months')::DATE, 2500.00, 250000.00, 9, 25, 55);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '123 days')::DATE, (CURRENT_DATE - INTERVAL '123 days' + INTERVAL '12 months')::DATE, 2500.00, 200000.00, 9, 26, 56);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '162 days')::DATE, (CURRENT_DATE - INTERVAL '162 days' + INTERVAL '12 months')::DATE, 1200.00, 200000.00, 9, 27, 57);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '314 days')::DATE, (CURRENT_DATE - INTERVAL '314 days' + INTERVAL '6 months')::DATE, 1500.00, 150000.00, 10, 28, 58);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '73 days')::DATE, (CURRENT_DATE - INTERVAL '73 days' + INTERVAL '12 months')::DATE, 3000.00, 75000.00, 10, 29, 59);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '314 days')::DATE, (CURRENT_DATE - INTERVAL '314 days' + INTERVAL '12 months')::DATE, 2000.00, 500000.00, 10, 30, 60);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '259 days')::DATE, (CURRENT_DATE - INTERVAL '259 days' + INTERVAL '6 months')::DATE, 2500.00, 500000.00, 1, 1, 61);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '143 days')::DATE, (CURRENT_DATE - INTERVAL '143 days' + INTERVAL '12 months')::DATE, 800.00, 150000.00, 1, 2, 62);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '327 days')::DATE, (CURRENT_DATE - INTERVAL '327 days' + INTERVAL '12 months')::DATE, 1200.00, 150000.00, 1, 3, 63);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '247 days')::DATE, (CURRENT_DATE - INTERVAL '247 days' + INTERVAL '24 months')::DATE, 2500.00, 200000.00, 2, 4, 64);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '262 days')::DATE, (CURRENT_DATE - INTERVAL '262 days' + INTERVAL '12 months')::DATE, 1800.00, 200000.00, 2, 5, 65);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '148 days')::DATE, (CURRENT_DATE - INTERVAL '148 days' + INTERVAL '6 months')::DATE, 1500.00, 150000.00, 2, 6, 66);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '91 days')::DATE, (CURRENT_DATE - INTERVAL '91 days' + INTERVAL '24 months')::DATE, 1200.00, 200000.00, 3, 7, 67);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '140 days')::DATE, (CURRENT_DATE - INTERVAL '140 days' + INTERVAL '12 months')::DATE, 1000.00, 100000.00, 3, 8, 68);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '81 days')::DATE, (CURRENT_DATE - INTERVAL '81 days' + INTERVAL '12 months')::DATE, 1500.00, 150000.00, 3, 9, 69);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '214 days')::DATE, (CURRENT_DATE - INTERVAL '214 days' + INTERVAL '12 months')::DATE, 1500.00, 100000.00, 4, 10, 70);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '303 days')::DATE, (CURRENT_DATE - INTERVAL '303 days' + INTERVAL '12 months')::DATE, 1500.00, 25000.00, 4, 11, 71);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '57 days')::DATE, (CURRENT_DATE - INTERVAL '57 days' + INTERVAL '24 months')::DATE, 1500.00, 25000.00, 4, 12, 72);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '356 days')::DATE, (CURRENT_DATE - INTERVAL '356 days' + INTERVAL '12 months')::DATE, 1500.00, 75000.00, 5, 13, 73);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '323 days')::DATE, (CURRENT_DATE - INTERVAL '323 days' + INTERVAL '12 months')::DATE, 800.00, 25000.00, 5, 14, 74);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '255 days')::DATE, (CURRENT_DATE - INTERVAL '255 days' + INTERVAL '12 months')::DATE, 2500.00, 500000.00, 5, 15, 75);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '159 days')::DATE, (CURRENT_DATE - INTERVAL '159 days' + INTERVAL '12 months')::DATE, 1000.00, 25000.00, 6, 16, 76);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '235 days')::DATE, (CURRENT_DATE - INTERVAL '235 days' + INTERVAL '12 months')::DATE, 800.00, 50000.00, 6, 17, 77);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '107 days')::DATE, (CURRENT_DATE - INTERVAL '107 days' + INTERVAL '12 months')::DATE, 800.00, 25000.00, 6, 18, 78);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '73 days')::DATE, (CURRENT_DATE - INTERVAL '73 days' + INTERVAL '12 months')::DATE, 3500.00, 100000.00, 7, 19, 79);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '340 days')::DATE, (CURRENT_DATE - INTERVAL '340 days' + INTERVAL '24 months')::DATE, 800.00, 250000.00, 7, 20, 80);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '297 days')::DATE, (CURRENT_DATE - INTERVAL '297 days' + INTERVAL '12 months')::DATE, 3500.00, 75000.00, 7, 21, 81);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '182 days')::DATE, (CURRENT_DATE - INTERVAL '182 days' + INTERVAL '24 months')::DATE, 2500.00, 500000.00, 8, 22, 82);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '321 days')::DATE, (CURRENT_DATE - INTERVAL '321 days' + INTERVAL '24 months')::DATE, 2000.00, 150000.00, 8, 23, 83);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '136 days')::DATE, (CURRENT_DATE - INTERVAL '136 days' + INTERVAL '12 months')::DATE, 600.00, 50000.00, 8, 24, 84);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '110 days')::DATE, (CURRENT_DATE - INTERVAL '110 days' + INTERVAL '12 months')::DATE, 1500.00, 50000.00, 9, 25, 85);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '110 days')::DATE, (CURRENT_DATE - INTERVAL '110 days' + INTERVAL '6 months')::DATE, 1000.00, 50000.00, 9, 26, 86);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '334 days')::DATE, (CURRENT_DATE - INTERVAL '334 days' + INTERVAL '12 months')::DATE, 2000.00, 500000.00, 9, 27, 87);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '148 days')::DATE, (CURRENT_DATE - INTERVAL '148 days' + INTERVAL '12 months')::DATE, 1500.00, 25000.00, 10, 28, 88);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '66 days')::DATE, (CURRENT_DATE - INTERVAL '66 days' + INTERVAL '12 months')::DATE, 1500.00, 500000.00, 10, 29, 89);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '247 days')::DATE, (CURRENT_DATE - INTERVAL '247 days' + INTERVAL '6 months')::DATE, 1500.00, 100000.00, 10, 30, 90);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '361 days')::DATE, (CURRENT_DATE - INTERVAL '361 days' + INTERVAL '12 months')::DATE, 3000.00, 75000.00, 1, 1, 91);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '66 days')::DATE, (CURRENT_DATE - INTERVAL '66 days' + INTERVAL '6 months')::DATE, 1500.00, 75000.00, 1, 2, 92);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '334 days')::DATE, (CURRENT_DATE - INTERVAL '334 days' + INTERVAL '24 months')::DATE, 1000.00, 150000.00, 1, 3, 93);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '93 days')::DATE, (CURRENT_DATE - INTERVAL '93 days' + INTERVAL '12 months')::DATE, 1500.00, 500000.00, 2, 4, 94);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '169 days')::DATE, (CURRENT_DATE - INTERVAL '169 days' + INTERVAL '24 months')::DATE, 1500.00, 250000.00, 2, 5, 95);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '254 days')::DATE, (CURRENT_DATE - INTERVAL '254 days' + INTERVAL '6 months')::DATE, 3000.00, 150000.00, 2, 6, 96);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '251 days')::DATE, (CURRENT_DATE - INTERVAL '251 days' + INTERVAL '12 months')::DATE, 3500.00, 50000.00, 3, 7, 97);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '43 days')::DATE, (CURRENT_DATE - INTERVAL '43 days' + INTERVAL '6 months')::DATE, 3500.00, 100000.00, 3, 8, 98);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '167 days')::DATE, (CURRENT_DATE - INTERVAL '167 days' + INTERVAL '24 months')::DATE, 1200.00, 25000.00, 3, 9, 99);
CALL insurance.create_policy((CURRENT_DATE - INTERVAL '270 days')::DATE, (CURRENT_DATE - INTERVAL '270 days' + INTERVAL '24 months')::DATE, 600.00, 75000.00, 4, 10, 100);

-- ======================================================================
-- 5. POLICY DETAILS -- Health (35), Car (35), Home (30)
-- ======================================================================

-- --- Health Policy Details (Policies 1-35) ---
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Previous appendectomy 2015', 'Mount Sinai Hospital NY', 'Hair transplant procedures', 1);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Type 2 diabetes managed with medication', 'Denver Health Medical Center', 'Vision correction LASIK', 2);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Previous appendectomy 2015', 'Abbott Northwestern Hospital', 'Chiropractic beyond 20 visits', 3);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Controlled hypertension', 'Mount Sinai Hospital NY', 'Fertility treatments IVF', 4);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Family history of heart disease', 'Houston Methodist', 'Fertility treatments IVF', 5);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Previous appendectomy 2015', 'Portland Medical Center', 'Experimental gene therapy', 6);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Mild allergies seasonal', 'Northwestern Memorial Hospital', 'Chiropractic beyond 20 visits', 7);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Previous ACL surgery 2018', 'Jackson Memorial Hospital Miami', 'Vision correction LASIK', 8);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('No prior hospitalizations', 'Mayo Clinic Phoenix', 'Acupuncture sessions', 9);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('No significant history', 'Mount Sinai Hospital NY', 'Elective dental implants', 10);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Mild allergies seasonal', 'Baylor University Medical Center', 'Fertility treatments IVF', 11);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Controlled hypertension', 'Mayo Clinic Phoenix', 'Vision correction LASIK', 12);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('No prior hospitalizations', 'Massachusetts General Hospital', 'Cosmetic surgery', 13);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Previous appendectomy 2015', 'Abbott Northwestern Hospital', 'Acupuncture sessions', 14);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Corrective eye surgery LASIK 2020', 'Northwestern Memorial Hospital', 'Cosmetic surgery', 15);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Asthma since childhood', 'Massachusetts General Hospital', 'Fertility treatments IVF', 16);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Mild anxiety disorder managed', 'Mayo Clinic Phoenix', 'Chiropractic beyond 20 visits', 17);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Previous appendectomy 2015', 'Mount Sinai Hospital NY', 'Cosmetic surgery', 18);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Asthma since childhood', 'Baylor University Medical Center', 'Acupuncture sessions', 19);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Type 2 diabetes managed with medication', 'Henry Ford Hospital Detroit', 'Hair transplant procedures', 20);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Corrective eye surgery LASIK 2020', 'Henry Ford Hospital Detroit', 'Chiropractic beyond 20 visits', 21);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Controlled hypertension', 'Seattle General Hospital', 'Cosmetic dermatology', 22);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Controlled cholesterol with statins', 'Cedars-Sinai LA', 'Experimental gene therapy', 23);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Previous ACL surgery 2018', 'Massachusetts General Hospital', 'Cosmetic surgery', 24);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Chronic lower back pain', 'Northwestern Memorial Hospital', 'Elective dental implants', 25);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Asthma since childhood', 'Abbott Northwestern Hospital', 'Elective dental implants', 26);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Corrective eye surgery LASIK 2020', 'Portland Medical Center', 'Experimental gene therapy', 27);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Corrective eye surgery LASIK 2020', 'Henry Ford Hospital Detroit', 'Hair transplant procedures', 28);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Chronic lower back pain', 'Emory University Hospital', 'Hair transplant procedures', 29);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Family history of heart disease', 'Abbott Northwestern Hospital', 'Chiropractic beyond 20 visits', 30);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Corrective eye surgery LASIK 2020', 'Cedars-Sinai LA', 'Chiropractic beyond 20 visits', 31);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Chronic lower back pain', 'UCSF Medical Center', 'Vision correction LASIK', 32);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Asthma since childhood', 'Henry Ford Hospital Detroit', 'Cosmetic dermatology', 33);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('Chronic lower back pain', 'Emory University Hospital', 'Experimental gene therapy', 34);
INSERT INTO insurance.health_policy_detail (medical_history, associated_hospital, treatment_not_insured, policy_id)
VALUES ('No prior hospitalizations', 'Portland Medical Center', 'Hair transplant procedures', 35);

-- --- Car Policy Details (Policies 36-70) ---
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('GMC Sierra', 2023, 36);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Mazda CX-5', 2023, 37);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Audi A4', 2023, 38);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Lexus RX 350', 2022, 39);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Nissan Altima', 2021, 40);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Toyota Camry', 2022, 41);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Subaru Outback', 2022, 42);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Chevrolet Equinox', 2022, 43);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Subaru Outback', 2022, 44);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Volvo XC60', 2022, 45);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Volvo XC60', 2022, 46);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Toyota RAV4', 2022, 47);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Ram 1500', 2023, 48);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Chevrolet Malibu', 2020, 49);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Jeep Grand Cherokee', 2022, 50);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Acura TLX', 2023, 51);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Ram 1500', 2023, 52);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Volkswagen Jetta', 2021, 53);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Audi A4', 2023, 54);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Acura TLX', 2023, 55);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('GMC Sierra', 2023, 56);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Acura TLX', 2023, 57);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Kia Sorento', 2022, 58);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Jeep Grand Cherokee', 2022, 59);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Audi A4', 2023, 60);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Mercedes C-Class', 2022, 61);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Ford Mustang', 2023, 62);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Hyundai Tucson', 2023, 63);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Volvo XC60', 2022, 64);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Kia Sorento', 2022, 65);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Hyundai Tucson', 2023, 66);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('GMC Sierra', 2023, 67);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Mazda CX-5', 2023, 68);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Honda Civic', 2021, 69);
INSERT INTO insurance.car_policy_detail (model, registration_year, policy_id)
VALUES ('Audi A4', 2023, 70);

-- --- Home Policy Details (Policies 71-100) ---
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Modern Loft', 'Atlanta', '30301', 2018, 4123, 71);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Victorian', 'Chicago', '60601', 2002, 4045, 72);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Condominium', 'New York', '10001', 1962, 1317, 73);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Colonial', 'Minneapolis', '55401', 1966, 4380, 74);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Modern Loft', 'Portland', '97205', 1993, 2671, 75);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Single Family', 'Atlanta', '30301', 1969, 2479, 76);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Condominium', 'Portland', '97205', 1990, 4001, 77);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Ranch', 'Houston', '77001', 1999, 3637, 78);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Victorian', 'Miami', '33101', 1965, 4288, 79);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Colonial', 'Minneapolis', '55401', 2003, 4319, 80);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Victorian', 'Houston', '77001', 2000, 3743, 81);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Modern Loft', 'Minneapolis', '55401', 1994, 947, 82);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Townhouse', 'Los Angeles', '90001', 2000, 3603, 83);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Ranch', 'Los Angeles', '90001', 2007, 1170, 84);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Victorian', 'Portland', '97205', 2008, 3395, 85);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Townhouse', 'New York', '10001', 1970, 3642, 86);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Ranch', 'Detroit', '48201', 1961, 988, 87);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Colonial', 'Phoenix', '85001', 1963, 2001, 88);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Colonial', 'Houston', '77001', 1987, 1396, 89);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Duplex', 'Boston', '02101', 1986, 3118, 90);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Condominium', 'San Francisco', '94109', 1971, 1123, 91);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Victorian', 'Denver', '80201', 2003, 1786, 92);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Modern Loft', 'Detroit', '48201', 1997, 1386, 93);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Duplex', 'New York', '10001', 2000, 1840, 94);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Modern Loft', 'Dallas', '75201', 2002, 838, 95);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Modern Loft', 'Detroit', '48201', 1978, 3575, 96);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Condominium', 'Portland', '97205', 1988, 2215, 97);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Ranch', 'Miami', '33101', 1987, 3627, 98);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Ranch', 'New York', '10001', 2014, 2037, 99);
INSERT INTO insurance.home_policy_detail (home_type, city, zipcode, year_built, area_sq_ft, policy_id)
VALUES ('Duplex', 'Chicago', '60601', 2014, 2779, 100);

-- ======================================================================
-- 6. PAYMENTS (100 -- initial premium payment per policy)
--    Amount MUST exactly match the policy premium (trigger enforced)
-- ======================================================================
CALL insurance.record_payment(1, 1, 3500.00, 'BANK-214518079', (CURRENT_DATE - INTERVAL '8 days')::DATE);
CALL insurance.record_payment(2, 2, 2500.00, 'BANK-509486794', (CURRENT_DATE - INTERVAL '19 days')::DATE);
CALL insurance.record_payment(3, 3, 3000.00, 'BANK-485429460', (CURRENT_DATE - INTERVAL '19 days')::DATE);
CALL insurance.record_payment(4, 4, 1500.00, 'BANK-417690559', (CURRENT_DATE - INTERVAL '23 days')::DATE);
CALL insurance.record_payment(5, 5, 1500.00, 'BANK-417001612', (CURRENT_DATE - INTERVAL '1 days')::DATE);
CALL insurance.record_payment(6, 6, 600.00, 'BANK-991246046', (CURRENT_DATE - INTERVAL '22 days')::DATE);
CALL insurance.record_payment(7, 7, 3500.00, 'BANK-524993183', (CURRENT_DATE - INTERVAL '9 days')::DATE);
CALL insurance.record_payment(8, 8, 2000.00, 'BANK-108695125', (CURRENT_DATE - INTERVAL '19 days')::DATE);
CALL insurance.record_payment(9, 9, 2000.00, 'BANK-836371599', (CURRENT_DATE - INTERVAL '25 days')::DATE);
CALL insurance.record_payment(10, 10, 800.00, 'BANK-899582079', (CURRENT_DATE - INTERVAL '2 days')::DATE);
CALL insurance.record_payment(11, 11, 3000.00, 'BANK-751124015', (CURRENT_DATE - INTERVAL '24 days')::DATE);
CALL insurance.record_payment(12, 12, 1200.00, 'BANK-633356861', (CURRENT_DATE - INTERVAL '27 days')::DATE);
CALL insurance.record_payment(13, 13, 2500.00, 'BANK-407298630', (CURRENT_DATE - INTERVAL '25 days')::DATE);
CALL insurance.record_payment(14, 14, 3000.00, 'BANK-957769526', (CURRENT_DATE - INTERVAL '8 days')::DATE);
CALL insurance.record_payment(15, 15, 1000.00, 'BANK-751831074', (CURRENT_DATE - INTERVAL '26 days')::DATE);
CALL insurance.record_payment(16, 16, 1200.00, 'BANK-478301747', (CURRENT_DATE - INTERVAL '8 days')::DATE);
CALL insurance.record_payment(17, 17, 1200.00, 'BANK-783563240', (CURRENT_DATE - INTERVAL '7 days')::DATE);
CALL insurance.record_payment(18, 18, 1500.00, 'BANK-766676815', (CURRENT_DATE - INTERVAL '9 days')::DATE);
CALL insurance.record_payment(19, 19, 1800.00, 'BANK-827744047', (CURRENT_DATE - INTERVAL '25 days')::DATE);
CALL insurance.record_payment(20, 20, 1200.00, 'BANK-874090950', (CURRENT_DATE - INTERVAL '25 days')::DATE);
CALL insurance.record_payment(21, 21, 800.00, 'BANK-807790785', (CURRENT_DATE - INTERVAL '22 days')::DATE);
CALL insurance.record_payment(22, 22, 3000.00, 'BANK-246865585', (CURRENT_DATE - INTERVAL '21 days')::DATE);
CALL insurance.record_payment(23, 23, 1200.00, 'BANK-204328975', (CURRENT_DATE - INTERVAL '29 days')::DATE);
CALL insurance.record_payment(24, 24, 600.00, 'BANK-773728014', (CURRENT_DATE - INTERVAL '21 days')::DATE);
CALL insurance.record_payment(25, 25, 1800.00, 'BANK-142329671', (CURRENT_DATE - INTERVAL '10 days')::DATE);
CALL insurance.record_payment(26, 26, 3000.00, 'BANK-946764061', (CURRENT_DATE - INTERVAL '15 days')::DATE);
CALL insurance.record_payment(27, 27, 1200.00, 'BANK-135824891', (CURRENT_DATE - INTERVAL '19 days')::DATE);
CALL insurance.record_payment(28, 28, 2000.00, 'BANK-491766764', (CURRENT_DATE - INTERVAL '24 days')::DATE);
CALL insurance.record_payment(29, 29, 1800.00, 'BANK-241102355', (CURRENT_DATE - INTERVAL '3 days')::DATE);
CALL insurance.record_payment(30, 30, 1000.00, 'BANK-416872439', (CURRENT_DATE - INTERVAL '11 days')::DATE);
CALL insurance.record_payment(31, 31, 3500.00, 'BANK-902601465', (CURRENT_DATE - INTERVAL '14 days')::DATE);
CALL insurance.record_payment(32, 32, 2000.00, 'BANK-288592093', (CURRENT_DATE - INTERVAL '7 days')::DATE);
CALL insurance.record_payment(33, 33, 600.00, 'BANK-241905500', (CURRENT_DATE - INTERVAL '26 days')::DATE);
CALL insurance.record_payment(34, 34, 1200.00, 'BANK-679184667', (CURRENT_DATE - INTERVAL '29 days')::DATE);
CALL insurance.record_payment(35, 35, 2000.00, 'BANK-492836532', (CURRENT_DATE - INTERVAL '17 days')::DATE);
CALL insurance.record_payment(36, 36, 800.00, 'BANK-638798023', (CURRENT_DATE - INTERVAL '30 days')::DATE);
CALL insurance.record_payment(37, 37, 600.00, 'BANK-392624015', (CURRENT_DATE - INTERVAL '27 days')::DATE);
CALL insurance.record_payment(38, 38, 600.00, 'BANK-276678230', (CURRENT_DATE - INTERVAL '9 days')::DATE);
CALL insurance.record_payment(39, 39, 600.00, 'BANK-985503942', (CURRENT_DATE - INTERVAL '16 days')::DATE);
CALL insurance.record_payment(40, 40, 2500.00, 'BANK-965960427', (CURRENT_DATE - INTERVAL '10 days')::DATE);
CALL insurance.record_payment(41, 41, 2500.00, 'BANK-901611993', (CURRENT_DATE - INTERVAL '28 days')::DATE);
CALL insurance.record_payment(42, 42, 3500.00, 'BANK-463692735', (CURRENT_DATE - INTERVAL '26 days')::DATE);
CALL insurance.record_payment(43, 43, 1500.00, 'BANK-223662532', (CURRENT_DATE - INTERVAL '15 days')::DATE);
CALL insurance.record_payment(44, 44, 1500.00, 'BANK-180852074', (CURRENT_DATE - INTERVAL '5 days')::DATE);
CALL insurance.record_payment(45, 45, 800.00, 'BANK-909763993', (CURRENT_DATE - INTERVAL '8 days')::DATE);
CALL insurance.record_payment(46, 46, 3500.00, 'BANK-826197069', (CURRENT_DATE - INTERVAL '24 days')::DATE);
CALL insurance.record_payment(47, 47, 600.00, 'BANK-824138175', (CURRENT_DATE - INTERVAL '13 days')::DATE);
CALL insurance.record_payment(48, 48, 1800.00, 'BANK-963919401', (CURRENT_DATE - INTERVAL '18 days')::DATE);
CALL insurance.record_payment(49, 49, 600.00, 'BANK-492747974', (CURRENT_DATE - INTERVAL '3 days')::DATE);
CALL insurance.record_payment(50, 50, 2000.00, 'BANK-948988297', (CURRENT_DATE - INTERVAL '13 days')::DATE);
CALL insurance.record_payment(51, 51, 1000.00, 'BANK-114945047', (CURRENT_DATE - INTERVAL '9 days')::DATE);
CALL insurance.record_payment(52, 52, 1500.00, 'BANK-676140134', (CURRENT_DATE - INTERVAL '4 days')::DATE);
CALL insurance.record_payment(53, 53, 3500.00, 'BANK-588322781', (CURRENT_DATE - INTERVAL '12 days')::DATE);
CALL insurance.record_payment(54, 54, 800.00, 'BANK-822443971', (CURRENT_DATE - INTERVAL '24 days')::DATE);
CALL insurance.record_payment(55, 55, 2500.00, 'BANK-821920438', (CURRENT_DATE - INTERVAL '9 days')::DATE);
CALL insurance.record_payment(56, 56, 2500.00, 'BANK-727666622', (CURRENT_DATE - INTERVAL '13 days')::DATE);
CALL insurance.record_payment(57, 57, 1200.00, 'BANK-983063850', (CURRENT_DATE - INTERVAL '21 days')::DATE);
CALL insurance.record_payment(58, 58, 1500.00, 'BANK-498866784', (CURRENT_DATE - INTERVAL '4 days')::DATE);
CALL insurance.record_payment(59, 59, 3000.00, 'BANK-824600232', (CURRENT_DATE - INTERVAL '8 days')::DATE);
CALL insurance.record_payment(60, 60, 2000.00, 'BANK-606244434', (CURRENT_DATE - INTERVAL '1 days')::DATE);
CALL insurance.record_payment(61, 61, 2500.00, 'BANK-765233376', (CURRENT_DATE - INTERVAL '29 days')::DATE);
CALL insurance.record_payment(62, 62, 800.00, 'BANK-702806585', (CURRENT_DATE - INTERVAL '11 days')::DATE);
CALL insurance.record_payment(63, 63, 1200.00, 'BANK-755070775', (CURRENT_DATE - INTERVAL '8 days')::DATE);
CALL insurance.record_payment(64, 64, 2500.00, 'BANK-795411453', (CURRENT_DATE - INTERVAL '3 days')::DATE);
CALL insurance.record_payment(65, 65, 1800.00, 'BANK-782259766', (CURRENT_DATE - INTERVAL '27 days')::DATE);
CALL insurance.record_payment(66, 66, 1500.00, 'BANK-598503464', (CURRENT_DATE - INTERVAL '30 days')::DATE);
CALL insurance.record_payment(67, 67, 1200.00, 'BANK-852775879', (CURRENT_DATE - INTERVAL '10 days')::DATE);
CALL insurance.record_payment(68, 68, 1000.00, 'BANK-797115550', (CURRENT_DATE - INTERVAL '14 days')::DATE);
CALL insurance.record_payment(69, 69, 1500.00, 'BANK-225279834', (CURRENT_DATE - INTERVAL '5 days')::DATE);
CALL insurance.record_payment(70, 70, 1500.00, 'BANK-148690765', (CURRENT_DATE - INTERVAL '2 days')::DATE);
CALL insurance.record_payment(71, 71, 1500.00, 'BANK-426808977', (CURRENT_DATE - INTERVAL '16 days')::DATE);
CALL insurance.record_payment(72, 72, 1500.00, 'BANK-224683417', (CURRENT_DATE - INTERVAL '4 days')::DATE);
CALL insurance.record_payment(73, 73, 1500.00, 'BANK-352114611', (CURRENT_DATE - INTERVAL '29 days')::DATE);
CALL insurance.record_payment(74, 74, 800.00, 'BANK-677186272', (CURRENT_DATE - INTERVAL '5 days')::DATE);
CALL insurance.record_payment(75, 75, 2500.00, 'BANK-517305280', (CURRENT_DATE - INTERVAL '15 days')::DATE);
CALL insurance.record_payment(76, 76, 1000.00, 'BANK-498370582', (CURRENT_DATE - INTERVAL '22 days')::DATE);
CALL insurance.record_payment(77, 77, 800.00, 'BANK-897940629', (CURRENT_DATE - INTERVAL '23 days')::DATE);
CALL insurance.record_payment(78, 78, 800.00, 'BANK-680027275', (CURRENT_DATE - INTERVAL '14 days')::DATE);
CALL insurance.record_payment(79, 79, 3500.00, 'BANK-730651895', (CURRENT_DATE - INTERVAL '24 days')::DATE);
CALL insurance.record_payment(80, 80, 800.00, 'BANK-880179899', (CURRENT_DATE - INTERVAL '5 days')::DATE);
CALL insurance.record_payment(81, 81, 3500.00, 'BANK-545478870', (CURRENT_DATE - INTERVAL '21 days')::DATE);
CALL insurance.record_payment(82, 82, 2500.00, 'BANK-206323670', (CURRENT_DATE - INTERVAL '27 days')::DATE);
CALL insurance.record_payment(83, 83, 2000.00, 'BANK-625432379', (CURRENT_DATE - INTERVAL '20 days')::DATE);
CALL insurance.record_payment(84, 84, 600.00, 'BANK-538211092', (CURRENT_DATE - INTERVAL '9 days')::DATE);
CALL insurance.record_payment(85, 85, 1500.00, 'BANK-135128844', (CURRENT_DATE - INTERVAL '23 days')::DATE);
CALL insurance.record_payment(86, 86, 1000.00, 'BANK-497853519', (CURRENT_DATE - INTERVAL '7 days')::DATE);
CALL insurance.record_payment(87, 87, 2000.00, 'BANK-576078963', (CURRENT_DATE - INTERVAL '15 days')::DATE);
CALL insurance.record_payment(88, 88, 1500.00, 'BANK-353524015', (CURRENT_DATE - INTERVAL '28 days')::DATE);
CALL insurance.record_payment(89, 89, 1500.00, 'BANK-489431174', (CURRENT_DATE - INTERVAL '4 days')::DATE);
CALL insurance.record_payment(90, 90, 1500.00, 'BANK-836243579', (CURRENT_DATE - INTERVAL '12 days')::DATE);
CALL insurance.record_payment(91, 91, 3000.00, 'BANK-684615760', (CURRENT_DATE - INTERVAL '29 days')::DATE);
CALL insurance.record_payment(92, 92, 1500.00, 'BANK-792377512', (CURRENT_DATE - INTERVAL '12 days')::DATE);
CALL insurance.record_payment(93, 93, 1000.00, 'BANK-165015165', (CURRENT_DATE - INTERVAL '13 days')::DATE);
CALL insurance.record_payment(94, 94, 1500.00, 'BANK-396225446', (CURRENT_DATE - INTERVAL '7 days')::DATE);
CALL insurance.record_payment(95, 95, 1500.00, 'BANK-231167999', (CURRENT_DATE - INTERVAL '28 days')::DATE);
CALL insurance.record_payment(96, 96, 3000.00, 'BANK-984968439', (CURRENT_DATE - INTERVAL '15 days')::DATE);
CALL insurance.record_payment(97, 97, 3500.00, 'BANK-198433586', (CURRENT_DATE - INTERVAL '22 days')::DATE);
CALL insurance.record_payment(98, 98, 3500.00, 'BANK-327746886', (CURRENT_DATE - INTERVAL '21 days')::DATE);
CALL insurance.record_payment(99, 99, 1200.00, 'BANK-786650291', (CURRENT_DATE - INTERVAL '20 days')::DATE);
CALL insurance.record_payment(100, 100, 600.00, 'BANK-122932394', (CURRENT_DATE - INTERVAL '2 days')::DATE);

-- ======================================================================
-- 7. INSURANCE CLAIMS (30 initial claims)
-- ======================================================================
CALL insurance.register_claim(43, 5674.67, (CURRENT_DATE - INTERVAL '33 days')::DATE);
CALL insurance.register_claim(32, 14963.50, (CURRENT_DATE - INTERVAL '135 days')::DATE);
CALL insurance.register_claim(17, 2716.16, (CURRENT_DATE - INTERVAL '17 days')::DATE);
CALL insurance.register_claim(73, 9786.80, (CURRENT_DATE - INTERVAL '93 days')::DATE);
CALL insurance.register_claim(27, 10508.14, (CURRENT_DATE - INTERVAL '28 days')::DATE);
CALL insurance.register_claim(9, 9314.11, (CURRENT_DATE - INTERVAL '57 days')::DATE);
CALL insurance.register_claim(71, 18935.61, (CURRENT_DATE - INTERVAL '12 days')::DATE);
CALL insurance.register_claim(96, 14681.24, (CURRENT_DATE - INTERVAL '169 days')::DATE);
CALL insurance.register_claim(76, 10668.30, (CURRENT_DATE - INTERVAL '118 days')::DATE);
CALL insurance.register_claim(28, 13045.14, (CURRENT_DATE - INTERVAL '8 days')::DATE);
CALL insurance.register_claim(30, 1686.10, (CURRENT_DATE - INTERVAL '123 days')::DATE);
CALL insurance.register_claim(100, 17022.32, (CURRENT_DATE - INTERVAL '110 days')::DATE);
CALL insurance.register_claim(19, 13878.90, (CURRENT_DATE - INTERVAL '126 days')::DATE);
CALL insurance.register_claim(77, 14391.83, (CURRENT_DATE - INTERVAL '114 days')::DATE);
CALL insurance.register_claim(1, 1933.07, (CURRENT_DATE - INTERVAL '21 days')::DATE);
CALL insurance.register_claim(36, 6781.18, (CURRENT_DATE - INTERVAL '38 days')::DATE);
CALL insurance.register_claim(88, 1780.80, (CURRENT_DATE - INTERVAL '71 days')::DATE);
CALL insurance.register_claim(98, 12674.19, (CURRENT_DATE - INTERVAL '150 days')::DATE);
CALL insurance.register_claim(70, 11192.95, (CURRENT_DATE - INTERVAL '84 days')::DATE);
CALL insurance.register_claim(33, 7927.64, (CURRENT_DATE - INTERVAL '153 days')::DATE);
CALL insurance.register_claim(23, 10845.86, (CURRENT_DATE - INTERVAL '117 days')::DATE);
CALL insurance.register_claim(15, 10358.25, (CURRENT_DATE - INTERVAL '111 days')::DATE);
CALL insurance.register_claim(4, 2433.98, (CURRENT_DATE - INTERVAL '180 days')::DATE);
CALL insurance.register_claim(83, 2731.07, (CURRENT_DATE - INTERVAL '168 days')::DATE);
CALL insurance.register_claim(2, 13192.87, (CURRENT_DATE - INTERVAL '142 days')::DATE);
CALL insurance.register_claim(46, 14556.38, (CURRENT_DATE - INTERVAL '56 days')::DATE);
CALL insurance.register_claim(31, 8886.36, (CURRENT_DATE - INTERVAL '59 days')::DATE);
CALL insurance.register_claim(42, 8569.36, (CURRENT_DATE - INTERVAL '117 days')::DATE);
CALL insurance.register_claim(3, 8275.24, (CURRENT_DATE - INTERVAL '25 days')::DATE);
CALL insurance.register_claim(80, 6594.69, (CURRENT_DATE - INTERVAL '81 days')::DATE);

-- ======================================================================
-- 8. CLAIM ADJUDICATION (20 approved, 5 rejected, 5 still pending)
-- ======================================================================
CALL insurance.approve_claim(1);
CALL insurance.approve_claim(2);
CALL insurance.approve_claim(3);
CALL insurance.approve_claim(4);
CALL insurance.approve_claim(5);
CALL insurance.approve_claim(6);
CALL insurance.approve_claim(7);
CALL insurance.approve_claim(8);
CALL insurance.approve_claim(9);
CALL insurance.approve_claim(10);
CALL insurance.approve_claim(11);
CALL insurance.approve_claim(12);
CALL insurance.approve_claim(13);
CALL insurance.approve_claim(14);
CALL insurance.approve_claim(15);
CALL insurance.approve_claim(16);
CALL insurance.approve_claim(17);
CALL insurance.approve_claim(18);
CALL insurance.approve_claim(19);
CALL insurance.approve_claim(20);

CALL insurance.reject_claim(21, 'Pre-existing condition not disclosed');
CALL insurance.reject_claim(22, 'Claim filed after coverage expiry');
CALL insurance.reject_claim(23, 'Documentation incomplete');
CALL insurance.reject_claim(24, 'Duplicate claim detected');
CALL insurance.reject_claim(25, 'Policy lapsed due to non-payment');
-- Claims 26-30 remain in PENDING status for demonstration
