USE hospital_db;
GO

IF OBJECT_ID('dbo.stg_patient_data', 'U') IS NOT NULL
    DROP TABLE dbo.stg_patient_data;
GO

CREATE TABLE dbo.stg_patient_data
(
    patient_id              INT             NOT NULL,
    visit_date              DATETIME2       NOT NULL,
    age_group               VARCHAR(20)     NOT NULL,
    gender                  VARCHAR(20)     NOT NULL,
    region                  VARCHAR(100)    NOT NULL,
    department              VARCHAR(100)    NOT NULL,
    treatment_type          VARCHAR(100)    NOT NULL,
    visit_type              VARCHAR(50)     NOT NULL,
    length_of_stay_days     DECIMAL(5,2)     NOT NULL,
    treatment_cost          DECIMAL(12,2)    NOT NULL,
    recovery_score          DECIMAL(5,2)     NOT NULL,
    readmission_risk        DECIMAL(5,2)     NOT NULL,

    CONSTRAINT PK_stg_patient_data
        PRIMARY KEY (patient_id)
);
GO