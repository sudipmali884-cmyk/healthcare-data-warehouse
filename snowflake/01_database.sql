-- =============================================
-- Healthcare Data Warehouse
-- Database Creation
-- =============================================

CREATE OR REPLACE WAREHOUSE healthcare_wh
WITH
WAREHOUSE_SIZE='XSMALL'
AUTO_SUSPEND=60
AUTO_RESUME=TRUE;

USE WAREHOUSE healthcare_wh;

-------------------------------------------------

CREATE OR REPLACE DATABASE healthcare_db;

USE DATABASE healthcare_db;

-------------------------------------------------

CREATE OR REPLACE SCHEMA raw;

CREATE OR REPLACE SCHEMA staging;

CREATE OR REPLACE SCHEMA marts;

-------------------------------------------------

SHOW DATABASES;

SHOW SCHEMAS;