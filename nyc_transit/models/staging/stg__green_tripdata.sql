-- code from Data Warehousing Lecture 2.4
-- Using source macro because we are using a source table. If we are using a model, we would use a ref macro.
-- Code and syntax changes (for improved readbility) borrowed from Pete Fein.
-- positive_macro was removed in order to better match solutions code and data outputs.

WITH source AS (

    SELECT * FROM {{ source('main', 'green_tripdata') }}

),

renamed AS (

    SELECT
        vendorid,
        lpep_pickup_datetime,
        lpep_dropoff_datetime,
        -- boolean macro for store_and_fwd_flag
        {{ boolean_macro('store_and_fwd_flag') }} as store_and_fwd_flag,
        ratecodeid,
        pulocationid,
        dolocationid,
        passenger_count:: int as passenger_count,
        trip_distance,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        -- ehail fee is always NULL and therefore not included
        improvement_surcharge,
        total_amount,
        payment_type,
        trip_type,
        congestion_surcharge,
        filename
    
    FROM source
        WHERE lpep_dropoff_datetime < TIMESTAMP '2023-01-01' -- drop rows outside of dataset
            AND trip_distance >= 0 -- drop trip distance < 0
            AND trip_distance < 1000 -- drop trip distance > 1000
)

SELECT * FROM renamed


