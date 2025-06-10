-- macros/recursive_avg.sql
{% macro recursive_avg(measure_expr) %}
    AVG({{ measure_expr }})
{% endmacro %}