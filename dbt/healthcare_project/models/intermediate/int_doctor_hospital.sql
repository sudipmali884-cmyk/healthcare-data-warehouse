with doctors as (
    select * from {{ ref('stg_doctors')}}
),
hospitals as (
    select * from {{ ref('stg_hospitals')}}
)

select d.doctor_id,d.doctor_name,d.gender,d.specialization,d.experience_years,
    d.consultation_fee,d.phone,d.email,d.joining_date,
    h.hospital_id,
    h.hospital_name,
    h.city,
    h.state,
    h.hospital_type,
    h.bed_count
from doctors d join hospitals h on d.hospital_id = h.hospital_id