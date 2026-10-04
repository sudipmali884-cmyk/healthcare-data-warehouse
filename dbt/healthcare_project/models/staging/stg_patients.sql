with source as (
    select * from {{ source('raw','patients')}}

),
cleaned_data as (
    select patient_id,
    INITCAP(TRIM(patient_name)) as patient_name,
    INITCAP(TRIM(gender)) as gender,
    dob,
    case
        when regexp_like(phone,'^[6-9][0-9]{9}$')
        then phone
        else '9422899910'
    end as phone,
    case
        when upper(trim(blood_group))
            in ('A+','A-','B+','B-','AB+','AB-','O+','O-')
        THEN upper(trim(blood_group))
        else 'O+'
    end as blood_group,

    height_cm,
    weight_kg,
    trim(city) as city,
    trim(state) as state,
    pincode,
    created_date,
    updated_date,
    age
    FROM source
)
select * from cleaned_data
qualify row_number() over(
    partition by patient_id -- patient naem instead of patient_id then it will gove you unique patirnt name
    order by updated_date desc
)=1