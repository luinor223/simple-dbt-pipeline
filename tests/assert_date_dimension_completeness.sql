-- Test that date dimension has no gaps in the expected range
-- Should return 0 rows if all dates from 2024-01-01 to 2030-12-31 exist
with expected_dates as (
    select 
        date_day
    from 
        unnest(generate_series(date '2024-01-01', date '2030-12-31', interval 1 day)) as t(date_day)
),
actual_dates as (
    select date from {{ ref('dim_date') }}
),
missing_dates as (
    select date_day from expected_dates
    except
    select date from actual_dates
)
select * from missing_dates
