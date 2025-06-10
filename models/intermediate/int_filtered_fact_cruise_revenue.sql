-- models/intermediate/int_filtered_fact_cruise_revenue.sql
{{ config(
    materialized='view'
)}}

SELECT
    fcr.*
FROM {{ ref('fact_cruise_revenue') }} fcr
WHERE
    {{ recursive_hierarchy_filter(
        level=var('filter_level'),
        value=var('filter_value')
    ) }}