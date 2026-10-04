with prescriptions as (
    select * from {{ source ('raw','prescriptions')}}
),

cleaned_data as (
    select
    prescription_id ,
    case
        when appointment_id in (
            select appointment_id from {{ref('stg_appointments')}}
        )
        then appointment_id
        else null
    end as appointment_id,

    case
        when patient_id in (
            select patient_id from {{ref('stg_patients')}}
        )
        then patient_id
        else 'P000777'
    end as patient_id,

    initcap(trim(patient_name)) as patient_name,

    case
        when doctor_id  in (
        select doctor_id from  {{ref('stg_doctors')}}

        ) then doctor_id
        else null
        end as doctor_id,

    initcap(trim(doctor_name)) as doctor_name,

    prescription_date,

    case
        when trim(medicine_name) in (
             'Paracetamol',
                'Azithromycin',
                'Amoxicillin',
                'Crocin',
                'Dolo 650',
                'Pantoprazole',
                'Cetirizine',
                'Metformin',
                'Amlodipine',
                'Atorvastatin',
                'Insulin',
                'Vitamin D3',
                'ORS',
                'Ibuprofen',
                'Diclofenac',
                'Omeprazole',
                'Levocetirizine',
                'Losartan',
                'Aspirin',
                'Monte LC'
        )
        then trim(medicine_name)
        else 'No Tablet'
    end as medicine_name,
    dosage,
    frequency,
    case
        when duration_days > 0
        then duration_days
        else null
    end as duration_days,

    case
        when quantity > 0
        then quantity
        else 0000
    end as quantity,

    instructions
from prescriptions
)

select * from cleaned_data

qualify row_number() over(
partition by prescription_id
order by prescription_date desc
)=1