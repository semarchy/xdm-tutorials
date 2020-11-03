/*
 * Create a staging table, SOURCE_PERSON_PRODUCT,
 * in the staging schema SEMARCHY_STG.
 * Run as SEMARCHY_STG user.
 */
create table semarchy_stg.source_person_product (
     b_classname varchar(128)
    ,id varchar(128)
    ,purchase_date date
    ,registration_date date
    ,f_product varchar(128)
    ,fp_person varchar(128)
    ,fs_person varchar(128)
)
;
