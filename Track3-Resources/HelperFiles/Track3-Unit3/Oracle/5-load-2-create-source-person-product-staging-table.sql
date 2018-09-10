/*
 * Create a staging table, SOURCE_PERSON_PRODUCT,
 * in the staging schema SEMARCHY_STG.
 * Run as SEMARCHY_STG user.
 */
CREATE TABLE SEMARCHY_STG.SOURCE_PERSON_PRODUCT (
     B_CLASSNAME varchar(128)
    ,ID varchar(128)
    ,PURCHASE_DATE date
    ,REGISTRATION_DATE date
    ,F_PRODUCT varchar(128)
    ,FP_PERSON varchar(128)
    ,FS_PERSON varchar(128)
)
;
