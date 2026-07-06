# Chapter 3: Detailed Explanation of Legacy Files (Phase 1)

This chapter provides a meticulous, line-by-line architectural breakdown of every file located within the `Phase 1-Legacy_Simple_DBMS` directory. 

---

## 3.1 `Insurance database DDL.sql`

### Purpose
This is the **Data Definition Language** script that builds the physical schema for the Phase 1 database. It creates the tables, defines data types, and establishes the foundational relational constraints (Primary Keys and Foreign Keys).

### Role in the Project
It establishes the standard, static database. It is the architectural representation of the "Destructive Update Problem."

### Execution Order
**First.** This file must be executed before any data can be inserted or queried.

### Internal Structure & Explanation

#### 1. Schema Creation
```sql
create schema if not exists insurance;
set search_path to insurance;
```
- **Explanation:** Creates a dedicated namespace (`insurance`) rather than using the default `public` schema. This is an enterprise best practice for security and organization.

#### 2. The `Company` (Branch) Table
```sql
create table insurance.Company(
    Branch_id int not null primary key, 
    No_of_employee int not null,
    City varchar(500), 
    Zipcode int
);
```
- **Why it exists:** Represents physical office locations.
- **Constraints:** `Branch_id` is the Primary Key. `No_of_employee` cannot be null.

#### 3. The `Agent` Table
```sql
create table insurance.Agent(
    Agent_id int not null primary key, 
    ...
    Branch_id int,
    FOREIGN KEY(Branch_id) REFERENCES Company(Branch_id) on delete cascade on update cascade
);
```
- **Why it exists:** Tracks employees selling policies.
- **Dangerous Constraint (`ON DELETE CASCADE`):** If a `Company` branch closes and is deleted, every `Agent` associated with that branch is instantly and permanently deleted. This is a massive flaw in Phase 1 that gets fixed in Phase 2.

#### 4. The `Customer` Table
- **Role:** Tracks client profiles.
- **Relationships:** Linked to `Agent` via Foreign Key. If an agent is fired (deleted), the cascade will instantly delete all of their customers.

#### 5. The `Policy` Table
- **Datatypes:** `Start_date date not null`, `Premium int`, `Coverage int`.
- **Relationships:** Holds FKs to both `Branch` and `Agent`.

#### 6. The Bridging Tables (`Customer_Policy` & `Policy_Claim`)
```sql
create table insurance.Customer_Policy(
    Customer_id int,
    Policy_no int,
    primary key (Customer_id, Policy_no),
    FOREIGN KEY(...) REFERENCES ... on delete cascade
);
```
- **Why it exists:** Resolves the Many-to-Many relationship between Customers and Policies. A customer can own multiple policies, and a policy (like auto insurance) can cover multiple family members.
- **Composite Primary Key:** The combination of `Customer_id` and `Policy_no` guarantees a unique relationship.

#### 7. Polymorphic Subtypes (`Health`, `Car`, `Home`)
- **Role:** Implements Object-Oriented Inheritance (ISA) in a relational database. 
- **Explanation:** Not every policy is a Car policy. Therefore, specific details (like `Registration_Year`) are abstracted into 1-to-1 subtype tables that reference `Policy(Policy_no)`.

#### 8. The Legacy Payment Trigger
```sql
create trigger payment_check
before insert on payment
for each row
execute function payment_check_fn();
```
- **Explanation:** Before a payment is inserted, it cross-references the `Customer_Policy` bridge to find the active premium. If the payment `amount` is less than or greater than the `premium`, the trigger aborts the transaction (`raise exception`).

### Best Practices Used
- Dedicated Schemas (`insurance`).
- Explicit naming of Foreign Keys.
- Use of Bridge Tables for Many-to-Many relationships.

### Common Mistakes
- **Cascade Deletes:** Using `ON DELETE CASCADE` in an enterprise ledger is a catastrophic mistake. It allows accidental mass-data destruction.

### Potential Interview Questions
- **Q:** *Why did you use subtype tables for Car, Home, and Health instead of putting all columns into the Policy table?*
  - **A:** If I put `Registration_Year` into the core `Policy` table, it would be `NULL` for Health and Home policies. This creates a sparse table, violating relational normalization principles. Subtypes ensure 3NF compliance.

---

## 3.2 `Insurance database DML.sql`

### Purpose
The **Data Manipulation Language** script inserts mock data into the tables created by the DDL script.

### Dependencies
Must be executed exactly after `DDL.sql`.

### Example Snippets
```sql
INSERT INTO insurance.Company VALUES (101, 50, 'New York', 10001);
```

### Important Notes
Because of the strict Foreign Key constraints in Phase 1, **insertion order matters immensely**. You cannot insert a `Customer` before inserting an `Agent`, and you cannot insert an `Agent` before a `Company`. The script executes hierarchically.

---

## 3.3 `Insurance database DQL.sql`

### Purpose
The **Data Query Language** script contains complex operational queries used by business intelligence teams to extract insights from the legacy data.

### Explanation of Queries
1. **Agent Performance:** Queries that `JOIN` Agents to Policies to calculate total premium revenue generated per agent.
2. **Claim Aggregation:** Queries calculating the total amount issued in claims per branch using `GROUP BY`.

### What problem it solves
It proves that the legacy database *can* answer current-state business questions, even though it fails at historical questions.

---

## 3.4 `Insurance database python code.ipynb`

### Purpose
A Jupyter Notebook acting as a simulated application layer, connecting to PostgreSQL to execute queries and visualize the results.

### Dependencies
- `psycopg2-binary`: For the raw database connection.
- `sqlalchemy`: For mapping SQL results into DataFrames safely.
- `pandas`: For data manipulation.
- `matplotlib` / `seaborn`: For graphing.

### Internal Structure
1. **Connection Block:** Establishes the TCP connection to `localhost:5432` on the `insurance_legacy` database.
2. **Query Execution:** Passes raw SQL strings to `pd.read_sql()`.
3. **Visualization:** Converts the DataFrame into a bar chart (e.g., showing total revenue per branch).

### Potential Viva Questions
- **Q:** *Why did you use SQLAlchemy alongside Pandas instead of just raw psycopg2?*
  - **A:** Pandas explicitly warns against using raw psycopg2 connections for `read_sql()`. SQLAlchemy acts as an abstraction layer that handles connection pooling and dialect translation safely, which is an enterprise best practice.

---

## Chapter 3 Summary
Phase 1 utilizes a strictly enforced, highly normalized 3NF relational schema. While the DDL perfectly encapsulates the business rules for the *present* state (using constraints and bridge tables), its reliance on `ON DELETE CASCADE` exposes it to catastrophic data loss.

### Key Takeaways
- **DDL Execution Order:** Tables with Foreign Keys must be created *after* the tables they reference.
- **DML Execution Order:** Data must be inserted into parent tables before child tables.
- **The Cascade Threat:** `ON DELETE CASCADE` is the enemy of immutable auditing.
