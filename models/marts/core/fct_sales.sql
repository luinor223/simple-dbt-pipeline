WITH orders AS (
    SELECT
        o.order_id,
        o.order_date,
        ot.order_date_key,
        rt.required_date_key,
        st.shipped_date_key,
        o.customer_id,
        o.employee_id,
        o.freight
    FROM {{ ref('stg_northwind__orders') }} o
    LEFT JOIN {{ ref('dim_order_date') }} ot
        ON o.order_date = ot.order_date
    LEFT JOIN {{ ref('dim_required_date') }} rt
        ON o.required_date = rt.required_date
    LEFT JOIN {{ ref('dim_shipped_date') }} st
        ON o.shipped_date = st.shipped_date
),
order_details AS (
    SELECT
        od.order_id,
        od.product_id,
        od.unit_price,
        od.quantity,
        od.discount
    FROM {{ ref('stg_northwind__order_details') }} od
),

-- Point-in-time join to get customer as they were at order date
customers_at_order_time AS (
    SELECT 
        o.order_id,
        o.order_date,
        c.customer_key,
        c.customer_id
    FROM orders o
    LEFT JOIN {{ ref('dim_customers') }} c
        ON o.customer_id = c.customer_id
        AND o.order_date >= c.dbt_valid_from
        AND (o.order_date < c.dbt_valid_to OR c.dbt_valid_to IS NULL)
),

-- Point-in-time join to get product as it was at order date
products_at_order_time AS (
    SELECT 
        o.order_id,
        od.product_id,
        o.order_date,
        p.product_key
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    LEFT JOIN {{ ref('dim_products') }} p
        ON od.product_id = p.product_id
        AND o.order_date >= p.dbt_valid_from
        AND (o.order_date < p.dbt_valid_to OR p.dbt_valid_to IS NULL)
)
SELECT
    {{ dbt_utils.generate_surrogate_key(['o.order_id', 'od.product_id']) }} AS sales_key,
    c.customer_key,
    p.product_key,
    o.order_date_key,
    o.required_date_key,
    o.shipped_date_key,
    o.order_id,
    od.product_id,
    od.quantity AS sales_quantity,
    od.unit_price AS regular_unit_price,
    ROUND(od.discount * od.unit_price, 2) AS discount_unit_price,
    ROUND(od.unit_price * (1 - od.discount), 2) AS net_unit_price,
    ROUND(od.unit_price * od.quantity * od.discount, 2) AS extended_discount_amount,
    ROUND(od.unit_price * od.quantity * (1 - od.discount), 2) AS extended_sales_amount
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
LEFT JOIN customers_at_order_time c ON o.order_id = c.order_id
LEFT JOIN products_at_order_time p ON o.order_id = p.order_id AND od.product_id = p.product_id