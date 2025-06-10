-- models/staging/stg_raw_cruise_revenue.sql
{{ config(
    materialized='view'
)}}

SELECT
    booking_id,
    guest_id,
    corporate_entity_id,
    brand_id,
    ship_id,
    department_id,
    service_id,
    revenue_amount,
    booking_date
FROM
    {{ source('raw_data', 'cruise_revenue') }}