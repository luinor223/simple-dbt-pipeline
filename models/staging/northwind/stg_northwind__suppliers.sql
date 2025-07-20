WITH source AS (
    SELECT *,
        ROW_NUMBER() OVER (
               PARTITION BY supplierID
               ORDER BY supplierID
           ) AS row_num
    FROM {{ source('raw_layer', 'suppliers') }}
),
renamed AS (
    SELECT
        supplierID AS supplier_id,
        COALESCE(companyName, 'Unknown') AS company_name,
        city,
        region,
        postalCode AS postal_code,
        country
    FROM source
    WHERE supplierID IS NOT NULL
    AND row_num = 1
)
SELECT *
FROM renamed