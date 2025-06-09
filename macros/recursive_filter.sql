-- macros/recursive_filter.sql
{% macro recursive_filter(filter_level, filter_value) %}
    -- This macro applies a cascading filter by joining with `int_hierarchical_filters`.
    -- It assumes the calling model has columns matching the hierarchy dimensions.
    -- It relies on `int_hierarchical_filters` being built (via `dbt run --vars`) with the corresponding
    -- `filter_level` and `filter_value` variables.

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