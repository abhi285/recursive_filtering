-- models/intermediate/int_organizational_hierarchy_closure.sql
{{ config(
    materialized='table'
)}}

WITH RECURSIVE hierarchy_paths AS (
    SELECT
        h.hierarchy_id AS ancestor_id,
        h.hierarchy_level AS ancestor_level,
        h.hierarchy_name AS ancestor_name,
        h.hierarchy_id AS descendant_id,
        h.hierarchy_level AS descendant_level,
        h.hierarchy_name AS descendant_name,
        0 AS depth
    FROM {{ ref('stg_raw_organizational_hierarchy') }} h

    UNION ALL

    SELECT
        hp.ancestor_id,
        hp.ancestor_level,
        hp.ancestor_name,
        h.id AS descendant_id,
        h.level_name AS descendant_level,
        h.name AS descendant_name,
        hp.depth + 1 AS depth
    FROM hierarchy_paths hp
    JOIN {{ source('raw_data', 'organizational_hierarchy') }} h
        ON hp.descendant_id = h.parent_id
)
SELECT DISTINCT
    ancestor_id,
    ancestor_level,
    ancestor_name,
    descendant_id,
    descendant_level,
    descendant_name
FROM hierarchy_paths
ORDER BY ancestor_id, descendant_id