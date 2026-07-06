# Chapter 11: Troubleshooting Guide

This chapter outlines the most common errors encountered when deploying or interacting with the Bi-Temporal Insurance Database, along with their root causes and solutions.

---

## 11.1 Connection Errors

**Error: `OperationalError: FATAL: password authentication failed for user "postgres"`**
- **Symptom:** The Jupyter Notebook throws this error when executing the first cell.
- **Root Cause:** The `create_engine()` connection string contains incorrect credentials.
- **Solution:** Open the Jupyter Notebook, locate the SQLAlchemy connection string (`postgresql://username:password@localhost:5432/insurance_bitemporal`), and replace `username` and `password` with your actual local pgAdmin credentials.

**Error: `OperationalError: database "insurance_bitemporal" does not exist`**
- **Symptom:** The Python script cannot find the database.
- **Root Cause:** The target database was not created in pgAdmin before running the script.
- **Solution:** Open pgAdmin, right-click "Databases", select "Create", and name it exactly `insurance_bitemporal`.

---

## 11.2 SQL & Syntax Errors

**Error: `relation "insurance.customer" does not exist`**
- **Symptom:** Executing `DML.sql` or `Procedures.sql` fails.
- **Root Cause:** Execution order violation. You attempted to insert data or compile a procedure before building the physical tables.
- **Solution:** Execute `Insurance database Bi-Temporal DDL.sql` first.

**Error: `function insurance.bitemporal_versioning_fn() does not exist`**
- **Symptom:** Executing `Triggers.sql` fails.
- **Root Cause:** You attempted to attach a trigger to a function that hasn't been compiled yet.
- **Solution:** Execute `Insurance database Functions.sql` before `Triggers.sql`.

---

## 11.3 Constraint Violations

**Error: `update or delete on table "company" violates foreign key constraint on table "agent"`**
- **Symptom:** Trying to delete a branch results in a massive red error in pgAdmin.
- **Root Cause:** In Phase 2, `ON DELETE CASCADE` was intentionally replaced with `ON DELETE RESTRICT`. The database is protecting itself from mass data destruction.
- **Solution:** You must first reassign or logically delete all Agents associated with that branch before you are legally allowed to close the branch.

**Error: `Claim amount exceeds maximum policy coverage.`**
- **Symptom:** A Python application or analyst tries to run `register_claim(1, 100000, '2025-01-01')`.
- **Root Cause:** The active policy only has $50,000 in coverage.
- **Solution:** The Stored Procedure successfully protected the database. The application must notify the user that the claim is financially invalid.

---

## 11.4 Trigger Issues

**Error: `record "new" has no field "change_reason"`**
- **Symptom:** The trigger fails to compile or run during an `UPDATE`.
- **Root Cause:** A developer altered the `customer` table and accidentally dropped the `change_reason` column, but the trigger still expects it.
- **Solution:** Bi-Temporal tables must *always* retain the 8 metadata columns. Re-add the column using `ALTER TABLE`.

---

## 11.5 Transaction Issues

**Error: `current transaction is aborted, commands ignored until end of transaction block`**
- **Symptom:** After hitting a `RAISE EXCEPTION` in a stored procedure, all subsequent SQL commands in the notebook fail.
- **Root Cause:** When PostgreSQL hits an exception inside a transaction block, it places the connection into an aborted state to prevent partial data writes.
- **Solution:** You must issue a `ROLLBACK` command (or let SQLAlchemy do it automatically by closing the session) before you can issue new commands.

---

## 11.6 Temporal Inconsistencies

**Error: Querying `v_customer_timeline` returns duplicates for the same date.**
- **Symptom:** An `AS OF` query returns two rows for John Doe on `2024-05-01`.
- **Root Cause:** An administrator manually bypassed the stored procedures and triggers, forcing an `INSERT` directly into the history table with overlapping `valid_from` and `valid_to` ranges.
- **Solution:** The timeline views mathematically depend on the `valid_to` of Version 1 perfectly matching the `valid_from` of Version 2. You must manually `UPDATE` the history table to fix the timestamp overlap. *Never bypass the API.*

---

## Chapter 11 Summary
Because the Bi-Temporal architecture relies on strict execution hierarchies and rigorous procedural encapsulation, errors are fundamentally a *good* thing. They mean the database is successfully defending itself from improper usage or malicious data destruction.

### Key Takeaways
- **Execution Order Errors** account for 90% of deployment failures.
- **Constraint Errors** represent the API working as intended to block bad data.
- **Aborted Transactions** require a `ROLLBACK` before proceeding.
