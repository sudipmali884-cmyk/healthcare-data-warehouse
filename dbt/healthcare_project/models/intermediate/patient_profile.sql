with patients as(
    select * from {{ref('stg_patients')}}
)

select
    patient_id,
    patient_name,
    gender,
    age,
    dob,
    blood_group,

    case
        when age <= 12 then 'Child'
        when age <= 18 then 'Teenager'
        when age <= 60 then 'Adult'
        else 'Senior'
    end as age_group,
   city,
   state
from patients

