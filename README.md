# 🏦 Bi-Temporal Enterprise Database Management System

<div align="center">
  <img src="https://img.shields.io/badge/PostgreSQL-14%2B-blue?style=for-the-badge&logo=postgresql" alt="PostgreSQL"/>
  <img src="https://img.shields.io/badge/Python-3.x-3776AB?style=for-the-badge&logo=python" alt="Python"/>
  <img src="https://img.shields.io/badge/Jupyter-Notebook-F37626?style=for-the-badge&logo=jupyter" alt="Jupyter"/>
  <img src="https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge" alt="License"/>
</div>

<br>

Welcome to the **Bi-Temporal Enterprise Database Management System**. This project showcases the architectural transformation of a traditional, static relational database into an industrial-grade, time-traveling enterprise database. 

Designed specifically for the highly-regulated insurance sector, this database guarantees **100% data immutability and autonomous auditing**, ensuring no historical data is ever permanently lost or destroyed.

---

## 📖 Table of Contents
1. [The Problem: Destructive Updates](#-the-problem-destructive-updates)
2. [The Solution: Bi-Temporal Architecture](#-the-solution-bi-temporal-architecture)
3. [Core Features](#-core-features)
4. [Project Structure](#-project-structure)
5. [Getting Started (Setup Guide)](#-getting-started-setup-guide)
6. [Time-Travel Demonstrations](#-time-travel-demonstrations)
7. [System Architecture](#-system-architecture)

---

## 🚨 The Problem: Destructive Updates

Traditional Relational Database Management Systems (RDBMS) suffer from a critical flaw when applied to highly regulated industries: **destructive updates**. 

When a customer moves to a new city or an insurance policy premium is updated, standard SQL `UPDATE` and `DELETE` commands physically overwrite or destroy the previous data. This permanent loss of historical context makes it impossible to accurately process retroactive claims, perform compliance auditing, or reconstruct the exact state of a policy as it existed three years ago.

---

## 💡 The Solution: Bi-Temporal Architecture

To solve this, we completely re-engineered the backend into a **Bi-Temporal Database**. The system natively tracks two dimensions of time for every single row of data:
1. **Valid Time:** When a fact is true in the real world (e.g., "This policy is active from Jan 1 to Dec 31").
2. **Transaction Time:** When the system actually recorded the fact (e.g., "The clerk entered this into the computer on Jan 5").

By deploying autonomous PostgreSQL Triggers, the database intercepts *every* `UPDATE` and `DELETE` operation. Instead of destroying the data, it archives the old version into a `_history` table and inserts the new version.

---

## ✨ Core Features

*   **Immutable Auditing:** The database manages versioning autonomously via Triggers. Zero historical tracking code is required in the application layer.
*   **Time-Travel Queries:** Utilizing Temporal Views and GiST (Generalized Search Tree) indexes, analysts can query the exact state of the database *as it existed at any millisecond in the past*.
*   **Logical Deletes:** A `DELETE` command removes the data from the active table but permanently preserves it in the history table, allowing full recovery.
*   **Strict Database API:** 14 encapsulated Stored Procedures govern all data entry, preventing invalid financial states at the lowest possible level.

---

## 📁 Project Structure

The repository is divided into chronological phases to demonstrate the evolution:

- 📂 **`Phase 1-Legacy_Simple_DBMS/`**: Contains the traditional, static database schema (the flawed architecture that destroys history).
- 📂 **`Phase 2-Bi-Temporal_DBMS/`**: The enterprise solution. Includes DDL for active/history tables, PL/pgSQL triggers, the baseline data generation, and time-travel views.
- 📂 **`Phase 3-Comparison/`**: Contains architectural comparison reports.
- 📂 **`Project Documentation/`**: Contains the comprehensive thesis, ER diagrams, and `User Guide.md`.

---

## 🚀 Getting Started (Setup Guide)

### Prerequisites
*   **PostgreSQL 14+**
*   **Python 3.x** (with `pandas`, `sqlalchemy`, `psycopg2-binary`)
*   **Jupyter Notebook**

### Installation & Execution
1. **Prepare PostgreSQL:** Create an empty database named `insurance_bitemporal` in pgAdmin.
2. **Configure Credentials:** Open `Phase 2-Bi-Temporal_DBMS/Insurance database Python Code.ipynb` and update the database connection string with your local PostgreSQL `username` and `password`.
3. **Initialize the Database:** Run the notebook cells sequentially. The `initialize_database()` function will automatically deploy the tables, triggers, procedures, and generate 100 realistic rows of baseline data.
4. **Generate History:** Uncomment and run the `run_temporal_demo()` cell. This will execute simulated real-world updates (address changes, policy renewals) to prove that the database automatically archives the old states.

> **Note:** For a full, guided walkthrough of the presentation, please read the [User Guide](Project%20Documentation/User%20Guide.md).

---

## ⏳ Time-Travel Demonstrations

Once the database is initialized, you can use the Time-Travel queries to prove its capabilities. Open `Phase 2-Bi-Temporal_DBMS/Insurance database Temporal Queries.sql` in pgAdmin.

You can execute queries like the **AS OF Query** to view the database exactly as it looked in the past:

```sql
SELECT customer_id, first_name, last_name, city
FROM insurance.v_customer_timeline
WHERE (CURRENT_TIMESTAMP - INTERVAL '5 minutes') BETWEEN transaction_from AND transaction_to;
```

---

## 🏗️ System Architecture

1.  **API Layer (Stored Procedures):** Encapsulates business logic and throws exceptions to rollback invalid transactions.
2.  **Automation Layer (Triggers):** A dynamic PL/pgSQL function attached to every table that intercepts all DML operations.
3.  **Storage Layer:** Active tables and History shadow tables, overlaid with `UNION ALL` Views to allow seamless querying across the entire timeline.
