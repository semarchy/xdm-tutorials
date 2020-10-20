/*
 * Create a staging table, source_person_product,
 * in the staging schema semarchy_stg.
 * Run as semarchy_stg user.
 */
create table semarchy_stg.dbo.source_person_product (
     b_classname varchar(128)
    ,id varchar(128)
    ,purchase_date date
    ,registration_date date
    ,f_product varchar(128)
    ,fp_person varchar(128)
    ,fs_person varchar(128)
)
;

