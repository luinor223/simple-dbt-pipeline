-- Test that all fact table foreign keys exist in dimension tables
-- Should return 0 rows if all foreign keys are valid
with orphaned_records as (
    -- Check for orphaned customer keys
    select 'customer' as dimension, sales_key, customer_key as foreign_key
    from {{ ref('fct_sales') }} f
    where customer_key is not null
      and not exists (
          select 1 from {{ ref('dim_customers') }} d 
          where d.customer_key = f.customer_key
      )
    
    union all
    
    -- Check for orphaned product keys
    select 'product' as dimension, sales_key, product_key as foreign_key
    from {{ ref('fct_sales') }} f
    where product_key is not null
      and not exists (
          select 1 from {{ ref('dim_products') }} d 
          where d.product_key = f.product_key
      )
      
    union all
    
    -- Check for orphaned order date keys
    select 'order_date' as dimension, sales_key, order_date_key::varchar as foreign_key
    from {{ ref('fct_sales') }} f
    where order_date_key is not null
      and not exists (
          select 1 from {{ ref('dim_order_date') }} d 
          where d.order_date_key = f.order_date_key
      )
)
select * from orphaned_records
