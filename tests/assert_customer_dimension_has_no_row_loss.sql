-- dim_customers must have the same number of rows as its staging counterpart
-- Therefore return records where this isn't true to make the test fail
with stg_customers as (
    select customer_id from {{ ref('stg_northwind__customers') }}
),
dim_customers as (
    select customer_id from {{ ref('dim_customers') }}
)

select *
from (
    select customer_id from dim_customers
    except
    select customer_id from stg_customers

    union all

    select customer_id from stg_customers
    except
    select customer_id from dim_customers
) mismatched