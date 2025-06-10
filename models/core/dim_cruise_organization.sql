-- models/core/dim_cruise_organization.sql
{{ config(
    materialized='table'
)}}

SELECT DISTINCT
    corporate_entity.name AS corporate_entity_name,
    brand.name AS brand_name,
    ship.name AS ship_name,
    department.name AS department_name,
    service.name AS service_name
FROM {{ source('raw_data', 'organizational_hierarchy') }} service
LEFT JOIN {{ source('raw_data', 'organizational_hierarchy') }} department ON service.parent_id = department.id AND department.level_name = 'department'
LEFT JOIN {{ source('raw_data', 'organizational_hierarchy') }} ship ON department.parent_id = ship.id AND ship.level_name = 'ship'
LEFT JOIN {{ source('raw_data', 'organizational_hierarchy') }} brand ON ship.parent_id = brand.id AND brand.level_name = 'brand'
LEFT JOIN {{ source('raw_data', 'organizational_hierarchy') }} corporate_entity ON brand.parent_id = corporate_entity.id AND corporate_entity.level_name = 'corporate_entity'
WHERE service.level_name = 'service'