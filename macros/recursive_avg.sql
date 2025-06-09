-- macros/recursive_avg.sql
{% macro recursive_avg(measure_expr) %}
    -- This macro calculates the average of a measure after applying the current recursive filter context.
    -- It assumes 'int_hierarchical_filters' has been built with the desired filter_level and filter_value.

    AVG(CASE WHEN {{ recursive_filter(var('filter_level'), var('filter_value')) }} THEN {{ measure_expr }} ELSE NULL END)
{% endmacro %}