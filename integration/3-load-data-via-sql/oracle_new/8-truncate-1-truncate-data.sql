/*
 * Oracle truncate statement generation script
 * Semarchy xDM Tutorials
 * Run this script to generate the truncate statements.
 * Copy and paste the output to truncate all tables.
 * Copyright (c) 2018 Semarchy
 */

/*
 * Script to Generate Truncate Table Statements
 * Keep this truncate generation script handy for development time
 */
select 'truncate table SEMARCHY_CUSTOMER_B2C_MDM.' || table_name || ';'
from all_tables
where owner='SEMARCHY_CUSTOMER_B2C_MDM'  /* set this to your data location schema */
  and table_name not like 'DL_%'     /* do not truncate these system tables   */
  and table_name not like 'EXT_%'    /* do not truncate these system tables   */
  and table_name like '%'            /* add filters as needed for entities    */
order by substr(table_name,3), table_name;
