/*
 * Basic Queries
 * Semarchy xDM Tutorials
 * Run these select statements to query data
 * in the Customer B2C Demo Application.
 * Copyright (c) 2018 Semarchy
 */

/*
 * Query 1: golden customer data
 */
SELECT
    gd.*
FROM
    gd_person gd;

SELECT
    gd.id,
    gd.first_name,
    gd.last_name
FROM
    gd_person gd;

/*
 * Query 2: master and golden customer data side-by-side
 */

SELECT
    md.b_pubid,
    md.b_sourceid,
    md.first_name,
    md.last_name,
    gd.id,
    gd.first_name,
    gd.last_name
FROM
    md_person md
    INNER JOIN gd_person gd ON gd.id = md.id
ORDER BY gd.id ASC;

/*
 * Query 3: golden customer data with a given source ID
 */

SELECT
    md.b_pubid,
    md.b_sourceid,
    md.first_name,
    md.last_name,
    gd.id,
    gd.first_name,
    gd.last_name
FROM
    md_person md
    INNER JOIN gd_person gd ON (
        gd.id = md.id
    )
WHERE
        md.b_pubid = 'CRM'
    AND
        md.b_sourceid = '1483060';
