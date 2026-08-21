# 🏥 Hospital Operations BI

A data engineering and business intelligence project that transforms raw hospital patient data into a structured analytics model for operational reporting and Tableau dashboards.

The project demonstrates an end-to-end **Raw → Staging → Analytics → BI** pipeline using **Python, SQL Server, Docker, and Tableau**.

---

## 📌 Project Overview

The Hospital Operations BI project analyzes patient visits, treatment costs, length of stay, recovery scores, readmission risk, departments, and regional performance.

The goal is to build a reliable data pipeline that takes raw healthcare data and transforms it into a clean analytical model suitable for business intelligence and decision-making.

### Key Business Questions

* How many patient visits does the hospital receive?
* Which departments have the highest patient volume?
* Which departments generate the highest treatment costs?
* What is the average treatment cost per visit?
* What is the average length of stay?
* How does recovery performance differ between departments and regions?
* Which regions have the highest patient activity?
* What percentage of visits are emergency visits?
* Which treatment types are associated with higher costs?
* What is the distribution of readmission risk?
* How do hospital operations change over time?

---

## 🏗️ Architecture

```text
                    ┌─────────────────────────────┐
                    │ Healthcare Patient CSV      │
                    │ 5,000 Patient Records       │
                    └──────────────┬──────────────┘
                                   │
                                   ▼
                    ┌─────────────────────────────┐
                    │ RAW LAYER                   │
                    │ dbo.raw_patient_data        │
                    │ 5,000 rows                  │
                    └──────────────┬──────────────┘
                                   │
                                   ▼
                    ┌─────────────────────────────┐
                    │ STAGING LAYER               │
                    │ dbo.stg_patient_data        │
                    │ 5,000 rows                  │
                    │ Cleaned categorical values  │
                    └──────────────┬──────────────┘
                                   │
                                   ▼
             ┌─────────────────────┴─────────────────────┐
             │                                           │
             ▼                                           ▼
    ┌──────────────────┐                       ┌──────────────────┐
    │ DIMENSIONS       │                       │ FACT TABLE       │
    │                  │                       │                  │
    │ dim_date         │                       │ fact_patient     │
    │ dim_department   │◄─────────────────────►│ 5,000 rows       │
    │ dim_location     │                       │                  │
    └──────────────────┘                       └────────┬─────────┘
                                                        │
                                                        ▼
                                             ┌────────────────────┐
                                             │ BI / SQL Views     │
                                             │ KPI & Analysis     │
                                             └─────────┬──────────┘
                                                       │
                                                       ▼
                                             ┌────────────────────┐
                                             │ Tableau Dashboard  │
                                             └────────────────────┘
```

---

## 🛠️ Technologies Used

### Data Engineering

* Python
* Pandas
* SQL
* SQL Server
* Docker

### Business Intelligence

* Tableau

### Development Tools

* Git / GitHub
* VS Code
* macOS Terminal

---

## 📁 Project Structure

```text
hospital-operations-bi/
│
├── data/
│   ├── raw/
│   │   └── healthcare_patient_analytics_seaborn.csv
│   └── .DS_Store
│
├── docs/
│
├── script/
│   └── profile_data.py
│
├── sql/
│   ├── 01_create_raw_patient_table.sql
│   ├── 02_create_staging_patient_table.sql
│   ├── 03_load_staging_patient_data.sql
│   ├── 04_create_analytics_tables.sql
│   ├── 05_load_dimensions.sql
│   ├── 06_load_fact_patient.sql
│   └── 07_create_bi_views.sql
│
├── tableau/
│
├── .gitignore
└── README.md
```

---

# 📊 Dataset

The project uses:

```text
healthcare_patient_analytics_seaborn.csv
```

The dataset contains **5,000 patient visit records** and 12 columns.

### Dataset Columns

| Column                | Description                     |
| --------------------- | ------------------------------- |
| `patient_id`          | Unique patient/visit identifier |
| `visit_date`          | Date and time of the visit      |
| `age_group`           | Patient age category            |
| `gender`              | Patient gender                  |
| `region`              | Patient region                  |
| `department`          | Hospital department             |
| `treatment_type`      | Type of treatment received      |
| `visit_type`          | Routine or emergency visit      |
| `length_of_stay_days` | Length of hospital stay         |
| `treatment_cost`      | Cost of treatment               |
| `recovery_score`      | Patient recovery score          |
| `readmission_risk`    | Estimated readmission risk      |

