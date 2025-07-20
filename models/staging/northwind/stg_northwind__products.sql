WITH source AS (
    SELECT *,
        ROW_NUMBER() OVER (
               PARTITION BY productID
               ORDER BY productID
           ) AS row_num
    FROM {{ source('raw_layer', 'products') }}
),
renamed AS (
    SELECT
        productID AS product_id,
        COALESCE(productName, 'Unknown') AS product_name,
        supplierID AS supplier_id,
        categoryID AS category_id,
        quantityPerUnit AS quantity_per_unit,
        discontinued
    FROM source
    WHERE productID IS NOT NULL
    AND row_num = 1
)
SELECT *
FROM renamed