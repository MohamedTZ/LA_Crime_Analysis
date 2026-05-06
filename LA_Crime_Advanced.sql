-- ADVANCED LEVEL SQL
-- Above average crime areas
SELECT
	area,
    COUNT(*) AS total_crimes
FROM crimes
GROUP BY area
HAVING COUNT(*) > 
	(SELECT AVG(cnt)
	 FROM 
		(SELECT 
			COUNT(*) AS cnt
		FROM crimes
		GROUP BY area) t1
        ) 
ORDER BY total_crimes DESC;

-- Crime trends over time
WITH crime_trend AS
	(SELECT
		EXTRACT(YEAR FROM date_occurred) AS year,
		COUNT(*) AS total_crimes,
		LAG(COUNT(*)) OVER(ORDER BY EXTRACT(YEAR FROM date_occurred)) AS prev_year_crimes
	FROM crimes
	GROUP BY EXTRACT(YEAR FROM date_occurred))
SELECT
	year,
    total_crimes,
    prev_year_crimes,
    total_crimes - prev_year_crimes AS difference,
    CASE
		WHEN total_crimes - prev_year_crimes > 0 THEN 'Increase in crimes'
        WHEN total_crimes - prev_year_crimes < 0 THEN 'Decrease in crimes'
        ELSE 'Neutral'
        END AS Increase_Decrease
FROM crime_trend;

-- Serial crime patterns (crime + area)
SELECT 
    area,
    crime_desc,
    COUNT(*) AS total_crimes
FROM crimes
GROUP BY area, crime_desc
HAVING COUNT(*) > 100
ORDER BY area, total_crimes DESC;

-- Weapons usage by crime type
SELECT
	area,
	crime_desc,
    weapon_desc,
    COUNT(*) AS total_crimes
FROM crimes
WHERE weapon_desc IS NOT NULL
GROUP BY area, crime_desc, weapon_desc
ORDER BY area, total_crimes DESC;

-- Peak crime time per area
WITH crime_hour_area AS 
	(SELECT
		EXTRACT(HOUR FROM time_occurred) AS hour,
		area,
		COUNT(*) AS total_crimes,
		RANK() OVER(PARTITION BY area ORDER BY COUNT(*) DESC) AS rnk
	FROM crimes
	GROUP BY EXTRACT(HOUR FROM time_occurred), area)
SELECT
	hour,
    area,
    total_crimes
FROM crime_hour_area
WHERE rnk = 1;

-- Victim targeting patterns

SELECT 
    crime_desc,
    vict_sex,
    COUNT(*) AS total
FROM crimes
GROUP BY crime_desc, vict_sex
ORDER BY total DESC;

-- Case resolution rate
SELECT 
    status_desc,
    COUNT(*) AS total,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM crimes
GROUP BY status_desc;

