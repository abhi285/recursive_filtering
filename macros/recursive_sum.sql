-- macros/recursive_sum.sql
{% macro recursive_sum(measure_expr) %}
    SUM(CASE WHEN {{ recursive_filter() }} THEN {{ measure_expr }} ELSE 0 END)
{% endmacro %}