-- Test that fact table joins to correct product versions at order time
-- Should return 0 rows if all joins are temporally accurate
with incorrect_product_versions as (
    select 
        f.sales_key,
        f.order_id,
        f.product_id,
        o.order_date,
        p.dbt_valid_from,
        p.dbt_valid_to
    from {{ ref('fct_sales') }} f
    join {{ ref('stg_northwind__orders') }} o on f.order_id = o.order_id
    join {{ ref('dim_products') }} p on f.product_key = p.product_key
    where 
        -- Order date should be within product validity period
        o.order_date < p.dbt_valid_from
        or (p.dbt_valid_to is not null and o.order_date >= p.dbt_valid_to)
)
select * from incorrect_product_versions
