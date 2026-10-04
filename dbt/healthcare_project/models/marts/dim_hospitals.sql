with hospital_performance as(
    select * from {{ ref('int_hospital_performance')}}
)
select
    -- primary key
    hospital_id,

    -- hospital information
    hospital_name,
    hospital_type,
    city,
    state,
    bed_count,
    -- business metrices,
    total_doctors,
    total_patients,
    total_appointments,
    completed_appointments,
    cancelled_appointments,
    no_show_appointments,
    total_revenue,
    average_waiting_time,
    first_appointment_date,
    last_appointment_date,
    -- bed utilization
    case
        when bed_count is null
        or bed_count = 0
        then null
        else round(
        total_patients * 100.0 /bed_count,2
        )
        end as patient_per_bed_ratio,

    -- Completion Rate
    --------------------------------------------------

    CASE

        WHEN total_appointments = 0

            THEN 0

        ELSE ROUND(

            completed_appointments * 100.0
            / total_appointments,

            2

        )

    END AS completion_rate,

    --------------------------------------------------
    -- Cancellation Rate
    --------------------------------------------------

    CASE

        WHEN total_appointments = 0

            THEN 0

        ELSE ROUND(

            cancelled_appointments * 100.0
            / total_appointments,

            2

        )

    END AS cancellation_rate,

    --------------------------------------------------
    -- Hospital Tier
    --------------------------------------------------

    CASE

        WHEN total_revenue >= 1000

            THEN 'Tier 1'

        WHEN total_revenue >= 500

            THEN 'Tier 2'

        WHEN total_revenue >= 100

            THEN 'Tier 3'

        ELSE 'Tier 4'

    END AS hospital_tier

FROM hospital_performance