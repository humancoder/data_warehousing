-- Make a query which finds taxi trips which don’t have a pick up location_id in the locations table.

SELECT
    *
FROM
    {{ ref('mart__fact_all_taxi_trips') }} AS taxi_trips
LEFT JOIN
    {{ ref('mart__dim_locations') }} AS pickup_locations
ON
    taxi_trips.pulocationid = pickup_locations.LocationID
WHERE
    pickup_locations.LocationID IS NULL
    
    LIMIT 100;