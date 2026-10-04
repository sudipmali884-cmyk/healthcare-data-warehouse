with insurance as (
    select * from {{ ref('stg_insurance')}}
),
patients as (
    select * from {{ ref('stg_patients')}}
)

select
    i.insurance_id,
    i.policy_number,
    i.provider,
    i.coverage_amount,
    i.status,
    i.start_date,
    i.end_date,

    p.patient_id,
    p.patient_name,
    p.gender,
    p.blood_group,
    p.city,
    p.state,
    p.age,
    p.dob

from insurance i join patients p on i.patient_id=p.patient_id