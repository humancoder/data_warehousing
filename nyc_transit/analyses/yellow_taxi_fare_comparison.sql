-- Write a query to compare an individual fare to the zone, borough and overall average fare using the fare_amount in yellow taxi trip data.

SELECT 
    taxi_trips.fare_amount,
    pickup_locations.borough,
    pickup_locations.zone,
    AVG(taxi_trips.fare_amount) OVER zone_ave AS "avg_zone_fare",
    AVG(taxi_trips.fare_amount) OVER borough_ave AS "avg_borough_fare",
    AVG(taxi_trips.fare_amount) OVER () AS "avg_overall_fare"


FROM
    "main"."staging"."stg__yellow_tripdata" AS taxi_trips
JOIN
    "main"."main"."mart__dim_locations" AS pickup_locations
ON
taxi_trips.pulocationid = pickup_locations.LocationID

WINDOW
    borough_ave AS (PARTITION BY pickup_locations.borough),
    zone_ave AS (PARTITION BY pickup_locations.zone)

LIMIT 100;


-- test 
