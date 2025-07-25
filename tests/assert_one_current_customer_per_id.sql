-- Test that each customer has exactly one current version
-- Should return 0 rows if every customer has exactly one current record
with current_version_counts as (
    select 
        customer_id,
        count(*) as current_versions
    from {{ ref('dim_customers') }}
    where is_current_version = true
    group by customer_id
    having count(*) != 1
)
select * from current_version_counts
