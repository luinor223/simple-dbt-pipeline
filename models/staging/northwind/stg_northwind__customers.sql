WITH source AS (
    SELECT *
    FROM {{ source('raw', 'customers') }}
)
SELECT
    customerID AS customer_id,
    companyName AS company_name,
    city,
    region,
    postalCode AS postal_code,
    country
FROM source
WHERE customerID IS NOT NULL