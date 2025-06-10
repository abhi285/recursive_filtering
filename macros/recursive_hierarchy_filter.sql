-- macros/recursive_hierarchy_filter.sql
{% macro recursive_hierarchy_filter(level, value) %}
    -- This macro generates a SQL WHERE clause condition for recursive filtering.
    -- It assumes the existence of the `int_organizational_hierarchy_closure` table.

    {% if level == 'none' or value == '' %}
        TRUE
    {% else %}
        SERVICE_ID IN (
            SELECT
                closure.descendant_id
            FROM {{ ref('int_organizational_hierarchy_closure') }} AS closure
            WHERE
                closure.ancestor_level = '{{ level }}'
                AND closure.ancestor_name = '{{ value }}'
                AND closure.descendant_level = 'service'
        )
    {% endif %}
{% endmacro %}