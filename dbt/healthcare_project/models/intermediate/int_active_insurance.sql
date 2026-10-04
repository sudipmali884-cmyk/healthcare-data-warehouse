with patients as (
    select * from {{ ref('stg_patients')}}
),

insurance as (
    select * from {{ ref('stg_insurance')}}
)

select
    i.insurance_id,
    i.patient_id,
    p.patient_name,
    i.provider,
    i.policy_number,
    i.coverage_amount,
    i.start_date,
    i.end_date,

    case
        when i.status='Cancelled'
            then 'Cancelled'
        when i.end_date < current_date()
            then 'expired'
        else 'Active'
    end as current_policy_status,
    case
        when i.end_date >= current_date()
        then datediff(
            day,
            current_date(),
            i.end_date
        )
    else 0

    end as remaining_days,

    datediff(
        day,
        i.start_date,
        i.end_date
    ) as policy_duration_days

from insurance i
left join patients p
on i.patient_id = p.patient_id