-- models/core/dim_cruise_organization.sql
{{ config(materialized='table') }}

SELECT DISTINCT
    corporate_entity,
    brand_name,
    ship_name,
    department_name,
    service_name
FROM {{ ref('stg_cruise_organization') }}