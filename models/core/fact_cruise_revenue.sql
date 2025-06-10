-- models/core/fact_cruise_revenue.sql
{{ config(
    materialized='table'
)}}

SELECT
    rev.booking_id,
    rev.guest_id,
    rev.revenue_amount,
    rev.booking_date,
    corp.hierarchy_name AS corporate_entity,
    brand.hierarchy_name AS brand_name,
    ship.hierarchy_name AS ship_name,
    dept.hierarchy_name AS department_name,
    service.hierarchy_name AS service_name,
    service.hierarchy_id AS service_id,
    rev.revenue_amount as revenue_per_guest
FROM {{ ref('stg_raw_cruise_revenue') }} rev
LEFT JOIN {{ ref('stg_raw_organizational_hierarchy') }} service ON rev.service_id = service.hierarchy_id
LEFT JOIN {{ ref('stg_raw_organizational_hierarchy') }} dept ON rev.department_id = dept.hierarchy_id
LEFT JOIN {{ ref('stg_raw_organizational_hierarchy') }} ship ON rev.ship_id = ship.hierarchy_id
LEFT JOIN {{ ref('stg_raw_organizational_hierarchy') }} brand ON rev.brand_id = brand.hierarchy_id
LEFT JOIN {{ ref('stg_raw_organizational_hierarchy') }} corp ON rev.corporate_entity_id = corp.hierarchy_id