-- ============================================
-- Internal Stage
-- ============================================

USE DATABASE healthcare_db;

USE SCHEMA raw;

------------------------------------------------

CREATE OR REPLACE STAGE healthcare_stage

FILE_FORMAT = healthcare_csv_format;

------------------------------------------------

SHOW STAGES;