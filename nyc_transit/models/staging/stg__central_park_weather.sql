-- code from Data Warehousing Lecture 2.4
-- Using source macro because we are using a source table. If we are using a model, we would use a ref macro.

WITH source AS (

    SELECT * FROM {{ source('main', 'central_park_weather') }}

),

renamed AS (

    SELECT
        station,
        name,
        date::date as date,
        awnd::double as awnd,
        prcp::double as prcp,
        snow::double as snow,
        snwd::double as snwd,
        tmax::int as tmax,
        tmin::int as tmin,
        filename
    
    FROM source
)

SELECT * FROM renamed


