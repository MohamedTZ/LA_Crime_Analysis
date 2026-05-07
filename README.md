# Los Angeles Crime Data Analysis
## Project Overview

The main purpose of this portfolio data analytic project is to uncover patterns, trends, and actionable insights for law enforcement.

## Objectives
* Identify crime hotspots
* Analyze time-based trends
* Understand victim demographics
* Provide actionable recommendations

## Tools Used
* SQL (PostgreSQL / MySQL)
* Tableau
* Excel / CSV

## Project Structure
* data/ → Raw dataset
* sql/ → SQL analysis queries
* tableau/ → Dashboard
* reports/ → Intelligence report

## Dataset source 
https://data.lacity.org/Public-Safety/Crime-Data-from-2020-to-2024/2nrs-mtv8/about_data

## Dataset
* DR_NO - Division of Records Number: Official file number made up of a 2 digit year, area ID, and 5 digits
* date_reported - Date the crime was reported
* date_occurred - Date the crime was commited
* time_occurred - Time of the crime in 24 hour format
* area - The 21 Geographic Areas or Patrol Divisions are also given a name designation that references a landmark or the surrounding community that it is responsible for. For example 77th Street Division is located at the intersection of South Broadway and 77th Street, serving neighborhoods in South Los Angeles.
* crime_desc - Defines the Crime Code provided.
* vict_age - Victim age
* vict_sex - Victim gender
* vict_desc - Victim descent coded
* weapon_desc - Description of the weapon used to commit the crime
* status_desc - Crime status
* address - Street address of the crime
* victim_descent_full - Full description of victim's ethnicity

## Key Insights
1) Certain areas have significantly higher crime rates
   * Central, Southwest, 77th Street area have more than 10,000 crimes reported
2) Crimes peak during afternoon (12 pm to 6 pm), evening (6 pm to 12 am) and morning hours (6 am to 12 pm)
3) Specific victim groups are more affected - Both Men and Women in their 30s are the most affected followed by 20s

## Tableau Dashboard link
https://public.tableau.com/views/LACrimeDashboardsStories/EthnicityAnalysis?:language=en-GB&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

![This is an image](https://github.com/MohamedTZ/LA_Crime_Analysis/blob/main/Crime%20patterns%20%26%20hotspots.jpg)


