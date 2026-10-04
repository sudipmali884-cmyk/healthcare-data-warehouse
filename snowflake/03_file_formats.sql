-- ============================================
-- Healthcare Data Warehouse
-- File Format
-- ============================================

USE DATABASE healthcare_db;

USE SCHEMA raw;

------------------------------------------------

CREATE OR REPLACE FILE FORMAT healthcare_csv_format

TYPE = CSV

FIELD_DELIMITER = ','

SKIP_HEADER = 1

FIELD_OPTIONALLY_ENCLOSED_BY = '"'

EMPTY_FIELD_AS_NULL = TRUE

NULL_IF = ('NULL','','null')

TRIM_SPACE = TRUE;

------------------------------------------------

SHOW FILE FORMATS;