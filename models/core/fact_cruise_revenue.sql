-- models/core/fact_cruise_revenue.sql
{{ config(materialized='table') }}

SELECT
    booking_id,
    guest_id,
    corporate_entity,
    brand_name,
    ship_name,
    department_name,
    service_name,
    revenue_amount,
    booking_date,
    revenue_per_guest
FROM {{ ref('stg_cruise_revenue') }}