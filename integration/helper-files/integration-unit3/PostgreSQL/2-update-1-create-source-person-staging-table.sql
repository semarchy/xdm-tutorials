/*
 * Create a staging table, source_person,
 * in the staging schema, semarchy_stg.
 */
create table semarchy_stg.source_person (
     b_classname varchar(128)
    ,b_pubid varchar(128)
    ,b_sourceid varchar(128)
    ,first_name varchar(128)
    ,last_name varchar(128)
    ,date_of_birth date
    ,addstreet varchar(128)
    ,addcity varchar(128)
    ,addstate varchar(128)
    ,addpostal_code varchar(128)
    ,addcountry varchar(128)
    ,source_email varchar(128)
    ,source_phone varchar(128)
    ,person_type varchar(128)
    ,value_status varchar(128)
)
;
