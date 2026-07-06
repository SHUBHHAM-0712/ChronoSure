# Chapter 2: Repository Walkthrough

## 2.1 Project Organization Strategy

The repository for the Insurance Database Management System is explicitly organized into sequential "Phases." This structure is highly intentional. Rather than presenting the final Bi-Temporal database as a monolithic endpoint, the repository walks a developer through the chronological evolution of the architecture. 

By separating the project into Phase 1 (Legacy) and Phase 2 (Bi-Temporal), developers and reviewers can run side-by-side comparisons of the schemas, query performance, and historical tracking capabilities.

---

## 2.2 Root Directory Overview

The root of the repository acts as the entry point for developers and auditors.

- **`README.md`**: The professional landing page of the project. It contains the executive summary, quick-start installation commands, architectural highlights, and basic troubleshooting.
- **`Phase 1-Legacy_Simple_DBMS/`**: Contains the baseline standard relational database.
- **`Phase 2-Bi-Temporal_DBMS/`**: Contains the final, enterprise-grade Bi-Temporal solution.
- **`Phase 3-Comparison/`**: Contains analytical reports comparing the two architectures.
- **`Project Documentation/`**: Contains in-depth architectural documents, thesis reports, and this official documentation.

---

## 2.3 Detailed Folder Breakdown

### 2.3.1 `Phase 1-Legacy_Simple_DBMS/`
**Why it exists:** To establish the baseline. Without Phase 1, it is impossible to prove *why* Phase 2 is necessary. Phase 1 proves the fatal flaw of destructive updates.

**What to expect inside:**
- **`ER Diagram.png`**: The visual representation of the traditional 3NF schema.
- **`Insurance database DDL.sql`**: The Data Definition Language script that builds standard, static tables (`customer`, `policy`, etc.).
- **`Insurance database DML.sql`**: The Data Manipulation Language script containing the `INSERT` statements to populate the initial mock data.
- **`Insurance database DQL.sql`**: The Data Query Language script containing standard operational queries.
- **`Insurance database python code.ipynb`**: A Jupyter Notebook that connects to PostgreSQL to run basic business analytics on the static data.

*Note: As per user specifications, missing TCL/DCL files were intentionally omitted from this baseline phase to focus purely on schema architecture.*

### 2.3.2 `Phase 2-Bi-Temporal_DBMS/`
**Why it exists:** This is the core deliverable of the project. It represents the fully engineered enterprise solution that solves the destructive update problem via autonomous tracking.

**What to expect inside:**
- **`Bi-Temporal ER Diagram.png`**: The advanced schema showing active vs. history table mirroring.
- **`Insurance database Bi-Temporal DDL.sql`**: Builds the two-tiered physical schema (e.g., `customer` and `customer_history`).
- **`Insurance database Functions.sql`**: Contains the master PL/pgSQL function (`bitemporal_versioning_fn`) that dictates the archiving logic.
- **`Insurance database Triggers.sql`**: Attaches the master function to every `UPDATE` and `DELETE` event on the active tables.
- **`Insurance database Procedures.sql`**: Encapsulates all database mutations (inserts, updates) behind a strict API.
- **`Insurance database Bi-Temporal DML.sql`**: The baseline data generator, safely inserting 100+ rows through the procedures.
- **`Insurance database Temporal Demo.sql`**: A simulation script that executes time-travel events (like address changes) to trigger the historical archiving.
- **`Insurance database Temporal Queries.sql`**: Contains the `UNION ALL` Timeline Views and the time-travel `AS OF` queries.
- **`Insurance database Python Code.ipynb`**: The advanced Python notebook that automates the deployment of the entire Bi-Temporal stack.

### 2.3.3 `Phase 3-Comparison/`
**Why it exists:** To quantitatively and qualitatively prove the superiority of the Bi-Temporal architecture over the Legacy architecture. It is heavily utilized during presentation/viva evaluations.

**What to expect inside:**
- **`Feature Comparison.md`**: A matrix comparing audit capabilities, compliance, and backward compatibility.
- **`Legacy vs Bi-Temporal Database.md`**: A deep-dive analytical report.
- **`Performance Comparison.md`**: Analyzes the O(1) active query speeds against the slightly higher storage overhead.
- **`Query Comparison.md`**: Shows the exact SQL differences between querying a standard table vs. querying a Timeline View.
- **`Demo Guide.md`**: A step-by-step presentation script designed for 10-minute demonstrations.

### 2.3.4 `Project Documentation/`
**Why it exists:** To hold all long-form, non-executable technical literature.
**What to expect inside:**
- **`Software Architecture.md`**: Detailed architectural flows, Mermaid diagrams, and design decisions.
- **`Official Documentation/`**: This multi-chapter textbook (which you are currently reading).

---

## 2.4 Developer Workflow Expectations

A new developer joining the project should adhere to the following workflow when navigating the repository:

1. **Start at Phase 1:** Understand the business entities (Customer, Agent, Policy). Do not look at the temporal metadata until the core business relationships are understood.
2. **Move to Phase 2 DDL:** Observe how `valid_from` and `transaction_to` were injected into the tables.
3. **Analyze the Automation Layer:** Read `Functions.sql` and `Triggers.sql` simultaneously to understand how data moves from active to history tables.
4. **Run the Notebook:** Execute the Phase 2 Jupyter Notebook to instantly deploy the entire architecture to a local PostgreSQL instance.

---

## Chapter 2 Summary
The repository is strictly organized into chronological phases (Legacy → Bi-Temporal → Comparison). This enforces a learning path that forces developers to first understand the problem (destructive updates) before reviewing the highly complex solution (temporal triggers and history tables).

### Key Takeaways
- **Phase 1** is the baseline problem.
- **Phase 2** is the enterprise solution (The Bi-Temporal Engine).
- **Phase 3** contains the academic and performance proofs.

### Interview Tips
> **Tip:** If asked "How is your project structured?", do not just list the folders. Explain the *reasoning* behind the structure. State: "I specifically separated the project into Phase 1 and Phase 2 so that reviewers could execute both databases side-by-side and physically witness the destructive updates happening in Phase 1, contrasting with the perfect history preservation in Phase 2."

### Common Mistakes
- **Mixing Phase 1 and Phase 2 Scripts:** Running a Phase 2 DML script against a Phase 1 DDL schema will crash immediately because Phase 1 lacks the temporal metadata columns (`valid_from`, `version_number`). Ensure your PostgreSQL connection strings in pgAdmin and Jupyter are pointing to the correct databases (`insurance_legacy` vs `insurance_bitemporal`).

### Review Questions
1. Why does the repository contain a `Phase 1-Legacy` folder if the final goal is the Bi-Temporal database?
2. Which file in Phase 2 contains the master automation logic for the database?
3. Where should an evaluator look to find a step-by-step presentation script?
