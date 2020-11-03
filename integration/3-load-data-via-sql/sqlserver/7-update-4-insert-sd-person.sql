/*
 * Load customer records into the sd_person table with data detection
 * to only load customer records with updated information.
 * Run as the semarchy_customer_b2c_mdm user.
 */
declare
	@v_load_id int
begin
	/* The continuous load id has to be retrieved out of the select statement
     * Its value is stored in the @v_load_id
     */
    exec semarchy_repository.dbo.get_continuous_loadid
		@RETURN_VALUE_ARGUMENT=@v_load_id OUTPUT, 
		@P_CONTINUOUS_LOAD_NAME='CONTINUOUS_LOAD_INTEGRATE_ALL'

    use semarchy_customer_b2c_mdm
    insert into semarchy_customer_b2c_mdm.dbo.sd_person (
        b_loadid      /* Semarchy system fields */
        ,b_classname   /* Semarchy system fields */
        ,b_pubid       /* Semarchy system fields */
        ,b_sourceid
        ,first_name
        ,last_name
        ,date_of_birth
        ,addstreet
        ,addcity
        ,addstate
        ,addpostal_code
        ,addcountry
        ,source_email
        ,source_phone
        ,person_type
        ,value_status
    )
    select
        @v_load_id
        ,stg.b_classname /* Entity name. Found in MDM Workbench UI. */
        ,stg.b_pubid
        ,stg.b_sourceid
        ,stg.first_name
        ,stg.last_name
        ,stg.date_of_birth
        ,stg.addstreet
        ,stg.addcity
        ,stg.addstate
        ,stg.addpostal_code
        ,stg.addcountry
        ,stg.source_email
        ,stg.source_phone
        ,stg.person_type
        ,stg.value_status
    from semarchy_stg.dbo.source_person stg
    where not exists (
        select 1
        from semarchy_customer_b2c_mdm.dbo.mi_person mi
        where mi.b_sourceid = stg.b_sourceid
            and mi.b_pubid = stg.b_pubid
            /* duplicate data detection */
            and ( mi.first_name = stg.first_name or (mi.first_name is null and stg.first_name is null) )
            and ( mi.last_name = stg.last_name or (mi.last_name is null and stg.last_name is null) )
            and ( mi.date_of_birth = stg.date_of_birth or (mi.date_of_birth is null and stg.date_of_birth is null) )
            and ( mi.addstreet = stg.addstreet or (mi.addstreet is null and stg.addstreet is null) )
            and ( mi.addcity = stg.addcity or (mi.addcity is null and stg.addcity is null) )
            and ( mi.addstate = stg.addstate or (mi.addstate is null and stg.addstate is null) )
            and ( mi.addcountry = stg.addcountry or (mi.addcountry is null and stg.addcountry is null) )
            and ( mi.source_email = stg.source_email or (mi.source_email is null and stg.source_email is null) )
            and ( mi.source_phone = stg.source_phone or (mi.source_phone is null and stg.source_phone is null) )
            and ( mi.person_type = stg.person_type or (mi.person_type is null and stg.person_type is null) )
            and ( mi.value_status = stg.value_status or (mi.value_status is null and stg.value_status is null) )
    )
end
