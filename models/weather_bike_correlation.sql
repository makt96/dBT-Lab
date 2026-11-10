
WITH cte AS (

    SELECT
        t.*,
        w.*

    FROM {{ ref('trip_fact') }} AS t

    LEFT JOIN {{ ref('dailyweather') }} AS w
        ON t.trip_date = w.daily_weather

)

SELECT *
FROM cte
