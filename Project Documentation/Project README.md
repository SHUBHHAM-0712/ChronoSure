# Bi-Temporal Enterprise Database Management System for Insurance

## 1. Executive Summary
This project outlines the architectural transformation of a traditional, static relational database into an industrial-grade **Bi-Temporal Enterprise Database**. Designed specifically for the insurance sector, this system guarantees that no data is ever lost. By implementing a sophisticated architecture comprising active tables, historical shadow tables, dynamic PL/pgSQL triggers, and a strict Stored Procedure API, the database natively supports "Time-Travel" querying. It provides immutable audit trails for compliance while maintaining lightning-fast performance for current-state queries, fulfilling all the stringent requirements of modern financial institutions.

## 2. Problem Statement
Traditional Relational Database Management Systems (RDBMS) suffer from a critical flaw when applied to highly regulated industries like insurance: **destructive updates**. When a customer changes their address or a policy premium is updated, standard SQL `UPDATE` and `DELETE` commands physically overwrite or destroy the previous data. This permanent loss of historical context makes it impossible to accurately process retroactive claims, perform compliance auditing, or reconstruct the exact state of a policy as it existed three years ago.

## 3. Requirement Analysis
To solve the destructive update problem, the insurance database required a complete architectural overhaul based on the following enterprise requirements:
*   **Immutable Auditing (Transaction Time):** The system must record exactly when a record was entered into the database and who entered it, preventing retroactive tampering.
*   **Historical Accuracy (Valid Time):** The system must track the real-world timeline of facts (e.g., when a policy was actually active, regardless of when it was entered into the system).
*   **Zero Application Logic:** The application layer must not be burdened with maintaining history; the database must manage versioning autonomously.
*   **Backward Compatibility:** Legacy applications executing standard `INSERT`, `UPDATE`, and `DELETE` queries must continue to function without crashing, while the database intercepts these commands to preserve history.
*   **Data Integrity:** Strict financial constraints (e.g., claim payouts cannot exceed policy coverage) must be enforced at the lowest database level.

## 4. Existing System Analysis
The legacy database schema relied on standard relational tables (Customer, Policy, Claim, Payment) linked heavily by `ON DELETE CASCADE` constraints. 
*   **Flaws:** If a Company Branch was deleted, the cascade would automatically delete all Agents, Customers, Policies, and Claims associated with that branch—a catastrophic data loss event. Furthermore, financial triggers were flawed, and there was zero capability to track the lifecycle of a claim or the history of a customer's address.

## 5. Proposed System
The proposed system upgrades the database to a **Bi-Temporal Architecture**. 
In this model, the database is physically partitioned into two sets of tables:
1.  **Active Tables:** Contain only the currently valid, active data.
2.  **History Tables:** Shadow tables containing every closed, expired, or deleted record.

By placing a strict API (Stored Procedures) and an Automation Layer (Triggers) over this storage engine, we create a secure, self-auditing environment.

## 6. Architecture Overview
The system follows a strict 3-Tier Database Architecture:
1.  **API Layer (Stored Procedures):** 14 distinct procedures (e.g., `register_claim`, `renew_policy`) that encapsulate all business logic, perform validations, and throw Exceptions to rollback invalid transactions.
2.  **Automation Layer (Triggers):** A master dynamic PL/pgSQL function attached to every table that intercepts all DML operations, automatically closing old records and moving them to the history tier.
3.  **Storage & Presentation Layer:** The physical active/history tables, overlaid with Temporal `UNION ALL` Views to allow seamless querying across the entire timeline.

## 7. Entity Relationship Diagram (ER Diagram)

![ER Diagram Updated](../Phase%202-Bi-Temporal_DBMS/Bi-Temporal%20ER%20Diagram.png)

### Schema & Relationship Explanation

*   **Major Entities:** The core ecosystem revolves around the `COMPANY_BRANCH`, `AGENT`, `CUSTOMER`, and `POLICY`. The `PAYMENT` and `CLAIM` entities represent the primary financial interactions tied to a policy.
*   **ISA / Specialization (Subtypes):** Since `POLICY` is a generic concept, specific insurance types (Health, Car, Home) are modeled using 1-to-0..1 (`||--o|`) relationships. This perfectly maps the object-oriented inheritance (ISA) paradigm into a strict relational database structure, as Mermaid does not natively support ISA circles.
*   **Many-to-Many Relationships:** The conceptual many-to-many relationships (e.g., a customer owning multiple policies, and a policy covering multiple joint customers) are resolved into physical associative bridge tables (`CUSTOMER_POLICY` and `CLAIM_POLICY`), allowing strict tracking of relationship timelines.
*   **Bi-Temporal Engine:** Every single entity and associative table listed above physically contains the four temporal columns (`valid_from`, `valid_to`, `transaction_from`, `transaction_to`). This guarantees that not only are entity profiles versioned over time, but the *relationships themselves* (e.g., *when* did a customer own a policy?) are impeccably tracked in the audit trail.

## 8. Relational Schema
The database employs a highly normalized schema with strict relational integrity:
*   All `ON DELETE CASCADE` constraints were replaced with `ON DELETE RESTRICT` to prevent accidental data destruction.
*   Monetary values are standardized to `NUMERIC(12, 2)`.
*   Complex many-to-many relationships are resolved using associative bridge tables (`customer_policy`, `claim_policy`).
*   Polymorphic policy types are handled via exclusive 1-to-1 subtype tables (`health_policy_detail`, `car_policy_detail`).

