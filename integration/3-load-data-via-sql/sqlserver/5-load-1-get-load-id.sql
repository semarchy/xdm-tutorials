/*
 * Step 1: Get load ID
 * Call the function get_new_loadid to start an external load.
 * Copy the Load ID that is returned. You will need it for the insert.
 * Run as semarchy_repository user. Turn on Dbms Output to see
 * the returned Load ID value.
 */
declare
  @v_load_id int
  begin
   exec semarchy_repository.dbo.get_new_loadid
    @return_value_argument=@v_load_id OUTPUT,
    @p_data_location_name = 'CustomerB2CDemo', /* Data Location Name (as in the UI) */
    @p_program_name = 'manual_etl_script',		/*  Informational. Identifies the Middleware */
    @p_load_description = N'load_data_update',/* Informational. Describes the load. */
    						/* Note the N to allow accented characters */
    @p_username = 'semadmin'		/* User initializing the load. */
    print @v_load_id
end