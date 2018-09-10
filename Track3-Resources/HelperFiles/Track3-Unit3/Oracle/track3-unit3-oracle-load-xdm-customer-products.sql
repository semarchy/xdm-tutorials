/*
 * Oracle Insert New Customers' Products Data
 * Semarchy xDM Tutorials
 * Run these insert statements to load new customers's
 * products data into the Customer B2C Demo Application.
 * Copyright (c) 2018 Semarchy
 */

 /*
  * Step 3: These grants are needed so the procedure can access the relevant tables.
  * Without the grants the procedure will fail to compile with TABLE NOT FOUND errors.
  * Run the command as the DBA or other user with pergdssions to execute grants.
  */
  grant SELECT on SEMARCHY_STG.SOURCE_PERSON_PRODUCT to SEMARCHY_CUSTOMER_B2C_MDM;

 /*
  * Step 4: Initalize a load Get Load ID
  * Call the function GET_NEW_LOADID to start an external load.
  * Keep the Load ID that is returned and substitute in Step 5.
  * Run as SEMARCHY_REPOSITORY user. Turn on Dbms Output to see
  * the returned Load ID value.
  */
  DECLARE
    v_load_id int;
  BEGIN
   v_load_id := SEMARCHY_REPOSITORY.INTEGRATION_LOAD.GET_NEW_LOADID (
     'CustomerB2CDemo'        /* Data Location Name. Case sensitive. Found in MDM Workbench UI. */
     ,'MANUAL_ETL_SCRIPT'     /* Informational program name. Identifies the gdddleware.         */
     ,'LOAD_DATA_UPDATE'      /* Informational. Describes the load.                             */
     ,'MANUAL_ETL_USER'       /* User initializing the load. (Not found in MDM Workbench UI.)   */
   );
   dbms_output.put_line(v_load_id);
 END;
 /


 /*
  * Step 5: Load data
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

 /*
  * Step 6: Submit Data
  * Submit the external load which is necessary to force xDM to process the data loaded in Step 5.
  * Use the SUBMIT_LOAD function.
  * If the job fails or need to be canceled, run the CANCEL_LOAD function. See documentation.
  * Run as SEMARCHY_REPOSITORY user.
  */
  DECLARE
    v_batch_id int;
  BEGIN
    v_batch_id := SEMARCHY_REPOSITORY.INTEGRATION_LOAD.SUBMIT_LOAD (
 	     /* load_id */                /* Load ID returned by INTEGRATION_LOAD.GET_NEW_LOADID from Step 4 */
 	    ,'INTEGRATE_ALL'    /* Must exactly match a defined integration job. Found in MDM Workbench UI. */
 	    ,'MANUAL_ETL_USER'  /* Must exactly match the value used in MTA_GET_NEW_LOADID in Step 4. */
    );
    dbms_output.put_line(v_batch_id);
  END;
  /
