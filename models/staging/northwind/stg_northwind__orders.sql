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
        -- Force string conversion then parse to date
        TRY_CAST(NULLIF(CAST(orderDate AS VARCHAR), 'NULL') AS DATE) AS order_date,
        TRY_CAST(NULLIF(CAST(requiredDate AS VARCHAR), 'NULL') AS DATE) AS required_date,
        TRY_CAST(NULLIF(CAST(shippedDate AS VARCHAR), 'NULL') AS DATE) AS shipped_date,
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