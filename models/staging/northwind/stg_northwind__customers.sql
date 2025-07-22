WITH source AS (
    SELECT *,
        ROW_NUMBER() OVER (
               PARTITION BY customerID
               ORDER BY customerID
           ) AS row_num
    FROM {{ source('raw_layer', 'customers') }}
),
renamed AS (
    SELECT
        customerID AS customer_id,
        companyName AS company_name,
        city,
        region,
        postalCode AS postal_code,
        country,
        updated_at
    FROM source
    WHERE customerID IS NOT NULL
    AND row_num = 1
)
SELECT *
FROM renamed