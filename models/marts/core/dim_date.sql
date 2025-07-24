WITH date_spine AS (
    SELECT 
        date_day
    FROM 
        UNNEST(GENERATE_SERIES(DATE '2024-01-01', DATE '2030-12-31', INTERVAL 1 day)) AS t(date_day)
),
date_data AS (
    SELECT
        CAST(STRFTIME(date_day, '%Y%m%d') AS INTEGER) AS date_key,
        date_day::date AS date,
        EXTRACT(DOW FROM date_day) AS day_of_week,
        STRFTIME(date_day, '%A') AS day_of_week_name,
        EXTRACT(DAY FROM date_day) AS day_of_month,
        EXTRACT(DOY FROM date_day) AS day_of_year,
        EXTRACT(MONTH FROM date_day) AS month,
        STRFTIME(date_day, '%B') AS month_name,
        STRFTIME(date_day, '%Y-%m') AS month_year,
        EXTRACT(QUARTER FROM date_day) AS quarter,
        CONCAT(EXTRACT(YEAR FROM date_day), '-Q', EXTRACT(QUARTER FROM date_day)) AS quarter_year,
        EXTRACT(YEAR FROM date_day) AS year
    FROM date_spine
)
SELECT *
FROM date_data