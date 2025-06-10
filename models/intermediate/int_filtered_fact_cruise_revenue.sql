-- models/intermediate/int_filtered_fact_cruise_revenue.sql
{{ config(
    materialized='table'
)}}

SELECT
    fcr.*
FROM {{ ref('fact_cruise_revenue') }} fcr
WHERE
    -- Apply the recursive hierarchy filter using the macro.
    -- This macro relies on the 'int_organizational_hierarchy_closure' table
    -- and the dbt variables 'filter_level' and 'filter_value'.
    {{ recursive_hierarchy_filter(
        level=var('filter_level'),
        value=var('filter_value')
    ) }}