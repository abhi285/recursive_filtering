-- macros/recursive_sum.sql
{% macro recursive_sum(measure_expr) %}
    SUM({{ measure_expr }})
{% endmacro %}