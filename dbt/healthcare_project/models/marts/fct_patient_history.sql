select *

from {{ ref('int_patient_history') }}
--
--limit 20;
--
----Option 2 — Run directly in Snowflake
----
--After int_patient_history has been created successfully, run:
--
--SELECT *
--FROM healthcare_db.raw_intermediate.int_patient_history
--LIMIT 20;