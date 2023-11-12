-- column order changed to match that of green_tripdata as best as possible
-- corrections to some code here provided by Pete Fein 

WITH source AS (

    SELECT * FROM {{ source('main', 'yellow_tripdata') }}

),

renamed AS (

    SELECT
        vendorid as vendorid,
        tpep_pickup_datetime,
        tpep_dropoff_datetime,
        -- boolean macro for store_and_fwd_flag
        {{ boolean_macro('store_and_fwd_flag') }} as store_and_fwd_flag,
        ratecodeid as ratecodeid,
        pulocationid as pulocationid,
        dolocationid as dolocationid,
        passenger_count::int as passenger_count,
        'trip_distance' as trip_distance,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        improvement_surcharge,
        total_amount,
        payment_type,
        congestion_surcharge,
        airport_fee,
        filename
    
    FROM source
    WHERE tpep_pickup_datetime < TIMESTAMP '2023-01-01'
    AND trip_distance >= 0 -- drop trip distance < 0
)

SELECT * FROM renamed