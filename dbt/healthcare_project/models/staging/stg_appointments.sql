with source as (
    select * from {{ source('raw','appointments')}}
 ),
 cleaned_data  as (
    select
        appointment_id,
        CASE
            when patient_id in (
                select patient_id from {{ ref('stg_patients')}}
                )
              then patient_id
              else null
        end  as patient_id,

        case
            when doctor_id in (
                select doctor_id from {{ ref('stg_doctors')}}

        ) then doctor_id
        else 'D000001'
        end as doctor_id,
        case
            when hospital_id in (
                select hospital_id
                from {{ ref('stg_hospitals')}}
            )
            then hospital_id
            else null
        end as hospital_id,
        patient_name,
        doctor_name,
        patient_age,
        upper(trim(blood_groups)) as blood_group,
        appointment_date,
        case
            when initcap(trim(consultation_type)) in ('Walk-In','Online','Emergency','Follow-Up')
            then initcap(trim(consultation_type))
            else null
        end as consultation_type,
        consultation_fee,

        case
            when waiting_time_minutes >=0
            then waiting_time_minutes
            else null
        end as waiting_time_minutes,
        case
            when initcap(trim(appointment_status))
                in ('Completed','Pending','Cancelled','No Show')
            then initcap(trim(appointment_status))
            else null
        end as appointment_status,
        created_date,
        updated_date
    from source

 )
 select * from cleaned_data

 qualify row_number() over(
    partition by appointment_id
    order by updated_date desc
    )  =1