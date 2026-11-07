WITH cte AS (

    SELECT
        TO_TIMESTAMP(started_at) AS started_at

    FROM {{ source('demo', 'bike') }}

    WHERE started_at != 'started_at'

),

date_attributes AS (

    SELECT
        started_at,
        DATE(started_at) AS date_started_at,
        HOUR(started_at) AS hour_started_at,
        DAYNAME(started_at) AS day_name,
        MONTH(started_at) AS month_started_at

    FROM cte

)

SELECT
    started_at,
    date_started_at,
    hour_started_at,

    CASE
        WHEN day_name IN ('Sat', 'Sun') THEN 'Weekend'
        ELSE 'Business Day'
    END AS day_type,

    month_started_at,

    CASE
        WHEN month_started_at IN (12, 1, 2) THEN 'Winter'
        WHEN month_started_at IN (3, 4, 5) THEN 'Spring'
        WHEN month_started_at IN (6, 7, 8) THEN 'Summer'
        ELSE 'Autumn'
    END AS season_of_year

FROM date_attributes