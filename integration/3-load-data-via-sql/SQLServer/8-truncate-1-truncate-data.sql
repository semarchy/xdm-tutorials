/*
 * SQL Server truncate statement generation script
 * Semarchy xDM Tutorials
 * Run this script to generate the truncate statements. Copy and paste
 * the output to truncate all tables.
 * Copyright (c) 2019 Semarchy
 */

/*
 * Script to Generate Truncate Table Statements
 * Keep this truncate generation script handy for development time
 */
SELECT 'truncate table ' + TABLE_NAME +';' + char(10) + 'go'
FROM SEMARCHY_PRODUCT_RETAIL_MDM.INFORMATION_SCHEMA.TABLES   /* set this to your data location schema */
WHERE TABLE_NAME NOT LIKE 'DL_%'        /* do not truncate these system tables   */
AND   TABLE_NAME NOT LIKE 'EXT_%'       /* do not truncate these system tables   */
AND   TABLE_NAME LIKE '%'               /* add filters as needed for entities    */
ORDER BY SUBSTRING(TABLE_NAME, 1, 3), TABLE_NAME
;
