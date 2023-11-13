WITH source AS (

    SELECT * FROM {{ source('main', 'fhv_tripdata') }}

),

renamed AS (

    SELECT
        TRIM(UPPER(dispatching_base_num)) as dispatching_base_num,
        pickup_datetime::timestamp as pickup_datetime,
        dropoff_datetime::timestamp as dropoff_datetime,
        pulocationid::int as pulocationid,
        dolocationid::int as dolocationid,
        -- sr_flag is NULL in all rows and therefore is not included
        TRIM(UPPER(affiliated_base_number)) as affiliated_base_num,
        filename
    
    FROM source
    -- should use a macro to make sure all dates are before 2023
    WHERE pickup_datetime < TIMESTAMP '2022-12-31'
)

SELECT * FROM renamed
