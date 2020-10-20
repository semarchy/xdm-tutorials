/*
 * Step 3: Cancel Load
 * Call the function CANCEL_LOAD to cancel the external load.
 * You will need to clean up the data in the source table.
 * Run as SEMARCHY_REPOSITORY user.
 */
BEGIN
  SEMARCHY_REPOSITORY.INTEGRATION_LOAD.CANCEL_LOAD (
       /* load_id */          /* Load ID returned by INTEGRATION_LOAD.GET_NEW_LOADID */
      ,'MANUAL_ETL_USER'      /* Must exactly match the value used in GET_NEW_LOADID */
  );
END;
/
