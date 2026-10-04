
with source as (
    select * from {{source('raw','hospitals')}}
),

cleaned as (
    select
        hospital_id,
        trim(hospital_name) as hospital_name,
        initcap(trim(hospital_type)) as hospital_type,
        TRIM(city) as city,
        TRIM(state) as state,
        case
            when regexp_like(phone,'^[6-9][0-9]{9}$')
            then phone
            else null
        end as phone,
        case
            when regexp_like(lower(email),
            '^[a-z0-9.%+-]+@[a-z0-9.-]+\.[a-z]{2,}$')
            then lower(email)
            else null
        end as email,

        bed_count,
        established_date,
        created_date,
        updated_date
    from source
),
deduplicated as (
    select *  from cleaned
    qualify row_number() over(
    partition by hospital_id
    order by updated_date desc)=1
)
select * from deduplicated