## 9. Data Dictionary (Temporal Columns)
To support bi-temporality, the following 8 columns were injected into every enterprise entity:
1.  `valid_from` (TIMESTAMP): When the fact became true in the real world.
2.  `valid_to` (TIMESTAMP): When the fact ceased to be true (defaults to infinity `9999-12-31` for active records).
3.  `transaction_from` (TIMESTAMP): Exact system clock time the record was committed.
4.  `transaction_to` (TIMESTAMP): Exact system clock time the record was closed or replaced.
5.  `version_number` (INT): Incremental counter (1, 2, 3...) for easy sequential tracking.
6.  `is_current` (BOOLEAN): `TRUE` in active tables, `FALSE` in history tables.
7.  `modified_by` (VARCHAR): The database user who executed the change.
8.  `change_reason` (TEXT): A descriptive audit tag (e.g., "Address Update", "Logical Delete").

## 10. Temporal Design & Versioning Strategy
The database utilizes a Trigger-based **"Close and Spawn"** versioning strategy.
*   **On UPDATE:** The `BEFORE UPDATE` trigger intercepts the operation. It takes the `OLD` row, stamps `valid_to` and `transaction_to` with `CURRENT_TIMESTAMP`, and inserts it into the `_history` table. It then takes the `NEW` row, increments the `version_number`, resets the start timestamps to `CURRENT_TIMESTAMP`, and allows it to replace the row in the active table.
*   **On DELETE:** The trigger intercepts the command, archives the `OLD` row to history with a `'Logical Delete'` change reason, and allows the physical deletion from the active table.

## 11. Trigger Architecture
To prevent code duplication, a single **Dynamic PL/pgSQL Trigger Function** (`insurance.bitemporal_versioning_fn`) was engineered. 
It utilizes `TG_TABLE_NAME` to determine which table fired the event, and dynamically queries PostgreSQL's `information_schema.columns` to extract the exact column list. This ensures perfect alignment when moving data to the history table, dynamically bypassing the auto-generated `history_id` surrogate key.

## 12. Stored Procedures (The Database API)
14 Stored Procedures govern data entry, effectively shielding the tables from application-level corruption. 
*   **Validation Examples:** The `register_claim` procedure dynamically queries the policy's `coverage` limit. If the `amount_issued` exceeds this limit, it executes a `RAISE EXCEPTION`, instantly rolling back the entire transaction. 
*   **Audit Injection:** Procedures like `update_customer_address()` automatically inject explicitly defined `change_reason` strings into the update, generating highly readable audit trails.

## 13. Views (Time-Travel Enablers)
To simplify querying, **Timeline Views** (e.g., `v_customer_timeline`) were created using `UNION ALL` statements. These views mathematically stitch the active table and the history table back together into a single logical entity. Analysts can query these views using `BETWEEN valid_from AND valid_to` to execute complex time-travel queries without writing complex JOINs.

## 14. Indexes & Performance Optimization
Searching overlapping date ranges is notoriously slow using standard B-Tree indexes. To achieve enterprise scalability, the database implements:
1.  **Generalized Search Trees (GiST):** By enabling the `btree_gist` extension, `valid_from` and `valid_to` are evaluated as a continuous `tsrange`. GiST mathematically clusters these ranges, allowing the query planner to jump directly to the target timeline without full table scans.
2.  **Composite Sorting Indexes:** B-Tree indexes on `(entity_id, version_number)` allow timeline views to instantly return sequential audit trails.
3.  **Foreign Key Indexes:** Dedicated indexes on all foreign keys to accelerate relational JOINs.

## 15. Testing & Results
A comprehensive SQL Validation Suite simulated a complete application lifecycle.
*   **Constraint Testing:** Malicious inserts (e.g., paying incorrect premium amounts) were successfully blocked and rolled back by the API and triggers.
*   **Temporal Testing:** Legacy `UPDATE` and `DELETE` commands successfully triggered the automation layer. The Timeline Views proved that zero data was lost; old addresses and logically deleted policies were perfectly preserved in the history tables with accurate timestamps and incremented version numbers.

## 16. Advantages
*   **Absolute Compliance:** A completely immutable, automated audit trail.
*   **High Performance:** Because active queries only hit the active tables, day-to-day operations remain lightning fast.
*   **Backward Compatibility:** Legacy scripts can manipulate the database without knowing the bi-temporal architecture exists.
*   **Data Integrity:** Stored procedures prevent invalid state transitions at the lowest level.

## 17. Limitations
*   **Storage Requirements:** Because data is never destroyed, storage requirements double or triple rapidly compared to a standard RDBMS.
*   **Schema Modification:** Adding a new column requires altering both the active table, the history table, and modifying the Timeline Views.

## 18. Future Scope
As the `_history` tables grow to hundreds of millions of records, the immediate future scope involves implementing **PostgreSQL Declarative Table Partitioning**. By partitioning the history tables by year (e.g., `policy_history_2024`, `policy_history_2025`), the database engine can implement *Partition Pruning*, completely ignoring irrelevant years during time-travel queries and ensuring infinite scalability.
