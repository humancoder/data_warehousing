-- Write a query to calculate the 7 day moving min, max, avg, sum for precipitation and snow for every day in the weather data, defining the window only once.
-- The 7 day window should center on the day in question (for each date, the 3 days before, the date & 3 days after).

SELECT
    date,
    prcp,
    snow,
    AVG(prcp) OVER seven as seven_day_AVG_prcp,
    MIN(prcp) OVER seven as seven_day_MIN_prcp,
    MAX(prcp) OVER seven as seven_day_MAX_prcp,
    SUM(prcp) OVER seven as seven_day_SUM_prcp,
    AVG(snow) OVER seven as seven_day_AVG_snow,
    MIN(snow) OVER seven as seven_day_MIN_snow,
    MAX(snow) OVER seven as seven_day_MAX_snow,
    SUM(snow) OVER seven as seven_day_SUM_snow

FROM
    {{ ref('stg__central_park_weather') }}
WINDOW
    seven AS (
        ORDER BY "Date" ASC
        RANGE BETWEEN INTERVAL 3 DAYS PRECEDING
                  AND INTERVAL 3 DAYS FOLLOWING)
