WITH source AS (
    SELECT *,
        ROW_NUMBER() OVER (
               PARTITION BY categoryID
               ORDER BY categoryID
           ) AS row_num
    FROM {{ source('raw_layer', 'categories') }}
),
renamed AS (
    SELECT
        categoryID AS category_id,
        COALESCE(categoryName, 'Unknown') AS category_name,
        description
    FROM source
    WHERE categoryID IS NOT NULL
    AND row_num = 1
)
SELECT *
FROM renamed