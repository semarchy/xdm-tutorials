/*
 * Load customer records into the SD_PERSON table with data detection
 * to only load customer records with updated information.
 * Run as the SEMARCHY_CUSTOMER_B2C_MDM user.
 */
INSERT into SEMARCHY_CUSTOMER_B2C_MDM.SD_PERSON (
     B_LOADID      /* Semarchy system fields */
    ,B_CLASSNAME   /* Semarchy system fields */
    ,B_PUBID       /* Semarchy system fields */
    ,B_SOURCEID
    ,FIRST_NAME
    ,LAST_NAME
    ,DATE_OF_BIRTH
    ,ADDSTREET
    ,ADDCITY
    ,ADDSTATE
    ,ADDPOSTAL_CODE
    ,ADDCOUNTRY
    ,SOURCE_EMAIL
    ,SOURCE_PHONE
    ,PERSON_TYPE
    ,VALUE_STATUS
)
SELECT
     SEMARCHY_REPOSITORY.INTEGRATION_LOAD.GET_CONTINUOUS_LOADID('CONTINUOUS_LOAD_INTEGRATE_ALL') as B_LOADID /* Call to get Load ID */
    ,stg.B_CLASSNAME /* Entity name. Found in MDM Workbench UI. */
    ,stg.B_PUBID
    ,stg.B_SOURCEID
    ,stg.FIRST_NAME
    ,stg.LAST_NAME
    ,stg.DATE_OF_BIRTH
    ,stg.ADDSTREET
    ,stg.ADDCITY
    ,stg.ADDSTATE
    ,stg.ADDPOSTAL_CODE
    ,stg.ADDCOUNTRY
    ,stg.SOURCE_EMAIL
    ,stg.SOURCE_PHONE
    ,stg.PERSON_TYPE
    ,stg.VALUE_STATUS
FROM SEMARCHY_STG.SOURCE_PERSON stg
WHERE NOT EXISTS (
  select 1
  from SEMARCHY_CUSTOMER_B2C_MDM.MI_PERSON mi
  where 1=1
    and mi.B_SOURCEID = stg.B_SOURCEID
    and mi.B_PUBID = stg.B_PUBID
    /* duplicate data detection */
    and ( mi.FIRST_NAME = stg.FIRST_NAME or (mi.FIRST_NAME is null and stg.FIRST_NAME is null) )
    and ( mi.LAST_NAME = stg.LAST_NAME or (mi.LAST_NAME is null and stg.LAST_NAME is null) )
    and ( mi.DATE_OF_BIRTH = stg.DATE_OF_BIRTH or (mi.DATE_OF_BIRTH is null and stg.DATE_OF_BIRTH is null) )
    and ( mi.ADDSTREET = stg.ADDSTREET or (mi.ADDSTREET is null and stg.ADDSTREET is null) )
    and ( mi.ADDCITY = stg.ADDCITY or (mi.ADDCITY is null and stg.ADDCITY is null) )
    and ( mi.ADDSTATE = stg.ADDSTATE or (mi.ADDSTATE is null and stg.ADDSTATE is null) )
    and ( mi.ADDCOUNTRY = stg.ADDCOUNTRY or (mi.ADDCOUNTRY is null and stg.ADDCOUNTRY is null) )
    and ( mi.SOURCE_EMAIL = stg.SOURCE_EMAIL or (mi.SOURCE_EMAIL is null and stg.SOURCE_EMAIL is null) )
    and ( mi.SOURCE_PHONE = stg.SOURCE_PHONE or (mi.SOURCE_PHONE is null and stg.SOURCE_PHONE is null) )
    and ( mi.PERSON_TYPE = stg.PERSON_TYPE or (mi.PERSON_TYPE is null and stg.PERSON_TYPE is null) )
    and ( mi.VALUE_STATUS = stg.VALUE_STATUS or (mi.VALUE_STATUS is null and stg.VALUE_STATUS is null) )
);
COMMIT;
