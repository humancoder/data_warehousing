-- Finding number of taxi trips that ended at "Airports" or "EWR"

SELECT
    count(*) as total_trips
FROM
    {{ ref('mart__fact_all_taxi_trips') }} as taxi_trips
JOIN 
    {{ ref('mart__dim_locations') }} as locations
ON
    taxi_trips.dolocationid = locations.LocationID
WHERE
   locations.service_zone = 'Airport' OR locations.service_zone = 'EWR';