-- Source: Pete Fein
-- modified to only only return a single row per station

SELECT
    station_id,
    MAX(station_name) as station_name,
    MAX(station_lat) as station_lat,
    MAX(station_lng) as station_lng
FROM
    (

SELECT 
    DISTINCT
    start_station_id as station_id,
    start_station_name as station_name,
    start_lat station_lat,
    start_lng station_lng
FROM {{ ref('stg__bike_data') }}
UNION
SELECT 
    DISTINCT
    end_station_id as station_id,
    end_station_name as station_name,
    end_lat station_lat,
    end_lng station_lng
FROM {{ ref('stg__bike_data') }}

) as combined
GROUP BY station_id
