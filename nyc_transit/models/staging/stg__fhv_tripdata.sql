WITH source AS (

    SELECT * FROM {{ source('main', 'fhv_tripdata') }}

),

renamed AS (

    SELECT
        dispatching_base_num,
        pickup_datetime::timestamp as pickup_datetime,
        dropoff_datetime::timestamp as dropoff_datetime,
        pulocationid::int as pulocationid,
        dolocationid::int as dolocationid,
        -- sr_flag is NULL in all rows and therefore is not included
        affiliated_base_number as affiliated_base_num,
        filename
    
    FROM source
    -- should use a macro to make sure all dates are before 2023
    WHERE dropoff_datetime < '2023-01-01'
)

SELECT * FROM renamed
