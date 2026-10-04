{{ config(
    materialized='table'
) }}

WITH date_spine AS (

    SELECT

        DATEADD(
            DAY,
            ROW_NUMBER() OVER (ORDER BY SEQ4()) - 1,
            '2020-01-01'
        ) AS calendar_date

    FROM TABLE(GENERATOR(ROWCOUNT => 4018))

)

SELECT

    --------------------------------------------------
    -- Primary Key
    --------------------------------------------------

    TO_NUMBER(
        TO_CHAR(calendar_date,'YYYYMMDD')
    ) AS date_key,

    --------------------------------------------------
    -- Date
    --------------------------------------------------

    calendar_date AS full_date,

    --------------------------------------------------
    -- Calendar
    --------------------------------------------------

    YEAR(calendar_date) AS calendar_year,

    QUARTER(calendar_date) AS calendar_quarter,

    MONTH(calendar_date) AS month_number,

    MONTHNAME(calendar_date) AS month_name,

    WEEK(calendar_date) AS week_number,

    DAY(calendar_date) AS day_number,

    DAYNAME(calendar_date) AS day_name,

    DAYOFYEAR(calendar_date) AS day_of_year,

    --------------------------------------------------
    -- Month Information
    --------------------------------------------------

    DATE_TRUNC(
        'MONTH',
        calendar_date
    ) AS month_start_date,

    LAST_DAY(calendar_date)
        AS month_end_date,

    --------------------------------------------------
    -- Quarter Information
    --------------------------------------------------

    DATE_TRUNC(
        'QUARTER',
        calendar_date
    ) AS quarter_start_date,

    LAST_DAY(
        calendar_date,
        'QUARTER'
    ) AS quarter_end_date,

    --------------------------------------------------
    -- Year Information
    --------------------------------------------------

    DATE_TRUNC(
        'YEAR',
        calendar_date
    ) AS year_start_date,

    LAST_DAY(
        calendar_date,
        'YEAR'
    ) AS year_end_date,

    --------------------------------------------------
    -- Weekend
    --------------------------------------------------

    CASE

        WHEN DAYOFWEEK(calendar_date)
            IN (1,7)

            THEN 'Yes'

        ELSE 'No'

    END AS is_weekend,

    --------------------------------------------------
    -- Month Start
    --------------------------------------------------

    CASE

        WHEN calendar_date =
             DATE_TRUNC(
                'MONTH',
                calendar_date
             )

        THEN 1

        ELSE 0

    END AS is_month_start,

    --------------------------------------------------
    -- Month End
    --------------------------------------------------

    CASE

        WHEN calendar_date =
             LAST_DAY(calendar_date)

        THEN 1

        ELSE 0

    END AS is_month_end,

    --------------------------------------------------
    -- Quarter Start
    --------------------------------------------------

    CASE

        WHEN calendar_date =
             DATE_TRUNC(
                 'QUARTER',
                 calendar_date
             )

        THEN 1

        ELSE 0

    END AS is_quarter_start,

    --------------------------------------------------
    -- Quarter End
    --------------------------------------------------

    CASE

        WHEN calendar_date =
             LAST_DAY(
                 calendar_date,
                 'QUARTER'
             )

        THEN 1

        ELSE 0

    END AS is_quarter_end,

    --------------------------------------------------
    -- Year Start
    --------------------------------------------------

    CASE

        WHEN calendar_date =
             DATE_TRUNC(
                 'YEAR',
                 calendar_date
             )

        THEN 1

        ELSE 0

    END AS is_year_start,

    --------------------------------------------------
    -- Year End
    --------------------------------------------------

    CASE

        WHEN calendar_date =
             LAST_DAY(
                 calendar_date,
                 'YEAR'
             )

        THEN 1

        ELSE 0

    END AS is_year_end,

    --------------------------------------------------
    -- Leap Year
    --------------------------------------------------

    CASE

        WHEN MOD(
            YEAR(calendar_date),
            400
        ) = 0

        THEN 'Yes'

        WHEN MOD(
            YEAR(calendar_date),
            100
        ) = 0

        THEN 'No'

        WHEN MOD(
            YEAR(calendar_date),
            4
        ) = 0

        THEN 'Yes'

        ELSE 'No'

    END AS leap_year,

    --------------------------------------------------
    -- Financial Year (India)
    --------------------------------------------------

    CASE

        WHEN MONTH(calendar_date) >= 4

        THEN CONCAT(

            YEAR(calendar_date),

            '-',

            YEAR(calendar_date)+1

        )

        ELSE CONCAT(

            YEAR(calendar_date)-1,

            '-',

            YEAR(calendar_date)

        )

    END AS financial_year,

    --------------------------------------------------
    -- Financial Quarter
    --------------------------------------------------

    CASE

        WHEN MONTH(calendar_date) BETWEEN 4 AND 6

            THEN 'Q1'

        WHEN MONTH(calendar_date) BETWEEN 7 AND 9

            THEN 'Q2'

        WHEN MONTH(calendar_date) BETWEEN 10 AND 12

            THEN 'Q3'

        ELSE 'Q4'

    END AS financial_quarter

FROM date_spine