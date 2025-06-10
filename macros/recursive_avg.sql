-- macros/recursive_avg.sql
{% macro recursive_avg(measure_expr) %}
    AVG(CASE WHEN {{ recursive_filter() }} THEN {{ measure_expr }} ELSE NULL END)
{% endmacro %}