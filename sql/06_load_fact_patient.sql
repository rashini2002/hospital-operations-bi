USE hospital_db;
GO

INSERT INTO dbo.fact_patient
(
    patient_id,
    date_key,
    department_key,
    location_key,
    age_group,
    gender,
    treatment_type,
    visit_type,
    length_of_stay_days,
    treatment_cost,
    recovery_score,
    readmission_risk
)
SELECT
    s.patient_id,

    d.date_key,

    dept.department_key,

    loc.location_key,

    s.age_group,
    s.gender,
    s.treatment_type,
    s.visit_type,
    s.length_of_stay_days,
    s.treatment_cost,
    s.recovery_score,
    s.readmission_risk

FROM dbo.stg_patient_data AS s

INNER JOIN dbo.dim_date AS d
    ON d.full_date = CAST(s.visit_date AS DATE)

INNER JOIN dbo.dim_department AS dept
    ON dept.department_name = s.department

INNER JOIN dbo.dim_location AS loc
    ON loc.region_name = s.region;
GO
