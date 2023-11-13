WITH source AS (

    SELECT * FROM {{ source('main', 'fhv_bases') }}

),

renamed AS (

    SELECT
        -- to maintain consistency with other text, they made in upper case
        TRIM(UPPER(base_number)) as base_number,
        TRIM(UPPER(base_name)) as base_name,
        dba,
        TRIM(UPPER(dba_category)) as dba_category,
        filename
    
    FROM source
)

SELECT * FROM renamed