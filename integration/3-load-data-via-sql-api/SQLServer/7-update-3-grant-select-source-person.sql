/*
 * Allow semarchy_customer_b2c_mdm to select from the source_person table.
 * Without the grants, the insert will fail due to lack of privileges.
 * Run this grant as the postgres or admin user.
 */
use semarchy_stg;
grant select on dbo.source_person to semarchy_customer_b2c_mdm;
