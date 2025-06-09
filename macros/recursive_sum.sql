-- macros/recursive_sum.sql
{% macro recursive_sum(measure_expr) %}
    -- This macro calculates the sum of a measure after applying the current recursive filter context.
    -- It assumes 'int_hierarchical_filters' has been built with the desired filter_level and filter_value.

    SUM(CASE WHEN {{ recursive_filter(var('filter_level'), var('filter_value')) }} THEN {{ measure_expr }} ELSE 0 END)
{% endmacro %}