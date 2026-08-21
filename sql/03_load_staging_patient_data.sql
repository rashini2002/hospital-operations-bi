USE hospital_db;
GO

INSERT INTO dbo.stg_patient_data
(
    patient_id,
    visit_date,
    age_group,
    gender,
    region,
    department,
    treatment_type,
    visit_type,
    length_of_stay_days,
    treatment_cost,
    recovery_score,
    readmission_risk
)
SELECT
    patient_id,
    visit_date,
    LTRIM(RTRIM(age_group)),
    LTRIM(RTRIM(gender)),
    LTRIM(RTRIM(region)),
    LTRIM(RTRIM(department)),
    LTRIM(RTRIM(treatment_type)),
    LTRIM(RTRIM(visit_type)),
    length_of_stay_days,
    treatment_cost,
    recovery_score,
    readmission_risk
FROM dbo.raw_patient_data;
GO