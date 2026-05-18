# Los Angeles Crime Data Analysis
## Project Overview

The main purpose of this portfolio data analytics project is to uncover patterns, trends, and actionable insights for law enforcement.

## Objectives
* Identify crime hotspots
* Analyze time-based trends
* Understand victim demographics
* Provide actionable recommendations

## Tools Used
* Python
* SQL (MySQL)
* Tableau

## Project Structure
* data/ → Raw dataset
* sql/ → SQL analysis queries
* tableau/ → Dashboard
* reports/ → Intelligence report

## Dataset source 
https://data.lacity.org/Public-Safety/Crime-Data-from-2020-to-2024/2nrs-mtv8/about_data

## Cleaned Dataset
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
1) Location: Central ranks number 1 crime spot with 10816 crimes
2) Time: Peak crime hours are between 6 pm and 8 pm at 2153 crimes
3) Type: Burglary, Assault, Theft are the top crime categories
4) Victim Age: Victim in their 30s and 20s are the most affected
5) Victim Gender: Men are more likely to be a victim
6) Victim Ethnicity: White and Latino are the most targeted ethnic groups followed by Black

## Tableau Dashboard link
https://public.tableau.com/app/profile/mohamed.thoufique.ziyavudeen/viz/LACrimeDashboardsStories/Story1

![This is an image](https://github.com/MohamedTZ/LA_Crime_Analysis/blob/main/Crime%20patterns%20%26%20hotspots.jpg)


