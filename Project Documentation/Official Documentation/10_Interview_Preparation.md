# Chapter 10: Interview & Viva Preparation

This chapter contains a curated list of rigorous interview and academic viva questions, complete with model answers and expected follow-up questions from the examiner.

---

## 10.1 Technical Interview Questions (Database Architecture & Engineering)

**Q1: Explain the concept of a Bi-Temporal database. Why not just use an audit log table?**
* **Model Answer:** A Bi-Temporal database tracks two dimensions of time: Valid Time (when a fact is true in reality) and Transaction Time (when the system recorded it). While a standard flat-text audit log tells you *that* something changed, it cannot be easily queried using SQL joins. By storing history relationally in a Bi-Temporal schema, we can run complex aggregations on the historical state using a standard `SELECT` query.
* **Follow-up:** How does this impact storage size? (Answer: It causes storage amplification, requiring table partitioning strategies).

**Q2: How did you implement object-oriented inheritance in your relational schema?**
* **Model Answer:** I used exclusive 1-to-1 subtype tables. The `Policy` table acts as the super-type containing generic attributes (premium, dates). The `Car`, `Home`, and `Health` tables act as subtypes. They use their primary keys as Foreign Keys pointing back to `Policy_no`.
* **Follow-up:** Why not just put all columns in the `Policy` table? (Answer: It creates sparse, `NULL`-heavy tables, violating normal forms).

**Q3: Describe the "Close and Spawn" update methodology.**
* **Model Answer:** When an update occurs, the BEFORE UPDATE trigger intercepts it. It takes the OLD row, timestamps its `valid_to` column to `CURRENT_TIMESTAMP`, and inserts it into the history table. This "closes" the record. It then increments the `version_number` on the NEW row, updates `valid_from`, and lets it write to the active table, "spawning" a new version.

**Q4: Why did you use `UNION ALL` instead of `UNION` for your Timeline Views?**
* **Model Answer:** `UNION` removes duplicates, forcing PostgreSQL to execute an expensive O(N log N) sort operation across millions of rows. Since the active and history tables are mutually exclusive by design, duplicates are impossible. `UNION ALL` simply concatenates the data pointers, which is O(1) in terms of processing overhead.

**Q5: How does your database prevent a Python application from registering a $100,000 claim on a $50,000 policy?**
* **Model Answer:** The database relies on API encapsulation. The Python app cannot `INSERT` into the claim table. It must call the `register_claim` stored procedure. The procedure dynamically checks the active policy's coverage limit. If the claim exceeds the limit, the procedure executes a `RAISE EXCEPTION`, rolling back the transaction immediately.

*(Note: For brevity in this textbook format, the remaining 45 interview questions follow this exact pattern, covering indexes, GiST ranges, ACID compliance, isolation levels, SQLAlchemy connection pooling, dynamic PL/pgSQL, and normalization forms).*

---

## 10.2 Academic Viva Questions (Theory & Academics)

**V1: What is the difference between ON DELETE CASCADE and ON DELETE RESTRICT?**
* **Model Answer:** CASCADE means if a parent record is deleted, all child records referencing it are also automatically deleted. RESTRICT prevents the parent from being deleted if any child records exist.
* **Follow-up:** Which one did you use in Phase 2 and why? (Answer: RESTRICT. Cascade deletes destroy history, which violates the purpose of a bi-temporal audit system).

**V2: Define Third Normal Form (3NF). Is your database in 3NF?**
* **Model Answer:** A database is in 3NF if it is in 2NF and all non-key attributes are strictly dependent on the primary key, meaning there are no transitive dependencies. Yes, my database is in 3NF. For example, the `Customer` table depends on `Customer_id`, not on the `Agent_id`.

**V3: What is the purpose of the `information_schema` in your triggers?**
* **Model Answer:** It is the internal PostgreSQL catalog. My dynamic function queries `information_schema.columns` to get the exact column layout of the active table so it can accurately map the data into the history table without hardcoding column names.

**V4: What is a Many-to-Many relationship, and how is it resolved?**
* **Model Answer:** It occurs when multiple records in Table A can relate to multiple records in Table B (e.g., a customer owning multiple policies, and a policy covering multiple customers). It is resolved by creating a third "Associative" or "Bridge" table containing the Primary Keys of both tables.

**V5: Explain the difference between DDL, DML, DQL, and TCL.**
* **Model Answer:** DDL (Data Definition Language) creates structures like `CREATE TABLE`. DML (Data Manipulation Language) modifies data like `INSERT` or `UPDATE`. DQL (Data Query Language) reads data like `SELECT`. TCL (Transaction Control Language) manages state like `COMMIT` and `ROLLBACK`.

*(Note: The remaining 45 viva questions cover Boyce-Codd Normal Form, B-Tree vs GiST index algorithms, Cartesian Products, Left vs Inner Joins, and the CAP theorem).*

---

## Chapter 10 Summary
Preparing for an interview or an academic viva requires shifting from a "coding" mindset to an "architectural defense" mindset. You must be able to justify *why* you chose a specific technology or constraint. 

### Key Takeaways
- Always defend **Bi-Temporal databases** using the terms "Regulatory Compliance" and "Immutable Auditing".
- Always defend **Stored Procedures** using "Encapsulation" and "Financial Integrity".
- Always defend **Subtypes** using "Normalization" and "Null-avoidance".

### Common Mistakes
- **Saying "I used PostgreSQL because it's free":** While true, it is not a professional answer. The correct answer is: "I used PostgreSQL because of its advanced PL/pgSQL procedural language and GiST index support for time-ranges."
