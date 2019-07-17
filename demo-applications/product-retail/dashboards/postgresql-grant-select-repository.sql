/*
 * Allow read access to SEMARCHY_REPOSITORY tables to everyone 
 * Without the grants, the Integration Metrics Dashboards fail due to lack of privileges.
 * Run grant as the DBA user
 */
GRANT USAGE ON SCHEMA semarchy_repository TO public ;
GRANT SELECT ON ALL TABLES IN SCHEMA semarchy_repository TO public ;
