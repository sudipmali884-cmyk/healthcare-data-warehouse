with prescription_summary as(
    select * from {{ ref('int_prescription_summary')}}
)
select
    -- primary key
    prescription_id,
    -- foreign keys
    appointment_id,
    patient_id,
    doctor_id,

    -- date,
    -- prescription_date,
    to_number(
    to_char(
    prescription_date,'YYYYMMDD')) as prescription_date_key,
    prescription_year,
    prescription_quarter,
    prescription_month,

    prescription_week,
    -- descriptive columns
    medicine_name,
    dosage,
    frequency,
    instructions,

    -- measures,
    quantity,
    duration_days,
    estimated_total_units,

    --categories,

    treatment_category,
    quantity_bucket,

    --flags,
    chronic_treatment_flag
from prescription_summary
