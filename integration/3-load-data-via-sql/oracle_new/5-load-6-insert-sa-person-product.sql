/*
 * Step 2: Load Data
 * Insert the Customers' Products Data Statements with delta detection.
 * Load the SA table because PersonProduct is a basic entity.
 * Run as SEMARCHY_CUSTOMER_B2C_MDM user.
 */
INSERT into SEMARCHY_CUSTOMER_B2C_MDM.SA_PERSON_PRODUCT (
     B_LOADID      /* Semarchy system fields */
    ,B_CLASSNAME   /* Semarchy system fields */
    ,ID
    ,PURCHASE_DATE
    ,REGISTRATION_DATE
    ,F_PRODUCT
    ,FP_PERSON
    ,FS_PERSON
)
SELECT
     /* load_id */ as B_LOADID    /* Insert the load ID here that was returned from Step 4 */
    ,stg.B_CLASSNAME /* Entity name. Found in MDM Workbench UI. */
    ,stg.ID
    ,stg.PURCHASE_DATE
    ,stg.REGISTRATION_DATE
    ,stg.F_PRODUCT
    ,stg.FP_PERSON
    ,stg.FS_PERSON
 FROM SEMARCHY_STG.SOURCE_PERSON_PRODUCT stg
 WHERE NOT EXISTS (
   SELECT 1
   FROM SEMARCHY_CUSTOMER_B2C_MDM.GD_PERSON_PRODUCT gd
   WHERE 1=1
     /* match on IDs */
     AND gd.ID = stg.ID
     /* duplicate data detection */
     and ( gd.PURCHASE_DATE = stg.PURCHASE_DATE or (gd.PURCHASE_DATE is null and stg.PURCHASE_DATE is null) )
     and ( gd.REGISTRATION_DATE = stg.REGISTRATION_DATE or (gd.REGISTRATION_DATE is null and stg.REGISTRATION_DATE is null) )
     and ( gd.F_PRODUCT = stg.F_PRODUCT or (gd.F_PRODUCT is null and stg.F_PRODUCT is null) )
     and ( gd.FP_PERSON = stg.FP_PERSON or (gd.FP_PERSON is null and stg.FP_PERSON is null) )
     and ( gd.FS_PERSON = stg.FS_PERSON or (gd.FS_PERSON is null and stg.FS_PERSON is null) )
 );
 COMMIT;
