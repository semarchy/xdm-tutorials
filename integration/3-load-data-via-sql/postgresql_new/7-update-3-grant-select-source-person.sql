/*
 * Allow semarchy_customer_b2c_mdm to select from the source_person table.
 * Without the grants, the insert will fail due to lack of privileges.
 * Run this grant as the postgres or admin user.
 */
grant select on semarchy_stg.source_person to semarchy_customer_b2c_mdm;
