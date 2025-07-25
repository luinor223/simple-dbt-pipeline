-- Test business rules like discount validation and quantity checks
-- Should return 0 rows if all business rules are satisfied
with business_rule_violations as (
    select 
        sales_key,
        order_id,
        product_id,
        'negative_quantity' as violation_type
    from {{ ref('fct_sales') }}
    where sales_quantity < 0
    
    union all
    
    select 
        sales_key,
        order_id,
        product_id,
        'negative_price' as violation_type
    from {{ ref('fct_sales') }}
    where regular_unit_price < 0
    
    union all
    
    select 
        sales_key,
        order_id,
        product_id,
        'excessive_discount' as violation_type
    from {{ ref('fct_sales') }}
    where discount_unit_price > regular_unit_price
    
    union all
    
    select 
        sales_key,
        order_id,
        product_id,
        'negative_extended_amount' as violation_type
    from {{ ref('fct_sales') }}
    where extended_sales_amount < 0
)
select * from business_rule_violations
