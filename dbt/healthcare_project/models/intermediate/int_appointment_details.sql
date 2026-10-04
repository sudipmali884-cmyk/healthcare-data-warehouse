with appointments as (
    select * from {{ ref('stg_appointments')}}
),
patients as (
    select * from {{ ref('stg_patients')}}
),
doctors as(
    select * from {{ ref('stg_doctors')}}

),
hospitals as  (
     select * from {{ ref('stg_hospitals')}}
)

select
    -- from appointment
    a.appointment_id,
    a.appointment_date,
    a.appointment_status,
    a.consultation_type,
    a.waiting_time_minutes,
    a.consultation_fee,

    -- from patient

    p.patient_id,
    p.patient_name,
    p.gender as patient_gender,
    p.blood_group,
    p.city as patient_city,
    p.state as patient_state,

    -- doctor
    d.doctor_id,
    d.doctor_name,
    d.specialization,
    d.qualification,
    d.experience_years,

    -- hospital

    h.hospital_id,
    h.hospital_name,
    h.hospital_type,
    h.city as hospital_city,
    h.state as hospital_state,
    h.bed_count
from appointments a join patients p on a.patient_id = p.patient_id

join doctors d on a.doctor_id = d.doctor_id

join hospitals h
 on a.hospital_id = h.hospital_id


