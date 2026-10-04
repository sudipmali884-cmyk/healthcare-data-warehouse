WITH prescriptions AS (

    SELECT *

    FROM {{ ref('stg_prescriptions') }}

)

SELECT

    ------------------------------------------------
    -- Keys
    ------------------------------------------------

    prescription_id,

    appointment_id,

    patient_id,

    doctor_id,

    prescription_date,

    medicine_name,

    dosage,

    frequency,

    duration_days,

    quantity,

    instructions,

    ------------------------------------------------
    -- Total Tablets Estimate
    ------------------------------------------------

    quantity * duration_days
        AS estimated_total_units,

    ------------------------------------------------
    -- Duration Bucket
    ------------------------------------------------

    CASE

        WHEN duration_days <= 5

            THEN 'Short Term'

        WHEN duration_days <= 15

            THEN 'Medium Term'

        WHEN duration_days <= 30

            THEN 'Long Term'

        ELSE 'Chronic Treatment'

    END AS treatment_category,

    ------------------------------------------------
    -- Quantity Bucket
    ------------------------------------------------

    CASE

        WHEN quantity <= 10

            THEN 'Low'

        WHEN quantity <= 30

            THEN 'Medium'

        WHEN quantity <= 60

            THEN 'High'

        ELSE 'Very High'

    END AS quantity_bucket,

    ------------------------------------------------
    -- Long Treatment Flag
    ------------------------------------------------

    CASE

        WHEN duration_days > 30

            THEN 1

        ELSE 0

    END AS chronic_treatment_flag,

    ------------------------------------------------
    -- Prescription Year
    ------------------------------------------------

    YEAR(prescription_date)
        AS prescription_year,

    ------------------------------------------------
    -- Quarter
    ------------------------------------------------

    QUARTER(prescription_date)
        AS prescription_quarter,

    ------------------------------------------------
    -- Month
    ------------------------------------------------

    MONTHNAME(prescription_date)
        AS prescription_month,

    ------------------------------------------------
    -- Week
    ------------------------------------------------

    WEEK(prescription_date)
        AS prescription_week

FROM prescriptions