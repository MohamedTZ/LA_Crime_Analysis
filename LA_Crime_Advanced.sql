-- ADVANCED LEVEL SQL

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

-- Which offences are showing the strongest growth in each police division, indicating emerging threats?
-- In other words, which crime types are increasing the fastest year-over-year in each area?
WITH crimes_area_year AS
  (SELECT
    area_name,
    EXTRACT(YEAR from date_occ) AS Year,
    crm_cd_desc,
    COUNT(*) AS total_crimes
  FROM CLEANEDdatabase.crimes
  GROUP BY crm_cd_desc, EXTRACT(YEAR from date_occ), area_name),
percent_crimes AS 
  (SELECT 
    *,
    LAG(total_crimes) OVER(PARTITION BY area_name, crm_cd_desc ORDER BY year) prev_year,
    ROUND((total_crimes - LAG(total_crimes) OVER(PARTITION BY area_name, crm_cd_desc ORDER BY year)) * 100.0 
        / LAG(total_crimes) OVER(PARTITION BY area_name, crm_cd_desc ORDER BY year),2) growth_percentage 
  FROM crimes_area_year)
SELECT 
  *,
  RANK() OVER(PARTITION BY area_name, crm_cd_desc ORDER BY growth_percentage DESC) AS rnk
FROM percent_crimes
QUALIFY RANK() OVER(PARTITION BY area_name, crm_cd_desc ORDER BY growth_percentage DESC) <= 3
ORDER BY area_name, crm_cd_desc, rnk;

-- What are the peak crime hours for each area and what crime types dominate those periods?
-- Find the busiest hour in each area, then determine the most common crime type during that hour.
WITH hour_and_crime_counts AS 
  (
    SELECT
      area_name,
      hour,
      crm_cd_desc,
      COUNT(*) AS total_crime_type
    FROM CLEANEDdatabase.crimes
    GROUP BY area_name, hour, crm_cd_desc
    QUALIFY RANK() OVER(PARTITION BY area_name, hour ORDER BY total_crime_type DESC) = 1
    ),
peak_hours AS
  (
    SELECT
      area_name,
      hour,
      COUNT(*) AS total_crimes_hour
    FROM CLEANEDdatabase.crimes
    GROUP BY area_name, hour
    QUALIFY RANK() OVER(PARTITION BY area_name ORDER BY total_crimes_hour DESC) = 1
  )

SELECT
  hc.area_name,
  hc.hour,
  ph.total_crimes_hour,
  hc.crm_cd_desc,
  hc.total_crime_type,
FROM hour_and_crime_counts hc
JOIN peak_hours ph
ON hc.area_name = ph.area_name AND hc.hour = ph.hour;

-- Which victim demographic groups are disproportionately affected by specific crime types?
SELECT
  crm_cd_desc,
  vict_descent_group, 
  COUNT(*) AS crimes_by_descent
FROM CLEANEDdatabase.crimes
GROUP BY vict_descent_group, crm_cd_desc
QUALIFY RANK() OVER(PARTITION BY crm_cd_desc ORDER BY COUNT(*) DESC) = 1
ORDER BY crm_cd_desc, crimes_by_descent DESC;

-- Which victim demographic groups are disproportionately affected by specific crime types?
WITH base_data AS
(
  SELECT *,
    CASE
        WHEN vict_age IS NULL THEN NULL
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
  		END AS age_group 
  FROM CLEANEDdatabase.crimes
)
SELECT
  crm_cd_desc,
  age_group,
  vict_sex,
  vict_descent_group,
  COUNT(*) as total_crimes,
  DENSE_RANK() OVER(PARTITION BY crm_cd_desc ORDER BY COUNT(*) DESC) as rnk
FROM base_data
GROUP BY 
  crm_cd_desc,
  age_group,
  vict_sex,
  vict_descent_group
QUALIFY DENSE_RANK() OVER(PARTITION BY crm_cd_desc ORDER BY COUNT(*) DESC) = 1
ORDER BY crm_cd_desc;

-- Which weapons are most associated with violent crimes, and in which areas are they concentrated?
-- Identify the top weapon-area combinations for violent offences

-- SELECT DISTINCT crm_cd_desc
-- FROM CLEANEDdatabase.crimes;

SELECT 
  area_name, 
  weapon_desc,
  COUNT(*) AS violent_crimes,
  RANK() OVER(PARTITION BY area_name ORDER BY COUNT(*) DESC) AS rnk
FROM CLEANEDdatabase.crimes
WHERE weapon_desc IS NOT NULL AND
        crm_cd_desc LIKE '%AGGRAVATED%' OR 
        crm_cd_desc LIKE '%RAPE%' OR
        crm_cd_desc LIKE '%SODOMY%' OR
        crm_cd_desc LIKE '%SEX%' OR
        crm_cd_desc LIKE '%LYNCH%' OR
        crm_cd_desc LIKE '%BOMB%' OR
        crm_cd_desc LIKE '%SHOT%' OR
        crm_cd_desc LIKE '%ROBBERY%' OR
        crm_cd_desc LIKE '%TRAFFICKING%' OR
        crm_cd_desc LIKE '%ARSON%' OR
        crm_cd_desc LIKE '%PROWLER%' OR
        crm_cd_desc LIKE '%MANSLAUGHTER%' OR
        crm_cd_desc LIKE '%HOMICIDE%'
GROUP BY area_name, weapon_desc
QUALIFY RANK() OVER(PARTITION BY area_name ORDER BY COUNT(*) DESC) <= 5
ORDER BY area_name, violent_crimes DESC;

-- Which areas have the highest repeat concentration of high-risk crime profiles?
WITH base_data AS
(
  SELECT *,
    CASE
        WHEN vict_age IS NULL THEN NULL
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
    CASE 
        WHEN time_occ BETWEEN '00:00:00' AND '05:59:59' THEN 'Night'
  			WHEN time_occ BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
  			WHEN time_occ BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
  			ELSE 'Evening' END AS period
  FROM CLEANEDdatabase.crimes
)
SELECT 
  area_name,
  crm_cd_desc,
  period,
  age_group,
  vict_sex,
  vict_descent_group,
  COUNT(*) AS total_crimes,
  RANK() OVER(PARTITION BY area_name ORDER BY COUNT(*) DESC) as rnk
FROM base_data
GROUP BY area_name, crm_cd_desc, period, age_group, vict_sex, vict_descent_group
QUALIFY RANK() OVER(PARTITION BY area_name ORDER BY COUNT(*) DESC) <= 5
ORDER BY area_name;

