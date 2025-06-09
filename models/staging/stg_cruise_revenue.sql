-- models/staging/stg_cruise_revenue.sql
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
FROM {{ source('nclh_raw_data', 'RAW_CRUISE_REVENUE') }}