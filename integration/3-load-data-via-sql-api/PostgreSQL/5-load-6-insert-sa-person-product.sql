/*
 * Step 2: Load Data
 * Insert the Customers' Products Data Statements with delta detection.
 * Load the SA table because PersonProduct is a basic entity.
 * Run as semarchy_customer_b2c_mdm user.
 */
insert into semarchy_customer_b2c_mdm.sa_person_product (
     b_loadid      /* Semarchy system fields */
    ,b_classname   /* Semarchy system fields */
    ,id
    ,purchase_date
    ,registration_date
    ,f_product
    ,fp_person
    ,fs_person
)
select
     /* load_id */ as b_loadid    /* Insert the load ID here that was returned from Step 1 */
    ,stg.b_classname /* Entity name. Found in MDM Workbench UI. */
    ,stg.id
    ,stg.purchase_date
    ,stg.registration_date
    ,stg.f_product
    ,stg.fp_person
    ,stg.fs_person
 from semarchy_stg.source_person_product stg
 where not exists (
   select 1
   from semarchy_customer_b2c_mdm.gd_person_product gd
   where /* match on IDs */
         gd.id = stg.id
     /* duplicate data detection */
     and ( gd.purchase_date = stg.purchase_date or (gd.purchase_date is null and stg.purchase_date is null) )
     and ( gd.registration_date = stg.registration_date or (gd.registration_date is null and stg.registration_date is null) )
     and ( gd.f_product = stg.f_product or (gd.f_product is null and stg.f_product is null) )
     and ( gd.fp_person = stg.fp_person or (gd.fp_person is null and stg.fp_person is null) )
     and ( gd.fs_person = stg.fs_person or (gd.fs_person is null and stg.fs_person is null) )
 );
commit;
