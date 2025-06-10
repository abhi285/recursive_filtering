-- models/core/fact_cruise_revenue.sql
{{ config(
    materialized='table'
)}}

SELECT
    raw_rev.booking_id,
    raw_rev.guest_id,
    raw_rev.revenue_amount,
    raw_rev.booking_date,
    -- Get descriptive names and IDs from the pre-joined hierarchy dimension
    dim_hierarchy.corporate_entity_id, -- <--- ADDED ID
    dim_hierarchy.corporate_entity,
    dim_hierarchy.brand_id,          -- <--- ADDED ID
    dim_hierarchy.brand_name,
    dim_hierarchy.ship_id,           -- <--- ADDED ID
    dim_hierarchy.ship_name,
    dim_hierarchy.department_id,     -- <--- ADDED ID
    dim_hierarchy.department_name,
    dim_hierarchy.service_name,
    raw_rev.service_id, -- This is the key for recursive filtering
    raw_rev.revenue_amount as revenue_per_guest
FROM {{ ref('stg_raw_cruise_revenue') }} raw_rev
LEFT JOIN {{ ref('dim_service_level_hierarchy') }} dim_hierarchy
    ON raw_rev.service_id = dim_hierarchy.service_id