-- macros/recursive_filter.sql
{% macro recursive_filter() %}
    SERVICE_ID IN (SELECT service_id FROM {{ ref('int_hierarchical_filters') }})
{% endmacro %}