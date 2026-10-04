with doctor_performance as(
    select * from {{ ref ('int_doctor_performance')}}

)
select
    doctor_id,
    doctor_name,
    gender,
    specialization,
    qualification,
    hospital_id,

    total_appointments,

    completed_appointments,

    cancelled_appointments,

    no_show_appointments,

    no_pending_appointments,

    total_doctor_fee_collect,

    average_consultation_fee,

    patient_waiting_time_average,

    first_appointment_date,

    last_appointment_date,

    ---------------------------------------------------
    -- Performance Rating
    ---------------------------------------------------

    CASE

        WHEN completed_appointments >= 15
            THEN 'Excellent'

        WHEN completed_appointments >= 10
            THEN 'Good'

        WHEN completed_appointments >= 5
            THEN 'Average'

        ELSE 'Doctor New'

    END AS performance_rating,

    ---------------------------------------------------
    -- Revenue Category
    ---------------------------------------------------

    CASE

        WHEN total_doctor_fee_collect >= 1000000
            THEN 'Platinum'

        WHEN total_doctor_fee_collect >= 500000
            THEN 'Gold'

        WHEN total_doctor_fee_collect >= 100000
            THEN 'Silver'

        ELSE 'Bronze'

    END AS revenue_category

FROM doctor_performance