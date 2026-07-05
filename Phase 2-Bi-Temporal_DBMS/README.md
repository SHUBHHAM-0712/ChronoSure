# Phase 2: Bi-Temporal Enterprise DBMS

This directory contains the advanced **Bi-Temporal** architecture for the Insurance Database Management System. 

Unlike the legacy system (Phase 1), this enterprise-grade database is designed to solve the critical issue of **destructive updates**. It ensures that no historical data is ever lost by natively tracking two dimensions of time:
1. **Valid Time:** When a fact is true in the real world.
2. **Transaction Time:** When a fact was recorded in the database.

## 📂 File Structure & Execution Order

To deploy this database architecture from scratch, execute the SQL scripts in the following order:

### 1. Schema & Structure
*   **`Insurance database Bi-Temporal DDL.sql`**: The core schema definition. It creates the `insurance` schema, all active business tables, their corresponding `_history` shadow tables, and the optimized B-Tree and temporal GiST indexes.
*   **`Bi-Temporal ER Diagram.png`**: The visual Entity-Relationship diagram illustrating the new architecture and relationships.

### 2. Automation & API
*   **`Insurance database Functions.sql`**: Contains the dynamic PL/pgSQL function (`bitemporal_versioning_fn`) that orchestrates the movement of data between active and history tables.
*   **`Insurance database Triggers.sql`**: Attaches the versioning triggers to all enterprise entities, enabling fully autonomous auditing.
*   **`Insurance database Procedures.sql`**: The strict Stored Procedure API (14 procedures) used by the application layer to safely interact with the database without corrupting historical timelines.

### 3. Data Population & Manipulation
*   **`Insurance database Sample Data.sql`**: Contains the baseline `INSERT` statements used to populate the initial state of the database.
*   **`Insurance database Bi-Temporal DML.sql`**: Contains temporal lifecycle operations (e.g., policy renewals, address updates, logical deletes). Running this script simulates time passing and proves the triggers successfully capture history.

### 4. Querying & Time-Travel
*   **`Insurance database Bi-Temporal DQL.sql`**: Defines the `UNION ALL` Temporal Views (e.g., `v_customer_timeline`) that seamlessly merge active and historical records into a single queryable timeline.
*   **`Insurance database Temporal Queries.sql`**: Contains examples of "Time-Travel" `SELECT` queries, demonstrating how to retrieve a customer's exact profile as it existed on a specific date in the past.

### 5. Other Scripts
*   **`Insurance database Bi-Temporal DCL.sql`**: (Placeholder) Data Control Language script for managing database users, roles, and permissions.
*   **`Insurance database Bi-Temporal TCL.sql`**: (Placeholder) Transaction Control Language script for managing transaction savepoints and rollbacks.
*   **`Insurance database Python Code.ipynb`**: (Placeholder) Jupyter notebook for connecting to the bi-temporal database and running analytics or visualizations.

## 🚀 Key Features

*   **Zero Application Logic:** The database manages its own history autonomously via triggers. Developers can run standard `UPDATE` and `DELETE` commands without writing versioning logic.
*   **Logical Deletes:** A `DELETE` command never physically destroys data; it archives the record and marks it as a logical deletion.
*   **High Performance:** History tables are partitioned, and the active tables remain lean and fast. Temporal GiST indexing allows multi-year timeline scans in milliseconds.
