-- from week 4 Hw

-- Select all trips by borough from the fact table all_taxi_trips and join with the dim table locations

SELECT
    borough,
    COUNT(*) AS total_trips
FROM
    "main"."main"."mart__fact_all_taxi_trips" AS taxi_trips
JOIN 
    "main"."main"."mart__dim_locations" AS pickup_locations
ON
    taxi_trips.pulocationid = pickup_locations.LocationID
GROUP BY
    pickup_locations.Borough 



