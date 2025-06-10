-- macros/recursive_count.sql
{% macro recursive_count(measure_expr) %}
    COUNT(DISTINCT {{ measure_expr }})
{% endmacro %}