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
    ,stg.b_pubid
    ,stg.b_sourceid
    ,stg.first_name
    ,stg.last_name
    ,stg.date_of_birth
    ,stg.addstreet
    ,stg.addcity
    ,stg.addstate
    ,stg.addpostal_code
    ,stg.addcountry
    ,stg.source_email
    ,stg.source_phone
    ,stg.person_type
    ,stg.value_status
from semarchy_stg.source_person stg
where not exists (
  select 1
  from semarchy_customer_b2c_mdm.mi_person mi
  where mi.b_sourceid = stg.b_sourceid
    and mi.b_pubid = stg.b_pubid
    /* duplicate data detection */
    and ( mi.first_name = stg.first_name or (mi.first_name is null and stg.first_name is null) )
    and ( mi.last_name = stg.last_name or (mi.last_name is null and stg.last_name is null) )
    and ( mi.date_of_birth = stg.date_of_birth or (mi.date_of_birth is null and stg.date_of_birth is null) )
    and ( mi.addstreet = stg.addstreet or (mi.addstreet is null and stg.addstreet is null) )
    and ( mi.addcity = stg.addcity or (mi.addcity is null and stg.addcity is null) )
    and ( mi.addstate = stg.addstate or (mi.addstate is null and stg.addstate is null) )
    and ( mi.addcountry = stg.addcountry or (mi.addcountry is null and stg.addcountry is null) )
    and ( mi.source_email = stg.source_email or (mi.source_email is null and stg.source_email is null) )
    and ( mi.source_phone = stg.source_phone or (mi.source_phone is null and stg.source_phone is null) )
    and ( mi.person_type = stg.person_type or (mi.person_type is null and stg.person_type is null) )
    and ( mi.value_status = stg.value_status or (mi.value_status is null and stg.value_status is null) )
);
COMMIT;
