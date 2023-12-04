-- Find the average time between taxi pick ups per zone
-- ● Use lead or lag to find the next trip per zone for each record
-- ● then find the time difference between the pick up time for the current record and the next
-- then use this result to calculate the average time between pick ups per zone.

SELECT 
    lead_lag.zone,
    AVG(lead_lag.time_between_pickups) AS avg_time_between_pickups
FROM (
    SELECT
        taxi_trips.pickup_datetime,
        LEAD(taxi_trips.pickup_datetime) OVER zone_ave AS next_pickup_datetime,
        DATEDIFF('minute', taxi_trips.pickup_datetime, LEAD(taxi_trips.pickup_datetime) OVER zone_ave) AS time_between_pickups,
        pickup_locations.zone
    FROM
        {{ ref('mart__fact_all_taxi_trips') }} AS taxi_trips
    JOIN
        {{ ref( 'mart__dim_locations') }} AS pickup_locations
    ON
        taxi_trips.pulocationid = pickup_locations.LocationID
    WINDOW
        zone_ave AS (PARTITION BY pickup_locations.zone ORDER BY taxi_trips.pickup_datetime)
) AS lead_lag
GROUP BY
    lead_lag.zone;