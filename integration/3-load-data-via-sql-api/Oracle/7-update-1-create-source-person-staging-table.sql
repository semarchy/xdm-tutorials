/*
 * Create a staging table, SOURCE_PERSON,
 * in the staging schema, SEMARCHY_STG.
 */
CREATE TABLE SEMARCHY_STG.SOURCE_PERSON (
     B_CLASSNAME varchar(128)
    ,B_PUBID varchar(128)
    ,B_SOURCEID varchar(128)
    ,FIRST_NAME varchar(128)
    ,LAST_NAME varchar(128)
    ,DATE_OF_BIRTH date
    ,ADDSTREET varchar(128)
    ,ADDCITY varchar(128)
    ,ADDSTATE varchar(128)
    ,ADDPOSTAL_CODE varchar(128)
    ,ADDCOUNTRY varchar(128)
    ,SOURCE_EMAIL varchar(128)
    ,SOURCE_PHONE varchar(128)
    ,PERSON_TYPE varchar(128)
    ,VALUE_STATUS varchar(128)
)
;
