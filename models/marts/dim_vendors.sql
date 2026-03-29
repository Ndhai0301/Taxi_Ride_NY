with trips_unioned as (
    select * from {{ ref('int_trips_unioned') }}
), 

venders as (
    select 
        distinct vendor_id,
        {{ get_vendors_names('vendor_id') }} as vendor_name

    from trips_unioned
)
Select distinct * from venders