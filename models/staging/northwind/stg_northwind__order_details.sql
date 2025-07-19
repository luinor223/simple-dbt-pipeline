WITH source AS (
    SELECT *
    FROM {{ source('raw_layer', 'order_details') }}
),
renamed AS (
    SELECT
        orderID AS order_id,
        productID AS product_id,
        unitPrice AS unit_price,
        quantity,
        discount
    FROM source
)
SELECT *
FROM renamed