---

# 🗄️ Database

The project uses **Microsoft SQL Server running inside Docker**.

### Database

```text
hospital_db
```

### SQL Server Container

```text
hospital_sqlserver
```

---

# 🧱 Data Layers

## 1. Raw Layer

Table:

```text
dbo.raw_patient_data
```

Purpose:

* Store the original source data
* Preserve the raw dataset
* Avoid modifying source records
* Provide a reliable ingestion layer

Current row count:

```text
5,000
```

---

## 2. Staging Layer

Table:

```text
dbo.stg_patient_data
```

Purpose:

* Prepare raw data for analytics
* Clean categorical text fields
* Provide an intermediate transformation layer

Categorical fields are cleaned using:

```sql
LTRIM(RTRIM(...))
```

Current row count:

```text
5,000
```

---

# ⭐ Analytics Layer

The analytics layer follows a simplified **star schema**.

## Dimension Tables

### `dbo.dim_date`

Contains:

* Date key
* Full date
* Year
* Quarter
* Month
* Month name
* Day
* Day name

Current row count:

```text
209
```

### `dbo.dim_department`

Contains hospital departments.

Current departments:

```text
Cardiology
General Medicine
Neurology
Orthopedics
Pediatrics
```

Current row count:

```text
5
```

### `dbo.dim_location`

Contains geographic regions.

Current regions:

```text
East
North
South
West
```

Current row count:

```text
4
```

---

## Fact Table

### `dbo.fact_patient`

The fact table stores measurable patient visit information.

It contains:

* Patient ID
* Date key
* Department key
* Location key
* Age group
* Gender
* Treatment type
* Visit type
* Length of stay
* Treatment cost
* Recovery score
* Readmission risk

Current row count:

```text
5,000
```

---

# 🔄 ETL Pipeline

The project currently follows these steps:

### Step 1 — Extract

Patient data is stored in:

```text
data/raw/healthcare_patient_analytics_seaborn.csv
```

### Step 2 — Load Raw Data

The CSV is copied into the SQL Server Docker container and loaded into:

```text
dbo.raw_patient_data
```

Result:

```text
5,000 rows loaded
```

### Step 3 — Staging

Raw data is transformed into:

```text
dbo.stg_patient_data
```

Categorical values are trimmed and prepared for analytical processing.

Result:

```text
5,000 rows
```

### Step 4 — Build Dimensions

The following dimensions are populated:

```text
dim_date
dim_department
dim_location
```

### Step 5 — Build Fact Table

Staging records are joined to the dimension tables using their corresponding keys.

Result:

```text
dbo.fact_patient
5,000 rows
```

---

# 📈 BI Views

SQL views are being created to provide Tableau-ready datasets.

The planned BI views are:

```text
vw_hospital_overview
vw_department_performance
vw_regional_performance
vw_treatment_analysis
vw_monthly_trend
vw_readmission_risk
```

These views will provide business-level metrics such as:

* Total visits
* Unique patients
* Total treatment cost
* Average treatment cost
* Average length of stay
* Average recovery score
* Average readmission risk
* Emergency visits
* Department performance
* Regional performance
* Treatment performance
* Monthly trends
* Readmission-risk categories

---

# 🧪 Data Validation

The following validations have been completed.

### Raw data

```text
5,000 rows
```

### Staging data

```text
5,000 rows
```

### Fact data

```text
5,000 rows
```

### Dimension counts

```text
dim_date          → 209
dim_department    → 5
dim_location      → 4
```

### Fact validation

Fact records successfully join to:

```text
dim_date
dim_department
dim_location
```

Sample records were successfully verified after joining the fact and dimension tables.

---

# 🔐 Database Credentials

Database credentials should **not** be committed to GitHub.

Use environment variables or a local `.env` file for credentials.

Example:

```text
DB_HOST=localhost
DB_PORT=1433
DB_NAME=hospital_db
DB_USER=sa
DB_PASSWORD=<your_password>
```

Make sure `.env` is included in `.gitignore`.

---

# 🚀 Running the Project

## 1. Start SQL Server

Start the Docker SQL Server container:

```bash
docker start hospital_sqlserver
```

Check that it is running:

```bash
docker ps
```

---

## 2. Create the Raw Table

