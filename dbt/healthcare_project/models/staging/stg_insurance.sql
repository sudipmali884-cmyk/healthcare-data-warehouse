with insurance as(
    select * from {{source('raw','insurance')}}
),

cleaned_data as (
select
    insurance_id,
    patient_id,

    initcap(trim(patient_name)) as patient_name,
    trim(provider) as provider,
    upper(trim(policy_number)) as policy_number,
    coverage_amount,
    start_date,
    end_date,
    created_date,
    updated_date,
    case
        when initcap(trim(status))
            in ('Active','Expired','Cancelled')
        then initcap(trim(status))
        else null
    end as status

    from insurance
)

select * from cleaned_data
qualify row_number() over(
    partition by insurance_id
    order by updated_date desc
)=1
