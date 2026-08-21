USE hospital_db;
GO

/* =========================================================
   1. HOSPITAL OVERVIEW
   ========================================================= */

CREATE OR ALTER VIEW dbo.vw_hospital_overview
AS
SELECT
    COUNT(*) AS total_visits,
    COUNT(DISTINCT patient_id) AS unique_patients,
    SUM(treatment_cost) AS total_treatment_cost,
    AVG(treatment_cost) AS avg_treatment_cost,
    AVG(length_of_stay_days) AS avg_length_of_stay,
    AVG(recovery_score) AS avg_recovery_score,
    AVG(readmission_risk) AS avg_readmission_risk,
    SUM(CASE WHEN visit_type = 'Emergency' THEN 1 ELSE 0 END) AS emergency_visits,
    SUM(CASE WHEN visit_type = 'Routine' THEN 1 ELSE 0 END) AS routine_visits
FROM dbo.fact_patient;
GO


/* =========================================================
   2. DEPARTMENT PERFORMANCE
   ========================================================= */

CREATE OR ALTER VIEW dbo.vw_department_performance
AS
SELECT
    d.department_name,
    COUNT(*) AS total_visits,
    SUM(f.treatment_cost) AS total_treatment_cost,
    AVG(f.treatment_cost) AS avg_treatment_cost,
    AVG(f.length_of_stay_days) AS avg_length_of_stay,
    AVG(f.recovery_score) AS avg_recovery_score,
    AVG(f.readmission_risk) AS avg_readmission_risk,
    SUM(CASE WHEN f.visit_type = 'Emergency' THEN 1 ELSE 0 END) AS emergency_visits
FROM dbo.fact_patient f
INNER JOIN dbo.dim_department d
    ON f.department_key = d.department_key
GROUP BY
    d.department_name;
GO


/* =========================================================
   3. REGIONAL PERFORMANCE
   ========================================================= */

CREATE OR ALTER VIEW dbo.vw_regional_performance
AS
SELECT
    l.region_name,
    COUNT(*) AS total_visits,
    SUM(f.treatment_cost) AS total_treatment_cost,
    AVG(f.treatment_cost) AS avg_treatment_cost,
    AVG(f.length_of_stay_days) AS avg_length_of_stay,
    AVG(f.recovery_score) AS avg_recovery_score,
    AVG(f.readmission_risk) AS avg_readmission_risk
FROM dbo.fact_patient f
INNER JOIN dbo.dim_location l
    ON f.location_key = l.location_key
GROUP BY
    l.region_name;
GO


/* =========================================================
   4. TREATMENT ANALYSIS
   ========================================================= */

CREATE OR ALTER VIEW dbo.vw_treatment_analysis
AS
SELECT
    treatment_type,
    COUNT(*) AS total_visits,
    SUM(treatment_cost) AS total_treatment_cost,
    AVG(treatment_cost) AS avg_treatment_cost,
    AVG(length_of_stay_days) AS avg_length_of_stay,
    AVG(recovery_score) AS avg_recovery_score,
    AVG(readmission_risk) AS avg_readmission_risk
FROM dbo.fact_patient
GROUP BY
    treatment_type;
GO


/* =========================================================
   5. MONTHLY TREND
   ========================================================= */

CREATE OR ALTER VIEW dbo.vw_monthly_trend
AS
SELECT
    d.year_number,
    d.month_number,
    d.month_name,
    COUNT(*) AS total_visits,
    SUM(f.treatment_cost) AS total_treatment_cost,
    AVG(f.treatment_cost) AS avg_treatment_cost,
    AVG(f.length_of_stay_days) AS avg_length_of_stay,
    AVG(f.recovery_score) AS avg_recovery_score,
    AVG(f.readmission_risk) AS avg_readmission_risk
FROM dbo.fact_patient f
INNER JOIN dbo.dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.year_number,
    d.month_number,
    d.month_name;
GO


/* =========================================================
   6. READMISSION RISK ANALYSIS
   ========================================================= */

CREATE OR ALTER VIEW dbo.vw_readmission_risk
AS
SELECT
    CASE
        WHEN readmission_risk < 0.20 THEN 'Low'
        WHEN readmission_risk < 0.50 THEN 'Medium'
        ELSE 'High'
    END AS risk_category,

    COUNT(*) AS total_visits,

    AVG(readmission_risk) AS avg_readmission_risk,

    AVG(treatment_cost) AS avg_treatment_cost,

    AVG(length_of_stay_days) AS avg_length_of_stay,

    AVG(recovery_score) AS avg_recovery_score

FROM dbo.fact_patient
GROUP BY
    CASE
        WHEN readmission_risk < 0.20 THEN 'Low'
        WHEN readmission_risk < 0.50 THEN 'Medium'
        ELSE 'High'
    END;
GO