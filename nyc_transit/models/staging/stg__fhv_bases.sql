WITH source AS (

    SELECT * FROM {{ source('main', 'fhv_bases') }}

),

renamed AS (

    SELECT
        base_number,
        base_name,
        dba,
        -- to maintain consistency with other text, they made in upper case
        TRIM(UPPER(dba_category)) as dba_category,
        filename
    
    FROM source
)

SELECT * FROM renamed