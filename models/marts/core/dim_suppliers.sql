SELECT 
    {{ dbt_utils.generate_surrogate_key(['supplier_id', 'dbt_valid_from']) }} as supplier_key,
    supplier_id,
    company_name,
    city,
    region,
    postal_code,
    country,
    dbt_valid_from,
    dbt_valid_to,
    CASE WHEN dbt_valid_to IS NULL THEN TRUE ELSE FALSE END as is_current_version
FROM {{ ref('northwind__suppliers_snapshot') }}
