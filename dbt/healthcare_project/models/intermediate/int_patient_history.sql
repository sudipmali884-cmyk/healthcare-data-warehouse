with patients as (
    select * from {{ ref ('stg_patients')}}
),
appointments as (
    select * from {{ ref('stg_appointments')}}
),
int_appointments as (
    select * from {{ ref('int_appointment_details')}}
),


patient_history as (
    select
        patient_id,
        count(*) as total_appointments,
        count_if(appointment_status='Completed')
            as completed_appointments,

        count_if(appointment_status='Cancelled') as cancelled_appointments,

        min(appointment_date) as first_visit_date,
        max(appointment_date) as last_visit_date
    from appointments group by patient_id
),

latest_visit as (
    select
        patient_id,
        patient_name,
        doctor_id,
        doctor_name,
        hospital_id,

        appointment_date,
        row_number() over(
            partition by patient_id
            order by appointment_date desc
        ) as rn
    from appointments

)
select
    p.patient_id,
    p.patient_name,
    p.gender as patient_gender,
    p.dob,
    p.city,
    p.state,
    coalesce(h.total_appointments, 0) as total_appointments,
    coalesce(h.completed_appointments,0) as completed_appointments,
    coalesce(h.cancelled_appointments,0) as cancelled_appointments,
    h.first_visit_date,
    h.last_visit_date,
    l.doctor_id as last_doctor_id,
    l.hospital_id as last_hospital_id
from patients p
left join patient_history h
on p.patient_id = h.patient_id
left join latest_visit l
on p.patient_id = l.patient_id
and l.rn=1