# Chapter 4: Legacy Database Architecture (Phase 1)

This chapter deconstructs the logical and physical architecture of the Phase 1 database, explaining the relational modelling decisions that underpin the insurance ecosystem.

---

## 4.1 The ER Diagram

The foundational blueprint of the Phase 1 database is represented in the ER Diagram.

![Phase 1 ER Diagram](../../Phase%201-Legacy_Simple_DBMS/ER%20Diagram.png)

*Note: In the final Bi-Temporal phase, this entire structure is duplicated into an active and history tier. Phase 1 represents only the "active" conceptual layer.*

---

## 4.2 Normalization Strategy

The database is strictly normalized to the **Third Normal Form (3NF)**.
1. **1NF (First Normal Form):** All tables have a defined Primary Key, and all attributes contain atomic values (no arrays or comma-separated lists for phone numbers).
2. **2NF (Second Normal Form):** Achieved by ensuring that no non-prime attribute is dependent on a proper subset of a composite primary key. (e.g., In `Customer_Policy`, there are no attributes that depend solely on `Customer_id` but not `Policy_no`).
3. **3NF (Third Normal Form):** Every non-prime attribute is non-transitively dependent on the primary key. `Agent_id` determines the agent's `Name`, it does not determine the `Branch_id`'s `City`.

---

## 4.3 Entity Breakdown & Cardinality

### 1. `Company` (Branch)
- **Role:** Represents the physical office locations of the insurance provider.
- **Primary Key:** `Branch_id`.
- **Cardinality:** 
  - `Company (1)` to `Agent (M)`: A branch employs many agents, but an agent works for one branch.
  - `Company (1)` to `Policy (M)`: A branch can issue many policies.

### 2. `Agent`
- **Role:** The salesperson managing the client relationship.
- **Primary Key:** `Agent_id`.
- **Foreign Key:** `Branch_id`.
- **Cardinality:**
  - `Agent (1)` to `Customer (M)`: An agent manages many customers, but a customer has a primary agent.

### 3. `Customer`
- **Role:** The individual purchasing the insurance.
- **Primary Key:** `Customer_id`.
- **Foreign Key:** `Agent_id`.
- **Cardinality:** 
  - `Customer (M)` to `Policy (N)`: A complex Many-to-Many relationship. A single father might own an auto policy and a health policy (1-to-M). A joint auto policy might cover both a husband and a wife (M-to-1). Therefore, a bridging table is required.

### 4. `Policy` (The Core Entity)
- **Role:** The contract detailing the premium, coverage, and effective dates.
- **Primary Key:** `Policy_no`.
- **Foreign Keys:** `Branch_id`, `Agent_id`.
- **Subtyping (ISA Relationship):**
  - Policies are strictly categorized into `Car`, `Home`, and `Health`.
  - The database implements this via **Exclusive 1-to-1 Subtype Tables**.
  - *SQL Implementation:* `Car_Num`, `Home_no`, and `Health_id` act as Primary Keys for their respective tables, but they also hold a strict Foreign Key (`Policy_no`) pointing back to the super-type `Policy` table.

### 5. `Payment` & `Claim`
- **Role:** The financial ledger tracking incoming money (Payments) and outgoing money (Claims).
- **Constraints:** A payment is linked to a customer. A claim is linked to a payment (billing event) and to specific policies via a bridge table (`Policy_Claim`), because a single massive claim event (e.g., a hurricane) might trigger payouts across multiple home and auto policies simultaneously.

---

## 4.4 Business Rules & Constraints

Business rules dictate how the real-world operations map to the database schema.

1. **Rule: Agents cannot exist without a Branch.**
   - *Constraint:* `FOREIGN KEY(Branch_id) REFERENCES Company(Branch_id)`.
2. **Rule: Policy premiums must be paid exactly as quoted.**
   - *Constraint:* Handled by the `payment_check` trigger. If `Amount < Premium` or `Amount > Premium`, it raises a PostgreSQL Exception.
3. **Rule: Claim payouts cannot exceed Policy Coverage limits.**
   - *Constraint:* In Phase 1, this was poorly enforced via application logic (a common flaw). In Phase 2, this is fixed via strict Stored Procedures.

---

## 4.5 The Flawed Assumption (Destructive Updates)

The most critical assumption made during Phase 1 design was: *"The database only needs to represent the absolute current state of the world."*

Because of this assumption, standard SQL DML was used:
```sql
UPDATE Customer SET City = 'Los Angeles' WHERE Customer_id = 101;
```
When this command runs, the database assumes the previous `City` is irrelevant. It physically destroys the old text string and replaces it with 'Los Angeles'. This assumption proves fatal for insurance auditing, paving the way for the Phase 2 Bi-Temporal Architecture.

---

## Chapter 4 Summary
Phase 1 presents a structurally sound, 3NF-compliant relational database. It flawlessly handles the *present-state* requirements of the business through carefully designed Foreign Keys, Many-to-Many bridge tables, and polymorphic subtyping (ISA). However, its fundamental reliance on point-in-time state tracking and `ON DELETE CASCADE` constraints makes it unsuitable for long-term financial auditing.

### Key Takeaways
- **Bridge Tables** (`Customer_Policy`) are mandatory for resolving Many-to-Many relationships.
- **ISA Relationships** (Inheritance) are mapped to SQL by creating a super-type table (`Policy`) and specific sub-type tables (`Car`, `Home`) linked via 1-to-1 Foreign Keys.
- **Point-in-Time architecture** is the root cause of the destructive update problem.

### Interview Tips
> **Tip:** Interviewers often ask how to model Object-Oriented Inheritance in SQL. Be prepared to draw the `Policy` super-type and the `Car`/`Health`/`Home` sub-types. Explain that putting all columns into one table violates normal forms by creating sparse `NULL` columns.

### Common Mistakes
- **Forgetting the Bridge:** Assuming a customer only ever has one policy and attempting to put `Policy_no` directly into the `Customer` table as a Foreign Key. This breaks down immediately when a customer buys a second policy.

### Review Questions
1. Why is the relationship between `Customer` and `Policy` Many-to-Many?
2. Explain how the database ensures a Car Policy cannot exist without a core Policy record.
3. What is the fundamental flaw with point-in-time point-state architectures?
