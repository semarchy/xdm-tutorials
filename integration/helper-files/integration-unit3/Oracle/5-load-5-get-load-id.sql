/*
 * Step 1: Get load ID
 * Call the function GET_NEW_LOADID to start an external load.
 * Copy the Load ID that is returned. You will need it for the insert.
 * Run as SEMARCHY_REPOSITORY user. Turn on Dbms Output to see
 * the returned Load ID value.
 */
DECLARE
  v_load_id int;
  BEGIN
   v_load_id := SEMARCHY_REPOSITORY.INTEGRATION_LOAD.GET_NEW_LOADID (
        'CustomerB2CDemo'       /* Data Location Name. Case sensitive. Found in MDM Workbench UI. */
       ,'MANUAL_ETL_SCRIPT'     /* Informational program name. Identifies the middleware.         */
       ,'LOAD_DATA_UPDATE'      /* Informational. Describes the load.                             */
       ,'MANUAL_ETL_USER'       /* User initializing the load. (Not found in MDM Workbench UI.)   */
   );
   dbms_output.put_line(v_load_id);
END;
/
