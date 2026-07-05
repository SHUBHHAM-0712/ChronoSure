# Insurance Database Management System: Project & Setup Guide

Welcome to the **Insurance Database Management System**! This document provides a complete overview of the project, its architecture, and a step-by-step guide on how to successfully set up, run, and demonstrate the database on your local device.

---

## 1. Project Overview

The objective of this project is to demonstrate the architectural evolution from a traditional, static database to an enterprise-grade **Bi-Temporal Database**. 

### The Problem: Destructive Updates (Phase 1)
Traditional relational databases suffer from **destructive updates**. When an insurance customer moves to a new city or updates their policy premium, the `UPDATE` query physically overwrites the old data. If an auditor asks, "What was this customer's premium 6 months ago?", the database cannot answer. The history is permanently destroyed, opening the company to massive legal and financial liabilities.

### The Solution: Bi-Temporal Architecture (Phase 2)
To solve this, this project engineers a **Bi-Temporal Database**. This system natively tracks two dimensions of time for every single row of data:
1. **Valid Time:** When a fact is true in the real world (e.g., "This policy is active from Jan 1 to Dec 31").
2. **Transaction Time:** When the system actually recorded the fact (e.g., "The clerk entered this into the computer on Jan 5").

By deploying autonomous PostgreSQL Triggers, the database intercepts *every* `UPDATE` and `DELETE` operation. Instead of destroying the data, it perfectly archives the old version into a `_history` table and inserts the new version. This guarantees **100% data immutability and autonomous auditing** without requiring the application developers to write any historical tracking code.

---

## 2. Project Structure

The repository is divided into phases to clearly demonstrate this evolution:

*   **`Phase 1-Legacy_Simple_DBMS/`**: Contains the traditional, static database schema (the flawed architecture that destroys history).
*   **`Phase 2-Bi-Temporal_DBMS/`**: Contains the advanced Bi-Temporal architecture. This includes the DDL for active and history tables, autonomous PL/pgSQL triggers, the baseline data, and the time-travel views.
*   **`Phase 3-Comparison/`**: Contains architectural comparison reports and benchmarking data.

---

## 3. Prerequisites

To run this project on your device, you need the following software installed:

1. **PostgreSQL (14 or higher)**: The core relational database engine.
2. **pgAdmin 4** (or DBeaver / DataGrip): A visual database client to view tables and execute SQL.
3. **Python 3.x**: Required to run the data generation and analytics notebook.
4. **Jupyter Notebook**: To run the interactive `.ipynb` files. 

*(Make sure you have installed the required Python libraries: `sqlalchemy`, `psycopg2-binary`, `pandas`)*

---

## 4. Phase 1: Setup & Execution Guide (The Legacy System)

Before demonstrating the solution, we first run the legacy database to prove the fatal flaw of destructive updates.

### Step 1: Prepare the Phase 1 Database
1. Open pgAdmin.
2. Connect to your local PostgreSQL server.
3. Create a new, empty database named `insurance_legacy`.

### Step 2: Run the Notebook
1. Open your terminal or command prompt and navigate to the `Phase 1-Legacy_Simple_DBMS` folder.
2. Launch Jupyter by typing: `jupyter notebook`
3. Open the file named: `Insurance database python code.ipynb`
4. Update the database credentials in the notebook to match your local setup (`username` and `password`).

### Step 3: Initialize and Demonstrate Destructive Updates
1. Run the cells in the notebook. The script will automatically execute the `Insurance database DDL.sql` to build the tables and `Insurance database DML.sql` to insert the initial data.
2. The notebook contains a demonstration cell that shows a customer's premium *before* an update.
3. The next cell executes an `UPDATE` query (e.g., raising the premium to 1500).
4. Run the final query in the notebook to show the customer's data *after* the update. 
5. **The Conclusion:** Point out that the old premium is gone forever. If an auditor asks what the premium was yesterday, the database has no record of it. This proves the need for Phase 2.

---

## 5. Phase 2: Setup & Execution Guide (The Bi-Temporal System)

Now, we deploy the enterprise solution to fix the problem discovered in Phase 1.

### Step 1: Prepare the Phase 2 Database
1. In pgAdmin, create a new, empty database named `insurance_bitemporal`.

### Step 2: Run the Phase 2 Notebook
1. In your terminal, navigate to the `Phase 2-Bi-Temporal_DBMS` folder and launch `jupyter notebook`.
2. Open the file named: `Insurance database Python Code.ipynb`
3. Update the database credentials in the connection string cell.

### Step 3: Initialize the Baseline Database
Run the **`initialize_database(engine)`** cell. The Python script will connect to PostgreSQL and sequentially execute:
1. `DDL.sql` (Builds the tables)
2. `Functions.sql` & `Procedures.sql` (Builds the logic)
3. `Triggers.sql` (Attaches the Bi-Temporal automation)
4. `Bi-Temporal DML.sql` (Inserts exactly 100 realistic customers, policies, and claims).

*At this point, you have a fully populated, pristine database.*

### Step 4: Execute the Temporal Demonstration
Directly below the initialization cell, you will find an **Optional Demo Cell** containing the `run_temporal_demo(engine)` function.

**Uncomment and run this cell.** 
This executes `Insurance database Temporal Demo.sql`, which simulates a series of real-world events over time (e.g., Alice moving from Seattle to Manhattan, policies renewing with higher premiums, claims being approved). 

As this runs, the Bi-Temporal Triggers will automatically archive the old data into the `_history` tables without destroying anything.

---

## 6. Demonstrating the "Time Machine" (For Judges/Reviewers)

To prove to the judges that the Phase 2 database successfully captured the history, you will use the Time-Travel Queries.

1. Open **pgAdmin**.
2. Connect to the `insurance_bitemporal` database.
3. Open the file: `Phase 2-Bi-Temporal_DBMS/Insurance database Temporal Queries.sql`
4. Execute the top half of the file to generate the **Timeline Views** (e.g., `v_customer_timeline`). These views seamlessly stitch the active table and the history table together.
5. **Run the Demos:** At the bottom of that file, you will find 5 fully executable Demo queries under the heading **TIME-TRAVEL QUERY DEMONSTRATIONS**. 

**Highlight the following to the judges:**
*   **Demo 1 (Address Timeline):** Run the query to show exactly when Alice lived in Seattle vs. Manhattan. Point out that the `valid_from` and `valid_to` timestamps perfectly capture the duration of her residency.
*   **Demo 3 (Claim Lifecycle):** Run the query to show the exact timestamp a claim moved from `PENDING` to `APPROVED`.
*   **Demo 4 (AS OF Query):** Show them the ultimate power of Bi-Temporal databases by querying the database *exactly as it looked 5 minutes ago*, proving that no data is ever lost.

---

## 7. Conclusion
By completing these steps, you have successfully demonstrated a full architectural evolution. You first proved the flaw of destructive updates in Phase 1, and then successfully deployed an enterprise-grade Bi-Temporal Database in Phase 2. You have proven that the system can autonomously intercept destructive updates, archive historical data perfectly, and support complex retroactive time-travel queries without requiring any historical tracking logic in the application code.
