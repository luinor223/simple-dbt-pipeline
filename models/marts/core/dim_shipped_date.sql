{{ config(materialized='view') }}

SELECT 
    date_key AS shipped_date_key,
    date AS shipped_date,
    day_of_week AS shipped_day_of_week,
    day_of_week_name AS shipped_day_of_week_name,
    day_of_month AS shipped_day_of_month,
    day_of_year AS shipped_day_of_year,
    month AS shipped_month,
    month_name AS shipped_month_name,
    month_year AS shipped_month_year,
    quarter AS shipped_quarter,
    quarter_year AS shipped_quarter_year,
    year AS shipped_year
FROM {{ ref('dim_date') }}