-- Write a query to calculate the 7 day moving average precipitation for every day in the weather data.
-- The 7 day window should center on the day in question (for each date, the 3 days before, the date & 3 days after).

-- from https://duckdb.org/docs/sql/window_functions

SELECT
    date,
    prcp,
    AVG(prcp) OVER seven as seven_day_AVG_prcp
FROM
    {{ ref('stg__central_park_weather') }}
WINDOW
    seven AS (
        ORDER BY "Date" ASC
        RANGE BETWEEN INTERVAL 3 DAYS PRECEDING
                  AND INTERVAL 3 DAYS FOLLOWING)
order by 1 , 2