-- dim_products must have the same number of rows as its staging counterpart
-- Therefore return records where this isn't true to make the test fail
with stg_products as (
    select product_id from {{ ref('stg_northwind__products') }}
),
dim_products as (
    select product_id from {{ ref('dim_products') }}
)

select *
from (
    select product_id from dim_products
    except
    select product_id from stg_products

    union all

    select product_id from stg_products
    except
    select product_id from dim_products
) mismatched
