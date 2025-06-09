-- macros/recursive_brand_filter.sql
{% macro recursive_brand_filter(selected_brand) %}
    -- This macro is specific to brand-level filtering, likely used for the brand_performance_cascade metric.
    -- It effectively wraps recursive_hierarchy_filter for the 'brand' level.
    -- Note: For this POC, it relies on the global 'filter_value' being set to the desired brand
    -- when `int_hierarchical_filters` is built.

    {{ recursive_hierarchy_filter(
        hierarchy='organizational_hierarchy',
        level='brand',
        value=selected_brand -- This would typically come from var('selected_brand')
    ) }}
{% endmacro %}