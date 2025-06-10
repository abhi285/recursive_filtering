-- models/core/dim_service_level_hierarchy.sql
{{ config(
    materialized='table',
    schema='CUSTOMER_DATA_MODEL'
)}}

SELECT
    service.id AS service_id,
    service.name AS service_name,
    department.id AS department_id,
    department.name AS department_name,
    ship.id AS ship_id,
    ship.name AS ship_name,
    brand.id AS brand_id,
    brand.name AS brand_name,
    corporate_entity.id AS corporate_entity_id,
    corporate_entity.name AS corporate_entity
FROM {{ source('raw_data', 'organizational_hierarchy') }} service
LEFT JOIN {{ source('raw_data', 'organizational_hierarchy') }} department
    ON service.parent_id = department.id AND department.level_name IN ('department', 'sub_department') -- Include sub_department in lookup
LEFT JOIN {{ source('raw_data', 'organizational_hierarchy') }} ship
    ON department.parent_id = ship.id AND ship.level_name = 'ship'
LEFT JOIN {{ source('raw_data', 'organizational_hierarchy') }} brand
    ON ship.parent_id = brand.id AND brand.level_name = 'brand'
LEFT JOIN {{ source('raw_data', 'organizational_hierarchy') }} corporate_entity
    ON brand.parent_id = corporate_entity.id AND corporate_entity.level_name = 'corporate_entity'
WHERE service.level_name = 'service'