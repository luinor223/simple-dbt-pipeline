WITH source AS (
    SELECT *
    FROM {{ source('raw_layer', 'products') }}
),
renamed AS (
    SELECT
        productID AS product_id,
        productName AS product_name,
        supplierID AS supplier_id,
        categoryID AS category_id,
        quantityPerUnit AS quantity_per_unit,
        discontinued
    FROM source
)
SELECT *
FROM renamed