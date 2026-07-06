# Chapter 8: Python Notebook Integration

This chapter explains the role of the Jupyter Notebook (`Insurance database Python Code.ipynb`), which acts as the simulated application layer driving the database deployment and temporal demonstrations.

---

## 8.1 Purpose

The Python notebook serves three primary purposes:
1. **Automated Deployment:** It sequentially executes the massive `.sql` files (`DDL.sql`, `Functions.sql`, `Triggers.sql`, `Procedures.sql`, `DML.sql`, `Temporal Demo.sql`) to instantiate the database from a cold start.
2. **Business Analytics:** It extracts data from the PostgreSQL engine and converts it into Pandas DataFrames for complex aggregation and graphing.
3. **Temporal Demonstration:** It acts as the "Time Machine Controller," allowing the presenter to trigger specific historical updates (like a customer moving to a new city) and immediately visualize the before-and-after states.

---

## 8.2 Libraries and Dependencies

- **`sqlalchemy`:** The industry-standard SQL toolkit and Object-Relational Mapper (ORM) for Python. Used to create a robust connection engine.
- **`psycopg2` / `psycopg2-binary`:** The underlying PostgreSQL database adapter used by SQLAlchemy.
- **`pandas`:** Used to ingest the SQL query results (`pd.read_sql()`) and convert them into highly manipulatable DataFrame objects.
- **`matplotlib.pyplot` & `seaborn`:** Used for generating professional, enterprise-grade charts and graphs for the analytical queries.

---

## 8.3 Connection to PostgreSQL

The connection is strictly established using SQLAlchemy, bypassing raw `psycopg2` connections.

```python
from sqlalchemy import create_engine
import pandas as pd

# Creating the SQLAlchemy engine
engine = create_engine('postgresql://username:password@localhost:5432/insurance_bitemporal')

# Using the engine to run a query safely
df = pd.read_sql("SELECT * FROM insurance.v_customer_timeline", engine)
```

**Why this matters:**
Pandas explicitly throws a `UserWarning` if you attempt to pass a raw `psycopg2` connection object to `read_sql()`. SQLAlchemy handles connection pooling, prevents memory leaks, and securely translates the SQL dialect.

---

## 8.4 Execution and Workflow

The notebook is divided into logical cells that must be executed sequentially:

1. **The Deployment Cell:** Reads the SQL files from disk and executes them via `engine.execute()`. This builds the 10-table architecture and compiles the API.
2. **The Baseline Injection Cell:** Calls the stored procedures (e.g., `create_customer`, `create_policy`) to inject 100+ rows of realistic mock data.
3. **The Temporal Demo Cell (Phase 2 only):** Separated intentionally. When executed, it calls `update_customer_address()` and `renew_policy()`. The user can literally watch the database intercept these changes and write to the history tables.

---

## 8.5 Outputs and Visualization

After the data is injected, the notebook runs Data Query Language (DQL) statements to generate business intelligence outputs.

- **Example Query:** Revenue by Branch.
  ```sql
  SELECT c.City, SUM(p.Premium) as Total_Revenue
  FROM insurance.Company c
  JOIN insurance.Policy p ON c.Branch_id = p.Branch_id
  GROUP BY c.City;
  ```
- **Visualization:** The notebook uses `seaborn.barplot` to map the `City` column to the X-axis and `Total_Revenue` to the Y-axis. 
- **Business Value:** It proves to executives that the complex Bi-Temporal architecture does not interfere with standard analytical reporting.

---

## 8.6 How the Notebook Interacts with the Database

1. **Strict API Usage:** The notebook *never* runs an `INSERT` statement directly on the Phase 2 database. It is forced to use the Stored Procedure API (e.g., `CALL insurance.record_payment(...)`).
2. **Transaction Integrity:** If a Jupyter cell tries to insert a claim that exceeds the policy coverage, PostgreSQL throws an exception. The cell execution halts, and PostgreSQL rolls back the transaction, protecting the database from Python-level errors.

---

## 8.7 Possible Improvements (Future Scope)

While the notebook is an excellent prototyping and demonstration tool, it is not production-ready for enterprise applications.

1. **Connection Pooling:** In a real-world scenario, a web backend (like Django or FastAPI) would use SQLAlchemy's `QueuePool` to manage thousands of concurrent connections.
2. **Environment Variables:** Hardcoding the `username` and `password` in the connection string is a security risk. A production app would load these from a `.env` file or a secrets manager like AWS Secrets Manager.
3. **ORM Implementation:** Instead of passing raw SQL strings, the application could map the PostgreSQL tables to Python Classes using SQLAlchemy's ORM, allowing object-oriented database manipulation.

---

## Chapter 8 Summary
The Python notebook bridges the gap between the raw PostgreSQL backend and the business intelligence frontend. It acts as both the deployment automation script and the analytical dashboard. By strictly utilizing SQLAlchemy and the Database API (Stored Procedures), it mimics the secure interaction model of a real enterprise application.

### Key Takeaways
- Always use **SQLAlchemy** to connect Pandas to PostgreSQL, never raw psycopg2.
- The notebook proves that standard business intelligence queries can run on top of a highly complex Bi-Temporal architecture without modification.

### Interview Tips
> **Tip:** If an interviewer asks how you handled database security in your Python code, admit the flaw: "Currently, the credentials are in the notebook for demonstration purposes. However, if deploying to production, I would strictly use `os.environ.get('DB_PASSWORD')` or a secure `.env` file to prevent leaking secrets to GitHub."

### Review Questions
1. Why does Pandas prefer an SQLAlchemy engine over a raw connection object?
2. How does the notebook interact with the Phase 2 database when inserting a new customer?
3. What happens in the notebook if the PostgreSQL engine throws a `RAISE EXCEPTION`?
