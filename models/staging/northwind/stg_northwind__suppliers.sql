WITH source AS (
    SELECT *
    FROM {{ source('raw_layer', 'suppliers') }}
),
renamed AS (
    SELECT
        supplierID AS supplier_id,
        companyName AS company_name,
        contactName AS contact_name,
        contactTitle AS contact_title,
        address,
        city,
        region,
        postalCode AS postal_code,
        country
    FROM source
)
SELECT *
FROM renamed