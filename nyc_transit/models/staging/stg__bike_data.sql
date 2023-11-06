-- The SQL is combining two different sets of bike share data. If columns are similar then they are combined. 

WITH source AS(
    
    SELECT * FROM {{ source('main', 'bike_data') }}

),

renamed AS (

    SELECT

        --  COALESCE to take a the non-null value from the two columns into one column. Since the data are from two different time periods, the data will not overlap. 
        COALESCE(starttime::timestamp, started_at::timestamp) AS starttime_clean,
        COALESCE(stoptime::timestamp, ended_at::timestamp) AS stoptime_clean,

        -- new tripduration column using the new start and stop times
        CASE
            WHEN EPOCH(stoptime_clean - starttime_clean) > 0 THEN EPOCH(stoptime_clean - starttime_clean)
            ELSE NULL
            END AS tripduration_clean,

        COALESCE(TRIM("start station id"), TRIM(start_station_id)) AS start_station_id,
        COALESCE(TRIM("start station name"), TRIM(start_station_name)) AS start_station_name,
        COALESCE("start station latitude"::double, start_lat::double) AS start_station_latitude,
        COALESCE("start station longitude"::double, start_lng::double) AS start_station_longitude,
        COALESCE(TRIM("end station id"), TRIM(end_station_id)) AS end_station_id,
        COALESCE(TRIM("end station name"), TRIM(end_station_name)) AS end_station_name,
        COALESCE("end station latitude"::double, end_lat::double) AS end_station_latitude,
        COALESCE("end station longitude"::double, end_lng::double) AS end_station_longitude,

        bikeid, 

        -- make bool for usertype, subscriber to TRUE, customer converted FALSE, and NULLs kept NULL
        CASE 
            WHEN usertype = 'Subscriber' THEN TRUE
            WHEN usertype = 'Customer' THEN FALSE
            ELSE NULL
          END AS usertype_clean,

        -- removing birth years that are not possible
        CASE
            WHEN "birth year"::int > 1910 THEN "birth year"::int
            ELSE NULL
            END AS birth_year,

        -- make bool for gender, 1 is male to TRUE, 2 is converted FALSE for female, and 0 is made NULL
        CASE 
            WHEN gender = '1' THEN TRUE
            WHEN gender = '2' THEN FALSE
            ELSE NULL
          END AS gender_clean,
          
        ride_id, 
        TRIM(rideable_type) as rideable_type, 

        -- make bool for member_casual, member to TRUE, casual to FALSE, and NULLs kept NULL
        CASE 
            WHEN member_casual = 'member' THEN TRUE
            WHEN member_casual = 'casual' THEN FALSE
            ELSE NULL
          END AS member_status, 

        
        filename

    FROM source

)

SELECT * FROM renamed


