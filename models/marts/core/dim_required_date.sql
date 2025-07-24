{{ config(materialized='view') }}

SELECT 
    date_key AS required_date_key,
    date AS required_date,
    day_of_week AS required_day_of_week,
    day_of_week_name AS required_day_of_week_name,
    day_of_month AS required_day_of_month,
    day_of_year AS required_day_of_year,
    month AS required_month,
    month_name AS required_month_name,
    month_year AS required_month_year,
    quarter AS required_quarter,
    quarter_year AS required_quarter_year,
    year AS required_year
FROM {{ ref('dim_date') }}