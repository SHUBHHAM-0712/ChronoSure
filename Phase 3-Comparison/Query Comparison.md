# Query Comparison: Legacy vs Bi-Temporal Insurance Database

## 1. Introduction
When evolving from a traditional relational database to a **Bi-Temporal** architecture, the way developers interact with the data fundamentally changes. While basic `INSERT` statements remain largely similar, operations that manipulate or retrieve data (`UPDATE`, `DELETE`, `SELECT`) require a deeper understanding of the temporal dimensions (Valid Time and Transaction Time).

This document serves as a technical SQL guide, comparing queries executed on the Legacy database (Version 1) against the Bi-Temporal database (Version 2).

---

## 2. Core Operational Differences

### 5. Why UPDATE Behaves Differently
In a legacy system, an `UPDATE` physically overwrites the magnetic block on the hard drive. In our Bi-Temporal system, an `UPDATE` statement is intercepted by autonomous PL/pgSQL triggers. The database closes the old record by stamping its `valid_to` timestamp, copies it to a `_history` table, and inserts the newly updated row into the active table with an incremented `version_number`. To the application layer, it looks like a standard update, but the database orchestrates a complex archival transaction.

### 6. Why DELETE Becomes Logical Deletion
A physical `DELETE` destroys auditing history. In the Bi-Temporal system, when a `DELETE` command is issued, the trigger intercepts it, archives the row into the `_history` table with a `change_reason` of "Logical Delete", and then allows the physical deletion from the active table. The data is gone from daily operations but perfectly preserved for compliance.

---

## 3. Query Comparisons by Module

### Module: Customer
**Business Scenario:** A new customer is registered, and later updates their address.

| Component | Legacy SQL & Output | Bi-Temporal SQL & Output |
| :--- | :--- | :--- |
| **INSERT** | `INSERT INTO customer (customer_id, city) VALUES (1, 'New York');`<br><br>*Output:* 1 row inserted. | `INSERT INTO customer (customer_id, city) VALUES (1, 'New York');`<br><br>*Output:* 1 row inserted (trigger automatically sets `valid_from = NOW()`). |
| **UPDATE** | `UPDATE customer SET city = 'Chicago' WHERE customer_id = 1;`<br><br>*Output:* 1 row updated. | `UPDATE customer SET city = 'Chicago' WHERE customer_id = 1;`<br><br>*Output:* 1 row updated (trigger creates history row implicitly). |
| **Limitation / Advantage**| **Limitation:** The fact that the customer lived in New York is permanently destroyed. | **Advantage:** The active table shows Chicago, but the `_history` table perfectly preserves the New York timeline. |

### Module: Policy
**Business Scenario:** Querying an active policy, and then querying exactly what the policy looked like two years ago.

| Component | Legacy SQL & Output | Bi-Temporal SQL & Output |
| :--- | :--- | :--- |
| **SELECT (Current)** | `SELECT premium FROM policy WHERE policy_id = 10;`<br><br>*Output:* `premium: 1200` | `SELECT premium FROM policy WHERE policy_id = 10;`<br><br>*Output:* `premium: 1200` (Filters implicit). |
| **Time Travel Query**| *Impossible.* The database cannot travel back in time. | `SELECT premium FROM v_policy_timeline WHERE policy_id = 10 AND '2022-01-01' >= valid_from AND '2022-01-01' < valid_to;`<br><br>*Output:* `premium: 900` |
| **Limitation / Advantage**| **Limitation:** Cannot calculate retroactive claims based on past premiums. | **Advantage:** Natively supports retroactive queries via the `UNION ALL` temporal view (`v_policy_timeline`). |

### Module: Agent & Branch
**Business Scenario:** Generate a report showing the total number of agents per branch.

