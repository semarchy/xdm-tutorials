/*
 * Allow SEMARCHY_CUSTOMER_B2C_MDM to select from the SOURCE_PERSON_PRODUCT.
 * Without the grants, the insert will fail due to lack of privileges.
 * Run this grant as the SYSTEM or admin user.
 */
use semarchy_stg;
grant select on dbo.source_person_product to semarchy_customer_b2c_mdm;