-- macros/recursive_count.sql
{% macro recursive_count(measure_expr) %}
    COUNT(CASE WHEN {{ recursive_filter() }} THEN {{ measure_expr }} ELSE NULL END)
{% endmacro %}