USE hospital_db;
GO

/* =========================================================
   DIMENSION: DATE
   ========================================================= */

IF OBJECT_ID('dbo.dim_date', 'U') IS NOT NULL
    DROP TABLE dbo.dim_date;
GO

CREATE TABLE dbo.dim_date
(
    date_key        INT             NOT NULL,
    full_date       DATE            NOT NULL,
    year_number     INT             NOT NULL,
    quarter_number  INT             NOT NULL,
    month_number    INT             NOT NULL,
    month_name      VARCHAR(20)     NOT NULL,
    day_number      INT             NOT NULL,
    day_name        VARCHAR(20)     NOT NULL,

    CONSTRAINT PK_dim_date
        PRIMARY KEY (date_key)
);
GO


/* =========================================================
   DIMENSION: DEPARTMENT
   ========================================================= */

IF OBJECT_ID('dbo.dim_department', 'U') IS NOT NULL
    DROP TABLE dbo.dim_department;
GO

CREATE TABLE dbo.dim_department
(
    department_key     INT IDENTITY(1,1) NOT NULL,
    department_name    VARCHAR(100)       NOT NULL,

    CONSTRAINT PK_dim_department
        PRIMARY KEY (department_key),

    CONSTRAINT UQ_dim_department
        UNIQUE (department_name)
);
GO


/* =========================================================
   DIMENSION: LOCATION
   ========================================================= */

IF OBJECT_ID('dbo.dim_location', 'U') IS NOT NULL
    DROP TABLE dbo.dim_location;
GO

CREATE TABLE dbo.dim_location
(
    location_key    INT IDENTITY(1,1) NOT NULL,
    region_name     VARCHAR(100)       NOT NULL,

    CONSTRAINT PK_dim_location
        PRIMARY KEY (location_key),

    CONSTRAINT UQ_dim_location
        UNIQUE (region_name)
);
GO


/* =========================================================
   FACT: PATIENT VISITS
   ========================================================= */

IF OBJECT_ID('dbo.fact_patient', 'U') IS NOT NULL
    DROP TABLE dbo.fact_patient;
GO

CREATE TABLE dbo.fact_patient
(
    patient_id              INT             NOT NULL,
    date_key                INT             NOT NULL,
    department_key          INT             NOT NULL,
    location_key            INT             NOT NULL,

    age_group               VARCHAR(20)     NOT NULL,
    gender                  VARCHAR(20)     NOT NULL,
    treatment_type          VARCHAR(100)    NOT NULL,
    visit_type              VARCHAR(50)     NOT NULL,

    length_of_stay_days     DECIMAL(5,2)    NOT NULL,
    treatment_cost          DECIMAL(12,2)   NOT NULL,
    recovery_score          DECIMAL(5,2)    NOT NULL,
    readmission_risk        DECIMAL(5,2)    NOT NULL,

    CONSTRAINT PK_fact_patient
        PRIMARY KEY (patient_id),

    CONSTRAINT FK_fact_patient_date
        FOREIGN KEY (date_key)
        REFERENCES dbo.dim_date(date_key),

    CONSTRAINT FK_fact_patient_department
        FOREIGN KEY (department_key)
        REFERENCES dbo.dim_department(department_key),

    CONSTRAINT FK_fact_patient_location
        FOREIGN KEY (location_key)
        REFERENCES dbo.dim_location(location_key)
);
GO