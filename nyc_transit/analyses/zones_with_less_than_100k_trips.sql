-- Write a query which finds all the Zones where there are less than 100000 trips.

SELECT
    pickup_locations.zone,
    COUNT(*) AS total_trips
FROM
    "main"."main"."mart__fact_all_taxi_trips" taxi_trips
JOIN 
    "main"."main"."mart__dim_locations" AS pickup_locations
ON
    taxi_trips.pulocationid = pickup_locations.LocationID

GROUP BY
    pickup_locations.zone 

HAVING
    COUNT(*) < 100000