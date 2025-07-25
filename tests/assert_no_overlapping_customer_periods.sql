-- Test that SCD Type 2 validity periods don't overlap for the same customer
-- Should return 0 rows if no overlapping periods exist
with overlapping_periods as (
    select 
        c1.customer_id,
        c1.dbt_valid_from as period1_start,
        c1.dbt_valid_to as period1_end,
        c2.dbt_valid_from as period2_start,
        c2.dbt_valid_to as period2_end
    from {{ ref('dim_customers') }} c1
    join {{ ref('dim_customers') }} c2
        on c1.customer_id = c2.customer_id
        and c1.customer_key != c2.customer_key
    where 
        -- Check for overlapping periods
        c1.dbt_valid_from < coalesce(c2.dbt_valid_to, current_date)
        and coalesce(c1.dbt_valid_to, current_date) > c2.dbt_valid_from
)
select * from overlapping_periods
