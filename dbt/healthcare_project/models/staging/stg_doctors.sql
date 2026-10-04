
with source as (
    select * from {{ source('raw','doctors')}}

),
cleaned_data as (
    select
    TRIM(doctor_id) as doctor_id,
    TRIM (hospital_id) as hospital_id,
    trim(hospital_name) as hospital_name,
    trim(city) as city,
    trim(state) as state,
    INITCAP(TRIM(doctor_name)) as doctor_name,
    case when upper(TRIM(gender)) in ('MALE','FEMALE') THEN INITCAP(TRIM(GENDER))
        else 'unknown'
        end as gender,
    INITCAP(TRIM(specialization)) as specialization,
    UPPER(TRIM(qualification)) as qualification,
    case
        WHEN TRY_TO_NUMBER(experience_years) IS NULL
                THEN NULL

        WHEN TRY_TO_NUMBER(experience_years) < 0
            THEN NULL

        WHEN TRY_TO_NUMBER(experience_years) > 60
            THEN NULL

        ELSE TRY_TO_NUMBER(experience_years)

        END AS experience_years,
    consultation_fee,
    case
        when regexp_like(phone,'^[6-9][0-9]{9}$')
        then phone
        else null
    end as phone,
    case
        when regexp_like(
            lower(email),
            '^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$'

        )
        then lower(email)
        else null
    end as email,
    joining_date
from source

)
select * from cleaned_data
qualify row_number() over(
    partition by doctor_id
    order by joining_date desc
)=1