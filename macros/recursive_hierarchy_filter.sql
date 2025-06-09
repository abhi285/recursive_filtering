-- macros/recursive_hierarchy_filter.sql
{% macro recursive_hierarchy_filter(hierarchy, level, value) %}
    -- This macro is designed to be used within the dbt Semantic Layer's 'filter' property in metrics.yml.
    -- It generates a SQL condition that links the semantic model's dimensions
    -- to the pre-filtered `int_hierarchical_filters` table, which is built using dbt variables.

    EXISTS (
        SELECT 1
        FROM {{ ref('int_hierarchical_filters') }} as _int_filters
        WHERE
            _int_filters.corporate_entity = {{ adapter.quote('corporate_entity') }} AND
            _int_filters.brand_name = {{ adapter.quote('brand_name') }} AND
            _int_filters.ship_name = {{ adapter.quote('ship_name') }} AND
            _int_filters.department_name = {{ adapter.quote('department_name') }} AND
            _int_filters.service_name = {{ adapter.quote('service_name') }} AND
            (_int_filters.meets_filter_criteria OR _int_filters.include_children)
    )
{% endmacro %}