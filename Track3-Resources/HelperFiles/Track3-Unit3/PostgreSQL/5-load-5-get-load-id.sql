/*
 * Step 1: Get load ID
 * Call the function get_new_loadid to start an external load.
 * Copy the Load ID that is returned. You will need it for the insert.
 * Run as semarchy_repository user. Turn on Dbms Output to see
 * the returned Load ID value.
 */
do
$$

declare
  v_load_id int;
  begin
    v_load_id := semarchy_repository.get_new_loadid (
         'CustomerB2CDemo'       /* Data Location name. case sensitive. Found in MDM workbench UI. */
        ,'manual_etl_script'     /* Informational program name. Identifies the middleware.         */
        ,'load_data_update'      /* Informational. Describes the load.                             */
        ,'manual_etl_user'       /* User initializing the load. (Not found in MDM workbench UI.)   */
    );
    raise notice '%', v_load_id;
end;
$$ language plpgsql;
