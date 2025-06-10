-- models/intermediate/int_hierarchical_filters.sql
{{ config(
    materialized='table',
    schema='CUSTOMER_DATA_MODEL'
)}}

WITH filtered_descendants AS (
    SELECT
        closure.descendant_id AS service_id,
        closure.descendant_level AS service_level,
        closure.descendant_name AS service_name
    FROM {{ ref('int_organizational_hierarchy_closure') }} closure
    WHERE
        closure.ancestor_level = '{{ var("filter_level") }}'
        AND closure.ancestor_name = '{{ var("filter_value") }}'
        AND closure.descendant_level = 'service'
)
SELECT service_id, service_level, service_name
FROM filtered_descendants

{% if var("filter_level") == 'none' or var("filter_value") == '' %}
UNION ALL
SELECT
    id AS service_id,
    level_name AS service_level,
    name AS service_name
FROM {{ source('raw_data', 'organizational_hierarchy') }}
WHERE level_name = 'service'
  AND id NOT IN (SELECT service_id FROM filtered_descendants)
{% endif %}