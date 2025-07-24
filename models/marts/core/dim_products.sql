WITH product_snapshot AS (
    SELECT *
    FROM {{ ref('northwind__products_snapshot') }}
),
enriched_products AS (
    SELECT
        p.product_id,
        p.product_name,
        s.supplier_key,
        p.category_id,
        c.category_name,
        c.description AS category_description,
        p.quantity_per_unit,
        p.discontinued,
        p.dbt_valid_from,
        p.dbt_valid_to
    FROM product_snapshot p
    LEFT JOIN {{ ref('dim_suppliers') }} s 
        ON p.supplier_id = s.supplier_id
        AND p.dbt_valid_from >= s.dbt_valid_from
        AND (p.dbt_valid_from < s.dbt_valid_to OR s.dbt_valid_to IS NULL)
    LEFT JOIN {{ ref('stg_northwind__categories') }} c 
        ON p.category_id = c.category_id
)
SELECT
    {{ dbt_utils.generate_surrogate_key(['product_id', 'dbt_valid_from']) }} AS product_key,
    product_id,
    product_name,
    supplier_key,
    category_id,
    category_name,
    category_description,
    quantity_per_unit,
    discontinued,
    dbt_valid_from,
    dbt_valid_to,
    CASE WHEN dbt_valid_to IS NULL THEN TRUE ELSE FALSE END as is_current_version
FROM enriched_products
