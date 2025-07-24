{{ config(materialized='view') }}

SELECT 
    date_key AS order_date_key,
    date AS order_date,
    day_of_week AS order_day_of_week,
    day_of_week_name AS order_day_of_week_name,
    day_of_month AS order_day_of_month,
    day_of_year AS order_day_of_year,
    month AS order_month,
    month_name AS order_month_name,
    month_year AS order_month_year,
    quarter AS order_quarter,
    quarter_year AS order_quarter_year,
    year AS order_year
FROM {{ ref('dim_date') }}