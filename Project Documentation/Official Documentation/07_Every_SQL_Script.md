# Chapter 7: Every SQL Script (Deep Dive)

This chapter provides an exhaustive, industrial-grade analysis of every single Phase 2 SQL script. It explains the PostgreSQL behavior, locking mechanisms, transaction flows, and optimization choices behind the code.

---

## 7.1 `Insurance database Bi-Temporal DDL.sql`

### Purpose
Builds the physical Bi-Temporal schema, allocating disk space for both the active tier and the history tier.

### Code Analysis
```sql
CREATE TABLE insurance.customer_history (
    history_id SERIAL PRIMARY KEY,
    customer_id INT,
    first_name VARCHAR(500),
    ...
    valid_from TIMESTAMP,
    valid_to TIMESTAMP,
    transaction_from TIMESTAMP,
    transaction_to TIMESTAMP,
    version_number INT,
    is_current BOOLEAN,
    change_reason TEXT
);
```

- **`SERIAL` vs `INT`:** The `history_id` uses the `SERIAL` pseudo-type. Under the hood, PostgreSQL creates a sequence object attached to this column. We need a surrogate key here because `customer_id` is no longer unique in the history table.
- **Normalization:** Notice that `customer_id` does NOT have a `UNIQUE` constraint in the history table. A single customer can have dozens of historical records.
- **Execution Order:** Must be executed before any triggers or functions can be compiled.

---

## 7.2 `Insurance database Functions.sql`

### Purpose
Contains `bitemporal_versioning_fn()`, the master dynamic PL/pgSQL function that implements the "Close and Spawn" logic.

### Deep Dive into the Code
```sql
SELECT string_agg(quote_ident(column_name), ', ' ORDER BY ordinal_position)
INTO col_names
FROM information_schema.columns
WHERE table_schema = TG_TABLE_SCHEMA AND table_name = TG_TABLE_NAME;
```
- **What it does:** Dynamically queries the PostgreSQL internal metadata catalog (`information_schema`). It extracts the exact column names of whatever table fired the trigger.
- **Why it is written:** Writing a separate history-insertion function for all 10 tables would result in massive code duplication. By using dynamic SQL, a single function can handle *any* table in the schema.
- **`quote_ident`:** A crucial security feature. It wraps column names in double-quotes to prevent SQL injection if a table has strangely named columns.
- **`TG_TABLE_NAME`:** A special variable populated by PostgreSQL during trigger execution. It holds the name of the active table.

```sql
IF (TG_OP = 'UPDATE') THEN
    -- 1. Close the OLD record
    OLD.valid_to := CURRENT_TIMESTAMP;
    OLD.is_current := FALSE;
```
- **`TG_OP`:** Tells the function if the application ran an `UPDATE` or a `DELETE`.
- **`OLD` Record:** A system variable holding the exact state of the row *before* the application's update was applied.

```sql
EXECUTE format('INSERT INTO %I.%I (%s) SELECT ($1).*', 
               TG_TABLE_SCHEMA, TG_TABLE_NAME || '_history', col_names) 
USING OLD;
```
- **`EXECUTE format`:** Required because standard static SQL cannot accept dynamic table names.
- **Transaction Flow:** If this `INSERT` fails (e.g., out of disk space), the entire transaction rolls back. The active table is never updated.

### Alternatives Considered
Instead of one dynamic function, we could have used standard static functions per table.
- *Pro:* Slightly faster execution (avoids the `information_schema` lookup).
- *Con:* Unmaintainable. Adding a new column to a table would require rewriting the function logic manually.

---

## 7.3 `Insurance database Triggers.sql`

### Purpose
Wires the dynamic function to the physical tables.

### Code Analysis
```sql
CREATE TRIGGER trg_customer_bitemporal
BEFORE UPDATE OR DELETE ON insurance.customer
FOR EACH ROW
EXECUTE FUNCTION insurance.bitemporal_versioning_fn();
```
- **`BEFORE` vs `AFTER`:** Must be `BEFORE`. If we used an `AFTER` trigger, the old data would have already been overwritten on the disk, making it impossible to archive.
- **`FOR EACH ROW`:** A row-level trigger. If an application runs `UPDATE customer SET city = 'NY'`, and it affects 10,000 rows, this trigger fires 10,000 individual times.

