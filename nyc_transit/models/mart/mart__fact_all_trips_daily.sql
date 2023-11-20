-- source: Pete Fein

SELECT
    type, 
    date_trunc('day', started_at_ts)::date as date,
    count(*) as trips,
    avg(duration_min) as avg_trip_duration_min
FROM
    {{ ref('mart__fact_all_trips') }}
GROUP BY
    ALL