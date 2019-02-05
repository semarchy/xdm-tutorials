/*
 * Error Queries
 * Semarchy xDM Tutorials
 * Run these select statements to query data
 * in the Customer B2C Demo Application.
 * Copyright (c) 2018 Semarchy
 */

/*
 * Query 1: source error table
 */
SELECT  *
FROM    se_person
;

/*
 * Query 2: source data table filtering on errors
 */
SELECT  *
FROM    sd_person
WHERE   b_error_status = 'ERROR'
;

/*
 * Query 3: the source data and error tables to see
 * the customer information and reason for error
 */
SELECT
   se.b_batchid,
   sd.b_loadid,
   se.b_constraintname,
   se.b_constrainttype,
   se.b_pubid,
   se.b_sourceid,
   sd.first_name,
   sd.last_name,
   sd.source_email
FROM se_person se
INNER JOIN sd_person sd ON (
       sd.b_pubid = se.b_pubid
   AND sd.b_sourceid = se.b_sourceid
   AND sd.b_loadid = se.b_loadid
)
WHERE   sd.b_error_status = 'ERROR'
;
