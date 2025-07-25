-- dim_suppliers must have the same number of rows as its staging counterpart
-- Therefore return records where this isn't true to make the test fail
with stg_suppliers as (
    select supplier_id from {{ ref('stg_northwind__suppliers') }}
),
dim_suppliers as (
    select supplier_id from {{ ref('dim_suppliers') }}
)

select *
from (
    select supplier_id from dim_suppliers
    except
    select supplier_id from stg_suppliers

    union all

    select supplier_id from stg_suppliers
    except
    select supplier_id from dim_suppliers
) mismatched
