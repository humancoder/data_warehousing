WITH trips_pu_do AS (
    SELECT
        weekday(pickup_datetime) AS weekday,
        pickup_locations.borough AS pickup_borough,
        dropoff_locations.borough AS dropoff_borough,
    FROM
        {{ ref('mart__fact_all_taxi_trips') }} AS taxi_trips
    JOIN 
        {{ ref('mart__dim_locations') }} AS pickup_locations
    ON
        taxi_trips.pulocationid = pickup_locations.LocationID
    JOIN 
        {{ ref('mart__dim_locations') }} AS dropoff_locations
    ON
        taxi_trips.dolocationid = dropoff_locations.LocationID

)

SELECT
    weekday,
    COUNT(*) AS total_trips,
    COUNT(*) FILTER (WHERE pickup_borough != dropoff_borough) AS total_inter_borough_trips,
    100.0 * COUNT(*) FILTER (WHERE pickup_borough != dropoff_borough) / COUNT(*) AS percent_inter_borough_trip,
FROM
    trips_pu_do
GROUP BY
    weekday
ORDER BY
    weekday;
