/*
 * Step 3: Submit Data
 * Call the function SUBMIT_LOAD to complete the external load and kick off
 * an integration job.
 * If the job fails or need to be canceled, run the CANCEL_LOAD function.
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
