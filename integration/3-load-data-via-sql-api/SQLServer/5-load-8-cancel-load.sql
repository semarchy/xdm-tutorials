/*
 * Step 3: Cancel Load
 * Call the function cancel_load to cancel the external load.
 * You will need to clean up the data in the source table.
 * Run as semarchy_repository user.
 */

begin
  exec semarchy_repository.dbo.cancel_load
    @P_LOAD_ID = /* load_id */    /* Load ID returned by INTEGRATION_LOAD.GET_NEW_LOADID */
    ,@P_USERNAME = 'semadmin'     /* User who has initialized the load. */
end

