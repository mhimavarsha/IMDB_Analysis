# IMDB_Analysis
---

# **Snowflake Database Setup and Data Transformation for IMDb Data**

## Project Overview

This project demonstrates setting up and transforming JSON data in Snowflake using a Snowflake stage. The process includes ingesting IMDb data from an external source (Bright Data), creating a database and tables in Snowflake, and transforming JSON data into a flattened table structure for easy analysis. 

The script uses SnowSQL commands and Snowflake SQL functions to load, parse, and flatten JSON data from IMDb. This can be extended to other datasets in JSON format with similar data transformation needs.

### Prerequisites

- **Snowflake Account:** You need access to a Snowflake account to create a database, warehouse, and tables.
- **SnowSQL:** Download and configure SnowSQL to interact with your Snowflake instance ([Download SnowSQL](https://docs.snowflake.com/en/user-guide/snowsql.html)).
- **Bright Data Account:** Used for obtaining IMDb data in CSV format. 

## Steps for Setting Up and Running the Project

### 1. **Retrieve IMDb Data with Bright Data**
   - Use Bright Data to download IMDb data in CSV format. Bright Data allows you to fetch large-scale data from the web. Once downloaded, save the CSV data locally for loading into Snowflake.
   
### 2. **Create and Configure Snowflake Database and Stage**

   1. **Create a Stage for IMDb Data**:
      ```sql
      create or replace stage imdb_stage;
      ```
   2. **Upload the CSV data** to the Snowflake stage (e.g., `imdb_stage`) using the SnowSQL `PUT` command or via the Snowflake UI.

### 3. **Load IMDb Data into Snowflake**

   1. **Create Table for IMDb JSON Data**:
      ```sql
      create table imdb_data_dump (json_data variant);
      ```
      This table holds raw JSON data before flattening.

   2. **Copy Data into IMDb Table**:
      ```sql
      copy into imdb_data_dump from @imdb_stage on_error = 'skip_file';
      ```

### 4. **Explore Data**

   After copying the data, you can preview the JSON data in `imdb_data_dump`:
   ```sql
   select * from imdb_data_dump limit 10;
   ```

### 5. **Flatten and Transform Data for Analysis**

   - This step involves transforming the JSON data by creating a new flattened table, `imdb_data_short_flatten`, where each column represents a specific IMDb attribute.
   
   ```sql
   CREATE OR REPLACE TABLE imdb_data_short_flatten AS
   SELECT 
       ROW_NUMBER() OVER (ORDER BY replace(parse_json(json_data):title,'"')) AS rn,
       TRY_TO_DATE(replace(parse_json(json_data):timestamp,'"'), 'YYYY-MM-DD') AS timestamp,
       replace(parse_json(json_data):title,'"')::string AS title,
       TRY_CAST(replace(parse_json(json_data):popularity,'"') AS FLOAT) AS popularity,
       replace(parse_json(json_data):genres,'"')::string AS genres,
       replace(parse_json(json_data):presentation,'"')::string AS presentation,
       replace(parse_json(json_data):credit,'"')::string AS credit,
       replace(parse_json(json_data):videos,'"')::string AS videos,
       replace(parse_json(json_data):photos,'"')::string AS photos,
       replace(parse_json(json_data):top_cast,'"')::string AS top_cast,
       TRY_TO_DATE(replace(parse_json(json_data):details_release_date,'"'), 'YYYY-MM-DD') AS details_release_date,
       replace(parse_json(json_data):details_countries_of_origin,'"')::string AS details_countries_of_origin,
       replace(parse_json(json_data):details_official_site,'"')::string AS details_official_site,
       replace(parse_json(json_data):details_language,'"')::string AS details_language,
       replace(parse_json(json_data):details_also_known_as,'"')::string AS details_also_known_as,
       replace(parse_json(json_data):details_filming_locations,'"')::string AS details_filming_locations,
       replace(parse_json(json_data):details_production_companies,'"')::string AS details_production_companies,
       replace(parse_json(json_data):specs_color,'"')::string AS specs_color,
       replace(parse_json(json_data):specs_sound_mix,'"')::string AS specs_sound_mix,
       replace(parse_json(json_data):specs_aspect_ratio,'"')::string AS specs_aspect_ratio,
       replace(parse_json(json_data):url,'"')::string AS url,
       replace(parse_json(json_data):media_type,'"')::string AS media_type,
       TRY_CAST(replace(parse_json(json_data):imdb_rating,'"') AS FLOAT) AS imdb_rating,
       replace(parse_json(json_data):poster_url,'"')::string AS poster_url,
       TRY_CAST(replace(parse_json(json_data):imdb_rating_count,'"') AS INTEGER) AS imdb_rating_count,
       replace(parse_json(json_data):awards,'"')::string AS awards,
       TRY_CAST(replace(parse_json(json_data):critics_review_count,'"') AS INTEGER) AS critics_review_count,
       TRY_CAST(replace(parse_json(json_data):episode_count,'"') AS INTEGER) AS episode_count,
       TRY_CAST(replace(parse_json(json_data):review_count,'"') AS INTEGER) AS review_count,
       TRY_CAST(replace(parse_json(json_data):review_rating,'"') AS FLOAT) AS review_rating,
       replace(parse_json(json_data):featured_review,'"')::string AS featured_review,
       regexp_replace(replace(parse_json(json_data):storyline,'"'), '<[^>]+>')::string AS storyline,
       replace(parse_json(json_data):boxoffice_budget,'"')::string AS boxoffice_budget
   FROM imdb_data_dump;
   ```

   - This query parses JSON fields, removes unwanted characters, and converts them into structured data for analysis.

### 6. **Validate and Query Flattened Data**

   Once the data is flattened, run queries to analyze the structured data:
   ```sql
   select * from imdb_data_short_flatten limit 10;
   ```

## Summary

This project demonstrates:
- Setting up a Snowflake environment for data ingestion and transformation.
- Using SQL commands to parse and flatten JSON data for analytical purposes.
- Leveraging Bright Data for data acquisition and Snowflake for cloud data management.

## Resources

- [SnowSQL Documentation](https://docs.snowflake.com/en/user-guide/snowsql.html)
- [Bright Data Documentation](https://brightdata.com/)

---


