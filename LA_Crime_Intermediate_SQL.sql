-- INTERMEDIATE ANALYTICS
-- TOP 5 most common crimes
SELECT
	crime_desc,
    COUNT(*) AS total_crimes
FROM crimes
GROUP BY crime_desc
ORDER BY total_crimes DESC
LIMIT 5;

-- Period of the day
-- Breaking down by morning, afternoon, evening and night

WITH crime_by_period AS
	(SELECT 
		*,
		CASE WHEN time_occurred BETWEEN '00:00:00' AND '05:59:59' THEN 'Night'
			 WHEN time_occurred BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
			 WHEN time_occurred BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
			 ELSE 'Evening' END AS period
	FROM crimes)
SELECT
	period,
    COUNT(*) AS total_crimes
FROM crime_by_period
GROUP BY period;

-- Area + Crime
SELECT
	area,
    crime_desc,
    COUNT(*) AS total_crimes
FROM crimes
GROUP BY area, crime_desc
ORDER BY area, total_crimes DESC;

-- Age group analysis
SELECT 
    CASE 
        WHEN vict_age < 18 THEN 'Under 18'
        WHEN vict_age BETWEEN 18 AND 35 THEN '18-35'
        WHEN vict_age BETWEEN 36 AND 60 THEN '36-60'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS total
FROM crimes
GROUP BY age_group;

-- Further breakdown
SELECT 
    CASE 
        WHEN vict_age <= 13 THEN 'Children'
        WHEN vict_age BETWEEN 14 AND 17 THEN 'Teenager'
        WHEN vict_age BETWEEN 18 AND 19 THEN 'Young Adult'
        WHEN vict_age BETWEEN 20 AND 29 THEN '20s'
        WHEN vict_age BETWEEN 30 AND 39 THEN '30s'
        WHEN vict_age BETWEEN 40 AND 49 THEN '40s'
        WHEN vict_age BETWEEN 50 AND 59 THEN '50s'
        WHEN vict_age BETWEEN 60 AND 69 THEN '60s'
        WHEN vict_age BETWEEN 70 AND 79 THEN '70s'
        WHEN vict_age BETWEEN 80 AND 89 THEN '80s'
        ELSE '90+'
    END AS age_group,
    COUNT(*) AS total_crimes
FROM crimes
GROUP BY age_group;

-- Reporting delay
-- Time difference between occurrence and reporting

SELECT 
	crime_desc,
	area,
	date_occurred,
	date_reported,
	timestampdiff(DAY, date_occurred, date_reported) AS delay_in_days
FROM crimes t
ORDER BY delay_in_days;