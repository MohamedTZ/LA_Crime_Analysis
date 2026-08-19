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
* SQL (MySQL and duckdb)
* Tableau

## Project Structure
* python/ → Raw dataset
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
* area - The 21 Geographic Areas or Patrol Divisions are also given a name designation that references a landmark or the surrounding community that it is responsible for. For example 77th Street Division is located at the intersection of South Broadway and 77th Street, serving neighbourhoods in South Los Angeles.
* crime_desc - Defines the Crime Code provided.
* vict_age - Victim age
* vict_sex - Victim gender
* vict_desc - Victim descent coded
* weapon_desc - Description of the weapon used to commit the crime
* status_desc - Crime status
* address - Street address of the crime
* victim_descent_full - Full description of victim's ethnicity

## SQL queries
### Advanced
- Which crime types are increasing the fastest year-over-year in each area? (Which offences are showing the strongest growth in each police division, indicating emerging threats?)
- What are the peak crime hours for each area and what crime types dominate those periods? (At what times does each area experience the highest crime volume, and which offences are most common during those hours?)
- Which victim demographic groups are disproportionately affected by specific crime types? (Which combinations of age group, sex, and descent appear most frequently for major crimes?)
- Which weapons are most associated with violent crimes, and in which areas are they concentrated? (What weapons are used most often in violent incidents, and where do those incidents occur most frequently?)
- Which areas have the highest repeat concentration of high-risk crime profiles? (Which areas repeatedly experience the same high-risk combination of crime type, victim profile, and time period?)

### Intermediate
- Top 5 most common crimes
- Crimes by Period of the day: Breaking down by morning, afternoon, evening and night
- Crimes by Area
- Crimes by age group
- Crime reporting delay
- Above average crime areas
- Serial crime patterns
- Weapons usage by crime type
- Peak crime type by area
- Victim targeting patterns
- Case resolution rate

### EDA and Time based exploration
- How many records are there in the dataset?
- What are the distinct crime types?
- Crimes per year
- Crimes by hour of the day
- Missing Values
- Which areas have the highest crime?
- Victim age distribution
- Victim gender
- Weapons analysis

## Key Insights
1) Location: Central ranks number 1 crime spot with 69,654 crimes
2) Peak Crime Hour: 67,783 crimes reported between 12 pm and 1 pm 
3) Crime Type: Stolen Vehicles, Battery Simple Assault, Burglary from Vehicles are the top 3 crime categories
4) Victim Age: Victim in their 30s and 20s are the most affected
5) Victim Gender: Men are more likely to be a victim 
6) Victim Ethnicity: Hispanic victims are the most targeted ethnic groups followed by White
7) Weapon: Strong-arm (Body force) is the most reported weapon used

## Tableau Dashboard link
https://public.tableau.com/app/profile/mohamed.thoufique.ziyavudeen/viz/LACrimeDashboardsStories/Story1

![This is an image](https://github.com/MohamedTZ/LA_Crime_Analysis/blob/main/Crime%20patterns%20%26%20hotspots.jpg)


