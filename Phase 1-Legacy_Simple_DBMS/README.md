# Phase 1: Legacy Simple DBMS

This directory contains the original, baseline version of the **Insurance Management System**. 

This phase represents a traditional SQL-based relational database design. While it effectively models the complex relationships required for an insurance company (customers, branches, agents, claims, and policies), it is fundamentally a **static** database. It suffers from the destructive update problem, meaning that standard `UPDATE` or `DELETE` commands permanently overwrite or remove historical facts.

This legacy architecture serves as the starting point (the "Before" picture) for the project, which is ultimately transformed into an enterprise-grade Bi-Temporal database in Phase 2.

## 📂 File Structure

*   **`Insurance database DDL.sql`**: Data Definition Language script that creates the baseline relational schema, including all tables, primary keys, and foreign keys.
*   **`Insurance database DML.sql`**: Data Manipulation Language script containing `INSERT` statements to populate the database with dummy data, as well as destructive `UPDATE` and `DELETE` commands.
*   **`Insurance database DQL.sql`**: Data Query Language script containing `SELECT` statements used to extract business analytics.
*   **`Insurance database DCL.sql`**: Data Control Language script for creating users and granting database privileges.
*   **`Insurance database TCL.sql`**: Transaction Control Language script demonstrating `COMMIT` and `ROLLBACK` mechanisms.
*   **`Insurance database Python Code.ipynb`**: A Jupyter Notebook demonstrating how to connect to the PostgreSQL database using `psycopg2` and create visualizations for business analytics.
*   **`ER Diagram.png`**: The original Entity-Relationship diagram mapping the legacy architecture.
*   **`Insurance database Sample Data.sql`**: (Placeholder) File for generating pure sample data inserts.

## 📊 Relational Model

The legacy relational model comprises interconnected tables that store essential information:
- **Company**: Captures details about branches (Branch_ID, city, zipcode).
- **Agent**: Stores agent-specific information (Agent_ID, email, name).
- **Customer**: Holds customer data (Customer_ID, date of birth, name, address).
- **Payment**: Contains payment details (amount, payment date, Customer_ID).
- **Policy**: Stores policy information (start date, end date, premium, coverage).
- **Claim**: Stores data related to claims (amount issued, status, date).
- **Health / Car / Home**: Captures specific details for each polymorphic policy type.

## 📈 Baseline Analytics (Problem Statements)

This legacy database was originally designed to answer the following business questions via Python visualizations:
- Number of customers and agents in each city.
- Top-performing agents based on the number of policies.
- List of customers with multiple policies.
- Annual change in health insurance policies (impact of Covid).
- Year-wise revenue analysis.
- Categorization of insurance policies by premium amount and customer count.
- Age group of customers interested in insurance.

> **Note:** For the advanced, time-travel-capable architecture that solves the destructive update flaws inherent to this legacy design, please see the `Phase 2-Bi-Temporal_DBMS` directory.
