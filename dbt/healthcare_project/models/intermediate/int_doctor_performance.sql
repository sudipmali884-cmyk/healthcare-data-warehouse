--Business Questions
--
--For every doctor, we want to know:
--
--Total Appointments
--Completed Appointments
--Cancelled Appointments
--No Show Appointments
--Total Revenue
--Average Consultation Fee
--Average Waiting Time
--First Appointment
--Last Appointment

with doctors as(
    select * from {{ ref('stg_doctors')}}
),
appointments as(
    select * from {{ ref('stg_appointments')}}
),
hospitals as (
    select * from {{ ref('stg_hospitals')}}
),
doctors_data as(
    select
        doctor_id,
--        doctor_name,
        count(*) as total_appointments,
        count_if(appointment_status='Completed') as completed_appointments,
        count_if(appointment_status='Cancelled') as cancelled_appointments,
        count_if(appointment_status='No Show') as no_show_appointments,
        count_if(appointment_status='Pending') as no_pending_appointments,
        sum(
            case
                when appointment_status='Completed' then consultation_fee
                else 0
            end
        ) as total_doctor_fee_collect,

        avg(consultation_fee) as average_consultation_fee,
        avg(waiting_time_minutes) as patient_waiting_time_average,
        min(appointment_date) as first_appointment_date,
        max(appointment_date) as last_appointment_date

    from appointments group by doctor_id
)
select
    d.doctor_id,
    d.doctor_name,

    d.specialization,
    d.qualification,
    d.gender,
--    d.hospital_id,
--     d.hospital_name,

    h.hospital_id,
    h.hospital_name,
    h.city as hospital_city,
    h.state as hospital_state,
    h.hospital_type,

    coalesce(m.total_appointments,0) as total_appointments,
    coalesce(m.completed_appointments,0) as completed_appointments,
    coalesce(m.cancelled_appointments,0) as cancelled_appointments,
    coalesce(m.no_show_appointments,0) as no_show_appointments,
    coalesce(m.no_pending_appointments,0) as no_pending_appointments,
    coalesce(m.total_doctor_fee_collect,0) as total_doctor_fee_collect,
    round(m.average_consultation_fee,2) as Average_consultation_fee,
    round(m.patient_waiting_time_average) as patient_waiting_time_average,
    m.first_appointment_date,
    m.last_appointment_date

from doctors d left join doctors_data m
on d.doctor_id = m.doctor_id

left join hospitals h
on d.hospital_id = h.hospital_id