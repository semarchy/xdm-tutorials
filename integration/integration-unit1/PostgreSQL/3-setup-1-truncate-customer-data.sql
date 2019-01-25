/*
 * PostgreSQL truncate statement generation script
 * Semarchy xDM Tutorials
 * Run this script to generate the truncate statements. Copy and paste
 * the output to truncate all tables.
 * Copyright (c) 2018 Semarchy
 */

/*
 * Script to Generate Truncate Table Statements
 * Keep this truncate generation script handy for development time
 */
select 'truncate table semarchy_customer_b2c_mdm.' || tablename || ';'
from pg_catalog.pg_tables
where schemaname = 'semarchy_customer_b2c_mdm' /* set this to your data location schema */
  and tablename not like 'dl_%'                  /* do not truncate these system tables   */
  and tablename not like 'ext_%'                 /* do not truncate these system tables   */
  and tablename like '%'                         /* add filters as needed for entities    */
order by substr(tablename,3), tablename
;
