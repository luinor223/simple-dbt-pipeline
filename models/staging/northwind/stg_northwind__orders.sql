WITH source AS (
    SELECT *
    FROM {{ source('raw_layer', 'orders') }}
),
renamed AS (
    SELECT
        orderID AS order_id,
        customerID AS customer_id,
        employeeID AS employee_id,
        orderDate AS order_date,
        requiredDate AS required_date,
        shippedDate AS shipped_date,
        freight
    FROM source
)
SELECT *
FROM renamed