/*
 * Allow SEMARCHY_CUSTOMER_B2C_MDM to select from the SOURCE_PERSON table.
 * Without the grants, the insert will fail due to lack of privileges.
 * Run this grant as the SYSTEM or admin user.
 */
grant SELECT on SEMARCHY_STG.SOURCE_PERSON to SEMARCHY_CUSTOMER_B2C_MDM;
