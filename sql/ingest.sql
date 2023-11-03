-- Drop tables if they exist
DROP TABLE IF EXISTS bike_data;
DROP TABLE IF EXISTS central_park_weather;
DROP TABLE IF EXISTS fhv_bases;
DROP TABLE IF EXISTS fhv_tripdata;
DROP TABLE IF EXISTS fhvhv_tripdata;
DROP TABLE IF EXISTS green_tripdata;   
DROP TABLE IF EXISTS yellow_tripdata;


-- Read in raw data into tables

-- Read in bike data from zipped csv
CREATE TABLE bike_data as SELECT * FROM
read_csv_auto('./data/citibike-tripdata.csv.gz', header=True, filename=True, all_varchar=TRUE);

-- Read in csv data
CREATE TABLE central_park_weather as SELECT * FROM
read_csv_auto('./data/central_park_weather.csv', header=True, filename=True, all_varchar=TRUE);

CREATE TABLE fhv_bases as SELECT * FROM 
read_csv_auto('./data/fhv_bases.csv', header=True, filename=True, all_varchar=TRUE);

CREATE TABLE fhv_tripdata as SELECT * FROM
read_parquet('./data/taxi/fhv_tripdata*.parquet', union_by_name=True, filename=True);

-- Read in parquet data
CREATE TABLE fhvhv_tripdata as SELECT * FROM
read_parquet('./data/taxi/fhvhv_tripdata*.parquet', union_by_name=True, filename=True);

CREATE TABLE green_tripdata as SELECT * FROM
read_parquet('./data/taxi/green_tripdata*.parquet', union_by_name=True, filename=True);

CREATE TABLE yellow_tripdata as SELECT * FROM 
read_parquet('./data/taxi/yellow_tripdata*.parquet', union_by_name=True, filename=True);

