
WITH trips AS (

    SELECT *
    FROM {{ ref('stg_bike') }}

    WHERE ride_id != 'ride_id'

)

SELECT
    ride_id,

    TO_TIMESTAMP(started_at) AS started_at,

    DATE(TO_TIMESTAMP(started_at)) AS trip_date,

    start_station_id,
    end_station_id,
    member_casual,

    TIMESTAMPDIFF(
        SECOND,
        TO_TIMESTAMP(started_at),
        TO_TIMESTAMP(ended_at)
    ) AS trip_duration_seconds

FROM trips
