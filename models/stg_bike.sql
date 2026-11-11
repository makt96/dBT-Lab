WITH bike AS (

    SELECT
        RIDE_ID,
        REPLACE(STARTED_AT, '"', '') AS STARTED_AT,
        REPLACE(ENDED_AT, '"', '') AS ENDED_AT,
        START_STATION_NAME,
        START_STATION_ID,
        END_STATION_NAME,
        END_STATION_ID,
        START_LAT,
        START_LNG,
        END_LAT,
        END_LNG,
        MEMBER_CASUAL

    FROM {{ source('demo', 'bike') }}

    WHERE RIDE_ID NOT IN ('"bikeid"', '""bikeid""')
      AND STARTED_AT NOT IN ('"starttime"', 'starttime', '""starttime""')

)

SELECT *
FROM bike
