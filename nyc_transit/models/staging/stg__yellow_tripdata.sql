-- column order changed to match that of green_tripdata as best as possible

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
        passenger_count as passenger_count,

        -- trip distance made NULL if negative, using positive_macro
        {{ positive_macro('trip_distance') }} as trip_distance,
        
        -- fare amount made NULL if negative, using positive_macro
        {{ positive_macro('fare_amount') }} as fare_amount,
        -- extra might be a discount or an extra charge
        extra,
        {{positive_macro('mta_tax')}} as mta_tax,
        {{positive_macro('tip_amount')}} as tip_amount,
        {{positive_macro('tolls_amount')}} as tolls_amount,
       
        {{positive_macro('improvement_surcharge')}} as improvement_surcharge,
        {{positive_macro('total_amount')}} as total_amount,
        payment_type::int as payment_type,
        {{positive_macro('congestion_surcharge')}} as congestion_surcharge,
        {{positive_macro('airport_fee')}} as airport_fee,

        filename
    
    FROM source
)

SELECT * FROM renamed