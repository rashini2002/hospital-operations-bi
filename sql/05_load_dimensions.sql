USE hospital_db;
GO

/* =========================================================
   LOAD DATE DIMENSION
   ========================================================= */

INSERT INTO dbo.dim_date
(
    date_key,
    full_date,
    year_number,
    quarter_number,
    month_number,
    month_name,
    day_number,
    day_name
)
SELECT DISTINCT
    CONVERT(INT, CONVERT(VARCHAR(8), CAST(visit_date AS DATE), 112)) AS date_key,
    CAST(visit_date AS DATE) AS full_date,
    YEAR(visit_date) AS year_number,
    DATEPART(QUARTER, visit_date) AS quarter_number,
    MONTH(visit_date) AS month_number,
    DATENAME(MONTH, visit_date) AS month_name,
    DAY(visit_date) AS day_number,
    DATENAME(WEEKDAY, visit_date) AS day_name
FROM dbo.stg_patient_data;
GO


/* =========================================================
   LOAD DEPARTMENT DIMENSION
   ========================================================= */

INSERT INTO dbo.dim_department
(
    department_name
)
SELECT DISTINCT
    department
FROM dbo.stg_patient_data
ORDER BY department;
GO


/* =========================================================
   LOAD LOCATION DIMENSION
   ========================================================= */

INSERT INTO dbo.dim_location
(
    region_name
)
SELECT DISTINCT
    region
FROM dbo.stg_patient_data
ORDER BY region;
GO
