WITH appointments AS (

    SELECT *

    FROM {{ ref('stg_appointments') }}

)

SELECT

    -------------------------------------------------
    -- Keys
    -------------------------------------------------

    appointment_id,

    patient_id,

    doctor_id,

    hospital_id,

    appointment_date,

    consultation_type,

    consultation_fee,

    waiting_time_minutes,

    appointment_status,

    -------------------------------------------------
    -- Waiting Time Bucket
    -------------------------------------------------

    CASE

        WHEN waiting_time_minutes IS NULL
            THEN 'Unknown'

        WHEN waiting_time_minutes <= 15
            THEN '0-15 Minutes'

        WHEN waiting_time_minutes <= 30
            THEN '16-30 Minutes'

        WHEN waiting_time_minutes <= 60
            THEN '31-60 Minutes'

        ELSE '60+ Minutes'

    END AS waiting_time_bucket,

    -------------------------------------------------
    -- Consultation Fee Bucket
    -------------------------------------------------

    CASE

        WHEN consultation_fee < 500
            THEN 'Low'

        WHEN consultation_fee < 1000
            THEN 'Medium'

        WHEN consultation_fee < 2000
            THEN 'High'

        ELSE 'Premium'

    END AS consultation_fee_bucket,

    -------------------------------------------------
    -- Revenue Flag
    -------------------------------------------------

    CASE

        WHEN appointment_status='Completed'

            THEN consultation_fee

        ELSE 0

    END AS revenue,

    -------------------------------------------------
    -- Appointment Flags
    -------------------------------------------------

    CASE
        WHEN appointment_status='Completed'
        THEN 1
        ELSE 0
    END AS completed_flag,

    CASE
        WHEN appointment_status='Cancelled'
        THEN 1
        ELSE 0
    END AS cancelled_flag,

    CASE
        WHEN appointment_status='Ncd Show'
        THEN 1
        ELSE 0
    END AS no_show_flag,

    -------------------------------------------------
    -- Calendar Columns
    -------------------------------------------------

    YEAR(appointment_date) AS appointment_year,

    QUARTER(appointment_date) AS appointment_quarter,

    MONTH(appointment_date) AS appointment_month,

    MONTHNAME(appointment_date) AS appointment_month_name,

    WEEK(appointment_date) AS appointment_week,

    DAY(appointment_date) AS appointment_day,

    DAYNAME(appointment_date) AS appointment_day_name,

    -------------------------------------------------
    -- Weekend Flag
    -------------------------------------------------

    CASE

        WHEN DAYOFWEEK(appointment_date) IN (1,7)

            THEN 'Weekend'

        ELSE 'Weekday'

    END AS day_type

FROM appointments