| Component | Legacy SQL & Output | Bi-Temporal SQL & Output |
| :--- | :--- | :--- |
| **JOIN & Aggregate**| `SELECT b.city, COUNT(a.agent_id) FROM company_branch b JOIN agent a ON b.branch_id = a.branch_id GROUP BY b.city;`<br><br>*Output:* `New York: 45, Chicago: 32` | `SELECT b.city, COUNT(a.agent_id) FROM company_branch b JOIN agent a ON b.branch_id = a.branch_id GROUP BY b.city;`<br><br>*Output:* `New York: 45, Chicago: 32` |
| **Limitation / Advantage**| **Limitation:** Standard. | **Advantage:** Because the history is partitioned out of the active tables, current-state aggregate joins run just as fast as the legacy system. |

### Module: Claims
**Business Scenario:** Track the complete lifecycle (every version) of a specific claim.

| Component | Legacy SQL & Output | Bi-Temporal SQL & Output |
| :--- | :--- | :--- |
| **Historical Query**| *Impossible.* Only the final claim status exists. | `SELECT version_number, claim_status, valid_from, valid_to FROM v_claim_timeline WHERE claim_id = 505 ORDER BY version_number ASC;` |
| **Output** | `claim_status: 'Approved'` | `v1: 'Pending' (Jan 1 to Jan 5)`<br>`v2: 'Under Review' (Jan 5 to Jan 10)`<br>`v3: 'Approved' (Jan 10 to infinity)` |
| **Limitation / Advantage**| **Limitation:** No visibility into how long the claim took to process. | **Advantage:** Analysts can measure operational bottlenecks by tracking the exact duration of each historical phase. |

### Module: Payments
**Business Scenario:** A payment was logged incorrectly and needs to be voided (deleted).

| Component | Legacy SQL & Output | Bi-Temporal SQL & Output |
| :--- | :--- | :--- |
| **DELETE** | `DELETE FROM payment WHERE payment_id = 99;`<br><br>*Output:* Row physically deleted. | `DELETE FROM payment WHERE payment_id = 99;`<br><br>*Output:* Row archived to history, removed from active table. |
| **Audit Query** | *Impossible.* The fraud team cannot see the deleted payment. | `SELECT amount, modified_by, change_reason FROM payment_history WHERE payment_id = 99;`<br><br>*Output:* `amount: 5000, modified_by: 'jsmith', reason: 'Logical Delete'` |
| **Limitation / Advantage**| **Limitation:** Opens the door for severe embezzlement and fraud. | **Advantage:** Total accountability. Deleted financial records are fully recoverable and auditable. |

### Module: Insurance Plans
**Business Scenario:** Checking which database user made a specific change to an insurance plan's coverage.

| Component | Legacy SQL & Output | Bi-Temporal SQL & Output |
| :--- | :--- | :--- |
| **Version/Audit Query**| *Impossible.* Requires parsing raw PostgreSQL server logs. | `SELECT version_number, coverage, modified_by, transaction_from FROM v_policy_timeline WHERE policy_id = 15;` |
| **Output** | N/A | `v2: Coverage: 500k, By: 'admin_user', At: '2023-04-12 14:05:00'` |
| **Limitation / Advantage**| **Limitation:** No application-level visibility into user actions. | **Advantage:** Transaction Time acts as an immutable system clock, tracking the exact millisecond the database user committed the change. |

---

## 8. Best Practices for Writing Temporal SQL Queries

1.  **Always specify target dates:** When querying historical views (e.g., `v_customer_timeline`), always use an `AS OF` date bounding box (`'DATE' >= valid_from AND 'DATE' < valid_to`). Failing to do so will return duplicate primary keys (every version of the record).
2.  **Query Active Tables for Daily Operations:** Do not use the `_timeline` views for standard daily operations. Query the active tables directly (e.g., `insurance.customer`) to benefit from optimal B-Tree performance.
3.  **Rely on the Triggers:** Never manually update `valid_from`, `valid_to`, or `version_number`. Allow the PL/pgSQL triggers to handle temporal boundaries to ensure mathematical perfection.
4.  **Use Logical Filters for History:** If you need to find records that were deleted, query the `_history` table and filter by `change_reason = 'Logical Delete (Application Request)'`.
