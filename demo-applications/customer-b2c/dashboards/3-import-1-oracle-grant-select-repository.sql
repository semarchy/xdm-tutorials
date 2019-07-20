/*
 * Allow read access to SEMARCHY_REPOSITORY tables 
 * Without the grants, the Integration Metrics Dashboards fail due to lack of privileges.
 * Run grant as the DBA user
 */
GRANT SELECT ANY TABLE;