---

## 7.4 `Insurance database Procedures.sql`

### Purpose
The strict API for the database. No application is allowed to run `INSERT` or `UPDATE` directly on the tables.

### Code Analysis: The Claim Registration
```sql
CREATE OR REPLACE PROCEDURE insurance.register_claim(
    p_policy_id INT, p_amount_issued NUMERIC, p_date_issued DATE
)
LANGUAGE plpgsql AS $$
DECLARE
    v_coverage NUMERIC;
BEGIN
    SELECT coverage INTO v_coverage FROM insurance.policy WHERE policy_id = p_policy_id;
    
    IF p_amount_issued > v_coverage THEN
        RAISE EXCEPTION 'Claim amount exceeds maximum policy coverage.';
    END IF;
    ...
```
- **Why it exists:** Financial integrity cannot be left to the Python/Java developers. If a frontend UI lacks validation, the database will still protect itself.
- **Transaction Flow:** A Stored Procedure in PostgreSQL 14 inherently runs inside a transaction block. If `RAISE EXCEPTION` is hit, PostgreSQL instantly executes a `ROLLBACK`. The claim is not registered.
- **`COALESCE` Pattern:** Used heavily in `update_customer` to allow partial updates. `SET first_name = COALESCE(p_first_name, first_name)` means: "If the application didn't provide a new first name, keep the old one."

---

## 7.5 `Insurance database Temporal Queries.sql`

### Purpose
Exposes the complex two-table architecture as unified logical views.

### Code Analysis: The Timeline View
```sql
CREATE OR REPLACE VIEW insurance.v_policy_timeline AS
SELECT 
    policy_id, start_date, end_date, premium, coverage, branch_id, agent_id,
    valid_from, valid_to, transaction_from, transaction_to, version_number, is_current
FROM insurance.policy
UNION ALL
SELECT 
    policy_id, start_date, end_date, premium, coverage, branch_id, agent_id,
    valid_from, valid_to, transaction_from, transaction_to, version_number, is_current
FROM insurance.policy_history;
```
- **`UNION ALL` vs `UNION`:** `UNION ALL` is mandatory here. Standard `UNION` forces PostgreSQL to sort and deduplicate the result set, which is an O(N log N) operation that would cripple performance. `UNION ALL` simply concatenates the pointers.
- **Expected Output:** A virtual table containing every version of every policy that has ever existed.

### Code Analysis: The "AS OF" Time Travel Query
```sql
SELECT customer_id, first_name, city
FROM insurance.v_customer_timeline
WHERE '2023-01-01 00:00:00' BETWEEN valid_from AND valid_to;
```
- **Optimization Strategy:** To make this fast, the database relies on GiST indexes built on the `valid_from` and `valid_to` ranges. Standard B-Tree indexes cannot efficiently search overlapping boundaries.

---

## Chapter 7 Summary
The Phase 2 scripts represent a masterful integration of PostgreSQL's most advanced features. By utilizing `information_schema` inside PL/pgSQL, the codebase remains DRY (Don't Repeat Yourself). The Stored Procedures encapsulate financial risk, while the Timeline Views encapsulate architectural complexity.

### Key Takeaways
- Use **`quote_ident`** when writing dynamic SQL to prevent injection.
- Use **`BEFORE`** triggers to intercept data before it is destroyed.
- Use **`UNION ALL`** (not `UNION`) for massive timeline view concatenations.

### Interview Tips
> **Tip:** If asked about performance issues with History tables, mention **Partitioning**. State: "While the `UNION ALL` view is fast, the history table will eventually grow too large. I would implement PostgreSQL Declarative Partitioning on the `_history` table, partitioning it by year so that queries only scan relevant shards."

### Review Questions
1. Why does the dynamic function query `information_schema.columns`?
2. What happens if a Stored Procedure hits a `RAISE EXCEPTION` command?
3. Why is `UNION ALL` faster than `UNION`?
