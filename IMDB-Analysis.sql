<h1> This code is used in Snowflake DEMO database </h1>
select * from @imdb_stage;
create table imdb_data_dump
(
 json_data variant
);

select * from imdb_data_dump;

copy into imdb_data_dump
from @imdb_stage
on_error = 'skip_file';

select * from imdb_data_dump;

select * from imdb_data_dump limit 10;

select json_data:imdb_rating
from imdb_data_dump limit 10;

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

select * from imdb_data_short_flatten

