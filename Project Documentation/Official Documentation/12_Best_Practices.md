# Chapter 12: Enterprise Best Practices

Deploying a complex Bi-Temporal database in a production environment requires strict adherence to enterprise best practices to ensure maintainability, performance, and security.

---

## 12.1 SQL Standards and Naming Conventions

**1. Schema Separation**
- *Standard:* Never use the `public` schema for business data.
- *Implementation:* All tables, functions, and procedures are created within the `insurance` schema.

**2. Naming Conventions (Snake_Case)**
- *Standard:* PostgreSQL is case-insensitive unless identifiers are quoted. MixedCase or camelCase leads to endless quoting issues (`"MyTable"`).
- *Implementation:* All objects use `snake_case` (e.g., `update_customer_address`, `customer_history`).

**3. Prefixing/Suffixing**
- *Views:* Always prefix with `v_` (e.g., `v_customer_timeline`).
- *History Tables:* Always suffix with `_history`.
- *Stored Procedures:* Name with verbs (e.g., `register_claim`, `renew_policy`).

---

## 12.2 Normalization and Temporal Modelling

**1. Strictly Enforce 3NF on Active Tables**
- The active tables should be perfectly normalized to the Third Normal Form to prevent data anomalies. If a table contains `NULL`s for 80% of its columns, it should be refactored into a subtype table (as seen with `Health`, `Car`, and `Home` policies).

**2. Never Normalize the History Tables**
- *Anti-Pattern:* Trying to normalize the history tables by creating Foreign Keys between `customer_history` and `policy_history`. 
- *Best Practice:* History tables are *append-only* ledgers. They should represent the exact snapshot of the data at that moment. Enforcing referential integrity between two historical timelines creates computationally impossible dependency graphs.

---

## 12.3 Performance Optimization & Indexing

**1. The B-Tree vs. GiST Debate**
- Standard B-Tree indexes are optimized for exact matches or single-direction ranges (`WHERE age > 18`). They are terribly inefficient at searching overlapping bounds.
- *Best Practice:* Enable the `btree_gist` extension in PostgreSQL. Build GiST indexes on the temporal ranges:
  `CREATE INDEX idx_policy_temporal ON insurance.policy_history USING GIST (tsrange(valid_from, valid_to));`

**2. Composite Indexes on Versioning**
- Always create a B-Tree composite index on `(entity_id, version_number)` to allow instant sequential lookups of an entity's audit trail.

---

## 12.4 Backup and Version Control

**1. Version Control (Git)**
- *Anti-Pattern:* Using a GUI tool like pgAdmin to make live changes to tables.
- *Best Practice:* Treat database schema exactly like Python code. Every `CREATE TABLE` and `CREATE FUNCTION` command must exist in a `.sql` file committed to Git. Migrations should be handled via tools like Liquibase or Flyway.

**2. Point-in-Time Recovery (PITR)**
- Even with a Bi-Temporal database, you still need physical backups. If the hard drive catches fire, the temporal history is lost with it.
- *Best Practice:* Use PostgreSQL Write-Ahead Log (WAL) archiving to stream continuous physical backups to cloud storage (e.g., AWS S3).

---

## Chapter 12 Summary
Enterprise software is defined by its maintainability. By adhering to strict naming conventions, logical schemas, and targeted indexing strategies, a database can scale from 100 rows to 100 million rows without requiring a complete rewrite.

### Key Takeaways
- Use **`snake_case`** for all PostgreSQL identifiers.
- Use **GiST** indexes for time-travel queries, not B-Tree.
- Treat SQL scripts like application code (put them in Git).

### Review Questions
1. Why is the `public` schema avoided in enterprise deployments?
2. Why is a GiST index superior to a B-Tree index for Temporal Queries?
3. Should you enforce Foreign Key constraints on history tables? Why or why not?
