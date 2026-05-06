-- Exploratory Data Analysis (EDA)
 
-- How many records are there in the dataset?
SELECT
	COUNT(*) AS total_crimes
FROM crimes;

-- What are the distinct crime types?
SELECT 
	DISTINCT crime_desc
FROM crimes;

-- Missing Values
SELECT 
	COUNT(*) - COUNT(vict_age) AS missing_age,
    COUNT(*) - COUNT(vict_sex) AS missing_sex,
    COUNT(*) - COUNT(weapon_desc) AS missing_weapon
FROM crimes;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------

-- TIME BASED EXPLORATION
-- Crimes per year
SELECT 
    EXTRACT(YEAR FROM date_occurred) AS year,
    COUNT(*) AS total_crimes
FROM crimes
GROUP BY EXTRACT(YEAR FROM date_occurred)
ORDER BY year;

-- Crimes by hour of the day
WITH hourly_crime AS 
	(SELECT
		*,
		HOUR(time_occurred) AS hour_occurred
	FROM crimes)
SELECT
	hour_occurred,
    COUNT(*) AS total_crimes
FROM hourly_crime
GROUP BY hour_occurred
ORDER BY total_crimes DESC;

-- Which areas have the highest crime?
SELECT
	area,
    COUNT(*) AS total_crimes
FROM crimes
GROUP BY area
ORDER BY total_crimes DESC;

-- Victim age distribution
SELECT
	vict_age,
    COUNT(*) AS total_crimes
FROM crimes
GROUP BY vict_age
ORDER BY total_crimes DESC;

-- Victim gender
SELECT
	vict_sex,
    COUNT(*) AS total_crimes
FROM crimes
GROUP BY vict_sex
ORDER BY total_crimes DESC;

-- Weapons analysis
SELECT
	weapon_desc,
    COUNT(*) AS total_crimes
FROM crimes
GROUP BY weapon_desc
ORDER BY total_crimes DESC;