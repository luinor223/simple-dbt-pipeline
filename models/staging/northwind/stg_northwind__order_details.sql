WITH source AS (
    SELECT *,
        ROW_NUMBER() OVER (
               PARTITION BY orderID, productID
               ORDER BY orderID, productID
           ) AS row_num
    FROM {{ source('raw_layer', 'order_details') }}
),
renamed AS (
    SELECT
        orderID AS order_id,
        productID AS product_id,
        COALESCE(unitPrice, 0.00) AS unit_price,
        COALESCE(quantity, 0) AS quantity,
        COALESCE(discount, 0.0) AS discount
    FROM source
    WHERE orderID IS NOT NULL
    AND productID IS NOT NULL
    AND row_num = 1
)
SELECT *
FROM renamed