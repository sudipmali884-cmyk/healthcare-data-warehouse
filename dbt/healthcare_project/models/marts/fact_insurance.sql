with active_insurance as (
    select * from {{ ref('int_active_insurance')}}
)

select
    insurance_id,
    patient_id,

    -- policy detalils
    provider,
    policy_number,
    -- start_date,
    -- end_date,
    TO_NUMBER(
    TO_CHAR(
        start_date,
        'YYYYMMDD'
    )
) AS start_date_key,

TO_NUMBER(
    TO_CHAR(
        end_date,
        'YYYYMMDD'
    )
) AS end_date_key,

    -- measures
    coverage_amount,
    remaining_days,
    policy_duration_days,

    --status
    current_policy_status,

    -- coverage bucket

    case
        when coverage_amount < 100000
            then 'Basic'
        when coverage_amount <500000
            then 'Standard'
        when coverage_amount <1000000
            then 'Premium'
        else 'Platinum'
    end as coverage_bucket,

    -- expirary nucket

    case
        when current_policy_status = 'Cancelled'
            then 'cancelled'
        when current_policy_status = 'Expired'
            then 'Expired'
        when remaining_days <=30
            then 'Expires in 30 days'

        when remaining_days <=100
            then 'Expires in 100 days '
        else 'abhi bahoot din hai'
    end  as expiry_bucket,

    -- flags

    case
        when current_policy_status = 'Active'
            then 1
        else 0
    end as active_policy_flag,

    case
        when current_policy_status = 'Expired'
            then 1
        else 0
    end as expired_policy_flag,

    case
        when current_policy_status = 'Cancelled'
            then 1
        else 0
    end as cancelled_current_policy_flag,
from active_insurance

