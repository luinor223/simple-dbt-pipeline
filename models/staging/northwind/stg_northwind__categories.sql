WITH source AS (
    SELECT *
    FROM {{ source('raw_layer', 'categories') }}
),
renamed AS (
    SELECT
        categoryID AS category_id,
        categoryName AS category_name,
        description
    FROM source
)
SELECT *
FROM renamed