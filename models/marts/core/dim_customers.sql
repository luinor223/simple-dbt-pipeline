SELECT 
    {{ dbt_utils.generate_surrogate_key(['customer_id', 'dbt_valid_from']) }} as customer_key,
    customer_id,
    company_name,
    city,
    region,
    country,
    dbt_valid_from,
    dbt_valid_to,
    CASE WHEN dbt_valid_to IS NULL THEN TRUE ELSE FALSE END as is_current_version
FROM {{ ref('northwind__customers_snapshot') }}