with taxi_zone_lookup as (
    select * from {{ref('taxi_zone_lookup')}}
),
rename_zones as (
    select 
        locationid as location_id,
        borough,
        zone,
        service_zone
    from taxi_zone_lookup
)

select * from rename_zones