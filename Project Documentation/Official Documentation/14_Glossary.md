# Chapter 14: Glossary of Technical Terms

This chapter provides precise definitions for the enterprise database terminology utilized throughout this documentation.

---

## A - C

- **ACID Compliance:** A set of properties (Atomicity, Consistency, Isolation, Durability) that guarantee that database transactions are processed reliably, even in the event of a power failure.
- **Audit Trail:** A secure, immutable log showing who accessed a system, what operations they performed, and exactly when they performed them.
- **Checkpoint:** A point in the database transaction log where all data files have been updated to reflect the information in the log. It accelerates database recovery after a crash.
- **Commit:** A TCL command that permanently saves all changes made during the current transaction to the physical disk.
- **Cursor:** A database object used by applications to traverse records in a result set one row at a time.

## D - F

- **DCL (Data Control Language):** SQL commands like `GRANT` and `REVOKE` used to manage user permissions and security.
- **DDL (Data Definition Language):** SQL commands like `CREATE`, `ALTER`, and `DROP` used to define the physical database schema and constraints.
- **DML (Data Manipulation Language):** SQL commands like `INSERT`, `UPDATE`, and `DELETE` used to modify the actual data within the tables.
- **DQL (Data Query Language):** SQL commands like `SELECT` used to retrieve data from the database.
- **Foreign Key:** A column (or group of columns) in one table that uniquely identifies a row of another table, enforcing referential integrity.
- **Function (PL/pgSQL):** A block of procedural code that resides on the database server. Unlike a Procedure, a Function must return a value and cannot independently manage transactions (commit/rollback).

## I - N

- **Information Schema:** An ANSI-standard set of system views provided by PostgreSQL that contain metadata about the database objects (e.g., column names, table privileges).
- **Logical Delete:** The process of marking a record as "deleted" or "inactive" (usually by setting a timestamp or a boolean flag) without physically removing the data from the hard drive.
- **MVCC (Multi-Version Concurrency Control):** The mechanism PostgreSQL uses to handle concurrent access. It allows readers to read data without blocking writers, and writers to write without blocking readers, by keeping multiple hidden versions of a row.
- **Normalization (3NF):** The process of organizing data to reduce redundancy. Third Normal Form ensures that all non-key attributes are strictly dependent on the primary key.

## P - R

- **Procedure (Stored Procedure):** A block of procedural code executed on the database server. It does not return a value but has the power to manage transaction state (commit/rollback) internally.
- **Rollback:** A TCL command that undoes all modifications made since the start of the current transaction, returning the database to a consistent state following an error.

## T - Z

- **Temporal Database:** A database with built-in support for handling time-varying data.
- **Time Travel Query:** A specialized SQL query (`AS OF`) designed to reconstruct the exact state of the database at a specific millisecond in the past.
- **Transaction:** A single, logical unit of work that contains one or more SQL statements. Must adhere to ACID properties.
- **Transaction Time:** The exact system clock time that a fact was recorded into the database (The System Timeline).
- **Trigger:** A database object that automatically executes a specified Function in response to a specific DML event (`INSERT`, `UPDATE`, `DELETE`) on a table.
- **Valid Time:** The period of time when a fact is true in the real world (The Real World Timeline).
