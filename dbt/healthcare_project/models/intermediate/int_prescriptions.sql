with prescriptions as (
    select * from {{ref('stg_prescriptions')}}
),
patients as (
    select * from {{ ref('stg_patients')}}
),
doctors as (
    select * from {{ ref('stg_doctors')}}
),

appointments as (
    select * from {{ ref('stg_appointments')}}
)

select

    pr.prescription_id,
    pr.prescription_date,
    pr.medicine_name,
    pr.dosage,
    pr.frequency,
    pr.quantity,


    -- patients
    p.patient_id,
    p.patient_name,
    p.age,
    p.dob as patient_dob,
    p.gender as patient_gender,
    p.phone,
    p.city as patient_city,
    p.state as patient_state,

    -- doctors
    d.doctor_id,
    d.doctor_name,
    d.specialization,
    d.qualification,


    -- appointmetns
    a.appointment_id,
    a.appointment_date,
    a.appointment_status,
    a.consultation_fee,
    a.consultation_type,
    a.waiting_time_minutes,

    -- insurance
--
--    i.insurance_id,
--    i.insurance_name,
--    i.start_date,
--    i.end_date,
--    i.policy_number,
--    i.coverage_amount,
--    i.status
--
--    -- hospitals
--
--    h.hospital_id,
--    h.hospital_name,
--    h.hospital_type,
--    h.city as hospital_city,
--    h.state as hospital_state,

from prescriptions pr join patients p on pr.patient_id = p.patient_id

join doctors d on d.doctor_id = pr.doctor_id

join appointments a on pr.appointment_id = a.appointment_id







