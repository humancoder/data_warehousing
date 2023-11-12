WITH source AS (

    SELECT * FROM {{ source('main', 'fhvhv_tripdata') }}

),

renamed AS (
    SELECT
        hvfhs_license_num,
        TRIM(UPPER(dispatching_base_num)) as dispatching_base_num,
        TRIM(UPPER(originating_base_num)) as originating_base_num,
        request_datetime,
        on_scene_datetime,
        pickup_datetime,
        dropoff_datetime,
        pulocationid as pulocationid,
        dolocationid as dolocationid,
        trip_miles,
        trip_time,
        
        -- There are some negative values in base_passenger_fare and other column, but I don't know enough about the data to change/remove them.
        base_passenger_fare,
        tolls,
        bcf,
        sales_tax,
        congestion_surcharge,
        airport_fee,
        tips,
        driver_pay,

        -- use boolean macro for shared_request_flag, shared_match_flag, access_a_ride_flag, wav_request_flag, wav_match_flag
        {{ boolean_macro('shared_request_flag') }} as shared_request_flag,
        {{ boolean_macro('shared_match_flag') }} as shared_match_flag,
        {{ boolean_macro('access_a_ride_flag') }} as access_a_ride_flag,
        {{ boolean_macro('wav_request_flag') }} as wav_request_flag,
        {{ boolean_macro('wav_match_flag') }} as wav_match_flag,
        filename
    
    FROM source
)

SELECT * FROM renamed