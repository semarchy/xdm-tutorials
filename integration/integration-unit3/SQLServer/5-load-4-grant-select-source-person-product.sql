/*
 * Allow SEMARCHY_CUSTOMER_B2C_MDM to select from the SOURCE_PERSON_PRODUCT.
 * Without the grants, the insert will fail due to lack of privileges.
 * Run this grant as the SYSTEM or admin user.
 */
grant select SOURCE_PERSON_PRODUCT to SEMARCHY_CUSTOMER_B2C_MDM;
