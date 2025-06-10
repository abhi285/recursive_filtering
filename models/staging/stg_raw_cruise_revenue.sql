-- models/staging/stg_raw_cruise_revenue.sql
{{ config(
    materialized='view'
)}}

SELECT
    booking_id,
    guest_id,
    service_id, -- Only service_id is directly available from raw
    revenue_amount,
    booking_date
FROM
    {{ source('raw_data', 'cruise_revenue') }}