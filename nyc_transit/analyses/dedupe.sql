-- ● Use Window functions with QUALIFY and ROW_NUMBER to remove duplicate rows.
-- Prefer rows with a later time stamp

-- deduping on event_id 

SELECT
    {{ dbt_utils.star(ref('events')) }}
FROM
    {{ ref('events')}}

WiNDOW 
    latest AS (PARTITION BY event_id ORDER BY event_timestamp DESC)
QUALIFY
    ROW_NUMBER() OVER latest = 1

