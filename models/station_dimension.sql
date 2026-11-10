
WITH bike AS (

    SELECT *
    FROM {{ source('demo', 'bike') }}

),

station_dimension AS (

    SELECT DISTINCT
        start_station_name AS station_name,
        start_station_id AS station_id,
        start_lat AS latitude,
        start_lng AS longitude

    FROM bike

    WHERE ride_id != 'ride_id'

)

SELECT *
FROM station_dimension
