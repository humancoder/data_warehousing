-- Write a query to pivot the results by borough. Using dbt_utils.pivot()

-- could not get dbt_utils.pivot to work

-- using duckdb pivot

SELECT * 
FROM
(PIVOT "main"."main"."mart__fact_trips_by_borough" ON borough using sum(total_trips))

