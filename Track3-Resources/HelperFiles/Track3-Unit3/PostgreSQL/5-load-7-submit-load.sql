/*
 * Step 3: Submit Data
 * Call the function submit_load to complete the external load and kick off
 * an integration job.
 * If the job fails or need to be canceled, run the cancel_load function.
 * Run as semarchy_repository user.
 */
do
$$

declare
  v_batch_id int;
begin
  v_batch_id := semarchy_repository.submit_load (
	     /* load_id */      /* Load ID returned by get_new_loadid from Step 1 */
	    ,'INTEGRATE_ALL'    /* Must exactly match a defined integration job. Found in MDM Workbench UI. */
	    ,'manual_etl_user'  /* Must exactly match the value used in get_new_loadid in Step 1. */
  );
  raise notice '%', v_batch_id;
end;
$$;
