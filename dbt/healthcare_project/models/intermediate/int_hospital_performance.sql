--Business Questions
--
--For every hospital, we want to know:
--
--Total Doctors
--Total Patients Visited
--Total Appointments
--Completed Appointments
--Cancelled Appointments
--No Show Appointments
--Total Revenue
--Average Consultation Fee
--Average Waiting Time
--First Appointment
--Last Appointment
--Data Flow

with hospitals as (
    select * from {{ ref('stg_hospitals')}}
),

doctors as (
    select * from {{ ref('stg_doctors')}}
),

appointments as (
    select * from {{ ref('stg_appointments')}}
),

doctor_count as (
    select
        hospital_id,
        count(distinct doctor_id) as total_doctors
    from doctors group by hospital_id
),

appointment_history as(
    select
        hospital_id,
        count (*) as  total_appointments,
        count(distinct patient_id) as total_patients,
        count_if (appointment_status='Completed') as completed_appointments,
        count_if (appointment_status='Cancelled') as cancelled_appointments,
        count_if (appointment_status='No Show') as no_show_appointments,
        count_if (appointment_status='Pending') as pending_appointments,

        sum (
            case
                when appointment_status='Completed' then consultation_fee
                else 0
            end
        ) as total_revenue,

        avg(consultation_fee) as average_consultation_fee,
        avg(waiting_time_minutes) as average_waiting_time,
        min(appointment_date) as first_appointment_date,
        max(appointment_date) as last_appointment_date

    from appointments
    group by hospital_id
)

select
    h.hospital_id,
    h.hospital_name,
    h.hospital_type,
    h.city,
    h.state,
    h.bed_count,
    coalesce(d.total_doctors,0) as total_doctors,
    coalesce(a.total_patients,0) as total_patients,
    coalesce(a.total_appointments,0) as total_appointments,
    coalesce(a.completed_appointments,0) as completed_appointments,
    coalesce(a.cancelled_appointments,0) as cancelled_appointments,
    coalesce(a.pending_appointments,0) as pending_appointments,
    coalesce(a.no_show_appointments,0) as no_show_appointments,
    coalesce (a.total_revenue,0) as total_revenue,
    round(a.average_waiting_time,2) as average_waiting_time,
    round(a.average_consultation_fee) as average_consultation_fee,
    a.first_appointment_date,
    a.last_appointment_date

from hospitals h left join doctor_count d
    on h.hospital_id=d.hospital_id

left join appointment_history a
    on h.hospital_id=a.hospital_id