```bash
docker exec -i hospital_sqlserver /opt/mssql-tools18/bin/sqlcmd \
-S localhost -U sa -P '<PASSWORD>' -C \
-d hospital_db \
< sql/01_create_raw_patient_table.sql
```

---

## 3. Create the Staging Table

```bash
docker exec -i hospital_sqlserver /opt/mssql-tools18/bin/sqlcmd \
-S localhost -U sa -P '<PASSWORD>' -C \
-d hospital_db \
< sql/02_create_staging_patient_table.sql
```

---

## 4. Load Staging Data

```bash
docker exec -i hospital_sqlserver /opt/mssql-tools18/bin/sqlcmd \
-S localhost -U sa -P '<PASSWORD>' -C \
-d hospital_db \
< sql/03_load_staging_patient_data.sql
```

---

## 5. Create Analytics Tables

```bash
docker exec -i hospital_sqlserver /opt/mssql-tools18/bin/sqlcmd \
-S localhost -U sa -P '<PASSWORD>' -C \
-d hospital_db \
< sql/04_create_analytics_tables.sql
```

---

## 6. Load Dimensions

```bash
docker exec -i hospital_sqlserver /opt/mssql-tools18/bin/sqlcmd \
-S localhost -U sa -P '<PASSWORD>' -C \
-d hospital_db \
< sql/05_load_dimensions.sql
```

---

## 7. Load Fact Table

```bash
docker exec -i hospital_sqlserver /opt/mssql-tools18/bin/sqlcmd \
-S localhost -U sa -P '<PASSWORD>' -C \
-d hospital_db \
< sql/06_load_fact_patient.sql
```

---

## 8. Create BI Views

```bash
docker exec -i hospital_sqlserver /opt/mssql-tools18/bin/sqlcmd \
-S localhost -U sa -P '<PASSWORD>' -C \
-d hospital_db \
< sql/07_create_bi_views.sql
```

---

# 📊 Planned Tableau Dashboard

The final Tableau dashboard will focus on hospital operational performance.

### Executive KPI Cards

* Total Patient Visits
* Total Treatment Cost
* Average Treatment Cost
* Average Length of Stay
* Average Recovery Score
* Average Readmission Risk

### Department Analysis

* Patient volume by department
* Treatment cost by department
* Average length of stay
* Recovery score
* Emergency visit volume

### Regional Analysis

* Patient volume by region
* Treatment cost by region
* Recovery performance
* Readmission risk

### Time Analysis

* Monthly patient visits
* Monthly treatment cost
* Monthly average length of stay
* Monthly recovery score

### Readmission Risk

Risk categories:

```text
Low       → < 0.20
Medium    → 0.20 – < 0.50
High      → ≥ 0.50
```

---

# 📌 Current Project Status

| Component             | Status         |
| --------------------- | -------------- |
| Dataset               | ✅              |
| Docker SQL Server     | ✅              |
| Database              | ✅              |
| Raw table             | ✅              |
| Raw data ingestion    | ✅              |
| Data profiling script | ✅              |
| Staging table         | ✅              |
| Staging data          | ✅              |
| Star schema           | ✅              |
| Date dimension        | ✅              |
| Department dimension  | ✅              |
| Location dimension    | ✅              |
| Fact table            | ✅              |
| Fact validation       | ✅              |
| BI views              | 🔄 In progress |
| Tableau connection    | ⏳              |
| Tableau dashboard     | ⏳              |
| Documentation         | 🔄             |

---

# 🎯 Future Improvements

Potential future enhancements include:

* Automated Python ETL pipeline
* Data quality checks
* Incremental data loading
* SQL Server indexes
* Additional analytical views
* Tableau dashboard development
* Automated data refresh
* KPI alerts
* Advanced readmission-risk analysis
* Department performance benchmarking

---

## 👩‍💻 Author

**Rashini Dissanayake**

Hospital Operations Business Intelligence & Data Engineering Project

---

## ⭐ Project Goal

Build a complete and practical **healthcare Business Intelligence pipeline** that demonstrates data ingestion, SQL data modeling, ETL processing, dimensional modeling, KPI development, and interactive Tableau reporting.

```text
Raw Healthcare Data
        ↓
Data Engineering
        ↓
SQL Server
        ↓
Dimensional Model
        ↓
Business Intelligence
        ↓
Tableau Dashboard
        ↓
Hospital Operational Insights
```
