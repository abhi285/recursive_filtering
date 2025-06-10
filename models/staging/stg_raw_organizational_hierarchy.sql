-- models/staging/stg_raw_organizational_hierarchy.sql
{{ config(
    materialized='view'
)}}

SELECT
    id AS hierarchy_id,
    parent_id AS hierarchy_parent_id,
    name AS hierarchy_name,
    level_name AS hierarchy_level
FROM
    {{ source('raw_data', 'organizational_hierarchy') }}