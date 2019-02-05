/*
 * Advanced Queries
 * Semarchy xDM Tutorials
 * Run these select statements to query data
 * in the Customer B2C Demo Application.
 * Copyright (c) 2018 Semarchy
 */

/*
 * Query golden customers and their products
 */
SELECT
    pe.id,
    pe.first_name,
    pe.last_name,
    pr.product_name
FROM gd_person pe
    INNER JOIN gd_person_product pp ON pe.id = pp.f_person
    INNER JOIN gd_product pr ON pr.id = pp.f_product
;


/*
 * Side-by-side comparison of a selected master record's duplicates and corresponding golden record
 */
SELECT
   md.b_pubid dup1_publisher,
   md.b_sourceid dup1_id,
   md.first_name dup1_first_name,
   md.last_name dup1_last_name,
   md2.b_pubid dup2_publisher,
   md2.b_sourceid dup2_id,
   md2.first_name dup2_first_name,
   md2.last_name dup2_last_name,
   gd.id gold_id,
   gd.first_name gold_fist_name,
   gd.last_name gold_last_name
FROM md_person md
   INNER JOIN gd_person gd ON (
           gd.id = md.id
   )
   INNER JOIN md_person md2 ON (
           md.id = md2.id
   )
WHERE   md.b_pubid = 'CRM'           /* Publisher ID */
   AND md.b_sourceid = '1419728'    /* Source ID */
/* AND md.b_pubid = md2.b_pubid */   /* Uncomment the previous line to restrict the duplicates to those within the CRM application */
;
