
WITH daily_weather AS (

    SELECT
        DATE(time) AS daily_weather,
        weather,
        temp,
        pressure,
        humidity,
        clouds

    FROM {{ source('demo', 'weather') }}

),

daily_weather_aggregate AS (

    SELECT
        daily_weather,
        weather,

        ROUND(AVG(temp), 2) AS average_temp,
        ROUND(AVG(pressure), 2) AS average_pressure,
        ROUND(AVG(humidity), 2) AS average_humidity,
        ROUND(AVG(clouds), 2) AS average_clouds

    FROM daily_weather

    GROUP BY
        daily_weather,
        weather

    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY daily_weather
        ORDER BY COUNT(weather) DESC
    ) = 1

)

SELECT *
FROM daily_weather_aggregate
