/*
 * Allow read access to SEMARCHY_REPOSITORY tables to SEMARCHY_PRODUCT_RETAIL_MDM 
 * Without the grants, the Integration Metrics Dashboards fail due to lack of privileges.
 * Run grant as the DBA user
 */
GRANT SELECT ON SCHEMA :: SEMARCHY_REPOSITORY TO SEMARCHY_PRODUCT_RETAIL_MDM;
