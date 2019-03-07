** xxxxxxxxxxxxxxxx helper file
** Semarchy xDM Tutorials  
** Copy and paste the SemQL Expressions and use them in the tutorial.
** Copyright (c) 2018 Semarchy
********************************************************************************

/* Truncate the company tables in order to test a fresh reload of data. */
  select 'truncate table semarchy_b2b_tutorial.' || tablename || ';' generated_statements
    from pg_catalog.pg_tables 
   where schemaname = 'semarchy_b2b_tutorial' 
     and tablename not like 'dl_%'      /* Do not truncate any data location system tables. */
     and tablename ilike '%company'     /* ilike performs a case-insensitive comparison.    */
order by substr(tablename,3), tablename
;

