-- macros/recursive_brand_filter.sql
{% macro recursive_brand_filter(selected_brand) %}
    {#
        This macro is specific to brand-level filtering.
        It's designed to wrap the `recursive_hierarchy_filter` for specific brand contexts.
        Note: For this POC, if used, it relies on the 'selected_brand' argument being passed.
        In the current Semantic Layer setup, the metric filters directly use 'filter_level'
        and 'filter_value' dbt variables.
    #}

    {{ recursive_hierarchy_filter(
        hierarchy='organizational_hierarchy',
        level='brand',
        value=selected_brand
    ) }}
{% endmacro %}