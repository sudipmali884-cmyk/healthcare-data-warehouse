WITH patient_history AS (

    SELECT *

    FROM {{ ref('int_patient_history') }}

)

SELECT

    ---------------------------------------------------
    -- Primary Key
    ---------------------------------------------------

    patient_id,

    ---------------------------------------------------
    -- Personal Details
    ---------------------------------------------------

    patient_name,

    patient_gender,

    dob,

    ---------------------------------------------------
    -- Age
    ---------------------------------------------------

    DATEDIFF(
        YEAR,
        dob,
        CURRENT_DATE()
    ) AS age,

    ---------------------------------------------------
    -- Location
    ---------------------------------------------------

    city,

    state,

    ---------------------------------------------------
    -- Business Metrics
    ---------------------------------------------------

    total_appointments,

    completed_appointments,

    cancelled_appointments,

    first_visit_date,

    last_visit_date,

    last_doctor_id,

    last_hospital_id

FROM patient_history