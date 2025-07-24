WITH source AS (
    SELECT *,
        ROW_NUMBER() OVER (
               PARTITION BY orderID
               ORDER BY orderDate
           ) AS row_num
    FROM {{ source('raw_layer', 'orders') }}
),
renamed AS (
    SELECT
        orderID AS order_id,
        customerID AS customer_id,
        employeeID AS employee_id,
        orderDate::date AS order_date,
        requiredDate::date AS required_date,
        shippedDate::date AS shipped_date,
        freight,
        CASE
            WHEN customerID IS NULL THEN TRUE
            ELSE FALSE
        END AS is_missing_customer
    FROM source
    WHERE orderID IS NOT NULL
    AND row_num = 1
)
SELECT *
FROM renamed