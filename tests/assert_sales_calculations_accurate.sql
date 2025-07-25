-- Test that sales calculations are mathematically correct
-- Should return 0 rows if all calculations are accurate
with source_data as (
    select 
        f.*,
        od.discount
    from {{ ref('fct_sales') }} f
    join {{ ref('stg_northwind__order_details') }} od 
        on f.order_id = od.order_id and f.product_id = od.product_id
),
calculation_errors as (
    select 
        sales_key,
        order_id,
        product_id,
        sales_quantity,
        regular_unit_price,
        discount_unit_price,
        net_unit_price,
        extended_sales_amount,
        extended_discount_amount,
        discount,
        round(regular_unit_price * discount, 2) as expected_discount_unit_price,
        round(regular_unit_price * (1 - discount), 2) as expected_net_unit_price,
        round(regular_unit_price * sales_quantity * discount, 2) as expected_extended_discount,
        round(regular_unit_price * sales_quantity * (1 - discount), 2) as expected_extended_sales
    from source_data
    where 
        abs(discount_unit_price - round(regular_unit_price * discount, 2)) > 0.01
        or abs(net_unit_price - round(regular_unit_price * (1 - discount), 2)) > 0.01
        or abs(extended_discount_amount - round(regular_unit_price * sales_quantity * discount, 2)) > 0.01
        or abs(extended_sales_amount - round(regular_unit_price * sales_quantity * (1 - discount), 2)) > 0.01
)
select * from calculation_errors
