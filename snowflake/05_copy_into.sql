-- =============================================
-- Healthcare Data Warehouse
-- COPY INTO
-- =============================================

USE DATABASE healthcare_db;

USE SCHEMA raw;

--1 LOAD HOSPITALS
COPY INTO hospitals

FROM @healthcare_stage/hospitals.csv

FILE_FORMAT = (

    FORMAT_NAME = healthcare_csv_format

)

MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE

ON_ERROR = CONTINUE;

-- 2 DOCTORS

COPY INTO doctors

FROM @healthcare_stage/doctors.csv

FILE_FORMAT = (

    FORMAT_NAME = healthcare_csv_format

)

MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE

ON_ERROR = CONTINUE;

--3 LOAD PATIENTS

COPY INTO patients

FROM @healthcare_stage/patients.csv

FILE_FORMAT = (

    FORMAT_NAME = healthcare_csv_format

)

MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE

ON_ERROR = CONTINUE;
--4 LOAD INSURANCE

COPY INTO insurance

FROM @healthcare_stage/insurance.csv

FILE_FORMAT=(

FORMAT_NAME=healthcare_csv_format

)

MATCH_BY_COLUMN_NAME=CASE_INSENSITIVE

ON_ERROR=CONTINUE;

--5 LOAD APPOINTMENTS

COPY INTO appointments

FROM @healthcare_stage/appointments.csv

FILE_FORMAT=(

FORMAT_NAME=healthcare_csv_format

)

MATCH_BY_COLUMN_NAME=CASE_INSENSITIVE

ON_ERROR=CONTINUE



--6 LOAN PRESCRIPTIONS

COPY INTO prescriptions

FROM @healthcare_stage/prescriptions.csv

FILE_FORMAT=(

FORMAT_NAME=healthcare_csv_format

)

MATCH_BY_COLUMN_NAME=CASE_INSENSITIVE

ON_ERROR=CONTINUE;