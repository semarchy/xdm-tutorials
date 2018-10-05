/*
 * Step 3: Cancel Load
 * Call the function cancel_load to cancel the external load.
 * You will need to clean up the data in the source table.
 * Run as semarchy_repository user.
 */
do
$$

begin
  perform semarchy_repository.cancel_load (
       /* load_id */          /* Load ID returned by get_new_loadid */
      ,'manual_etl_user'      /* Must exactly match the value used in get_new_loadid */
  );
end;
$$;
