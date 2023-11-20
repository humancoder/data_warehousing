-- source Pete Fein

SELECT
    weekday(started_at_ts) as weekday,
    count(*) as total_trips,
    sum(duration_sec) as total_total_duration_sec
FROM
    {{ ref('mart__fact_all_bike_trips') }}
GROUP BY
    weekday(started_at_ts)