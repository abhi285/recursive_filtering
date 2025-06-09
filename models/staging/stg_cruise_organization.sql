-- models/staging/stg_cruise_organization.sql
SELECT
    corporate_entity,
    brand_name,
    ship_name,
    department_name,
    service_name
FROM {{ source('nclh_raw_data', 'RAW_CRUISE_ORGANIZATION') }}