WITH appointment_metrics AS (

    SELECT *

    FROM {{ ref('int_appointment_metrics') }}

)

SELECT

    --------------------------------------------------
    -- Primary Key
    --------------------------------------------------

    appointment_id,

    --------------------------------------------------
    -- Foreign Keys
    --------------------------------------------------

    patient_id,

    doctor_id,

    hospital_id,

    --------------------------------------------------
    -- Date
    --------------------------------------------------

--    appointment_date,
    to_number(to_Char(
    appointment_date,'YYYYMMDD')) as appointment_date_key,
    appointment_year,

    appointment_quarter,

    appointment_month,

    appointment_month_name,

    appointment_week,

    appointment_day,

    appointment_day_name,

    day_type,

    --------------------------------------------------
    -- Measures
    --------------------------------------------------

    consultation_fee,

    revenue,

    waiting_time_minutes,

    --------------------------------------------------
    -- Categories
    --------------------------------------------------

    consultation_fee_bucket,

    waiting_time_bucket,

    consultation_type,

    appointment_status,

    --------------------------------------------------
    -- Flags
    --------------------------------------------------

    completed_flag,

    cancelled_flag,

    no_show_flag

FROM appointment_metrics