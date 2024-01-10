/*
 * Step 2: Load Data
 * Insert the Customers' Products Data Statements with delta detection.
 * Load the SA table because PersonProduct is a basic entity.
 * Run as semarchy_customer_b2c_mdm user.
 */
INSERT INTO semarchy_customer_b2c_mdm.sa_person_product (
    b_loadid,       /* Semarchy system fields */
    b_classname,    /* Semarchy system fields */
    id,
    purchase_date,
    registration_date,
    f_product,
    fp_person,
    fs_person
)
SELECT
    /* load_id */ AS b_loadid,  /* Insert the load ID here that was returned from Step 1 */
    'PersonProduct' AS b_classname,            /* Entity name. Found in MDM Workbench UI. */
    stg.id,
    stg.purchase_date,
    stg.registration_date,
    stg.f_product,
    stg.fp_person,
    stg.fs_person
FROM semarchy_customer_b2c_mdm.sa_person_product dest
RIGHT JOIN (
    VALUES 
		('FORCEP24461WD_CRM1353638', to_date('06/23/2018', 'MM-DD-YYYY'), to_date('07/13/2018', 'MM-DD-YYYY'), 'FORCEP24461WD', 'CRM', '1353638'),
		('FORCEP24461WD_CRM1388894', to_date('02/10/2016', 'MM-DD-YYYY'), to_date('04/02/2016', 'MM-DD-YYYY'), 'FORCEP24461WD', 'CRM', '1388894'),
		('CARBON4861OK_CRM1987232', to_date('12/19/2016', 'MM-DD-YYYY'), to_date('03/20/2017', 'MM-DD-YYYY'), 'CARBON4861OK', 'CRM', '1987232'),
		('CARBON4861OK_CRM1373036', to_date('04/28/2014', 'MM-DD-YYYY'), to_date('06/22/2014', 'MM-DD-YYYY'), 'CARBON4861OK', 'CRM', '1373036'),
		('CARBON4861OK_CRM1380327', to_date('01/17/2016', 'MM-DD-YYYY'), to_date('04/26/2016', 'MM-DD-YYYY'), 'CARBON4861OK', 'CRM', '1380327'),
		('CARBON4861OK_CRM1385755', to_date('04/23/2015', 'MM-DD-YYYY'), to_date('06/12/2015', 'MM-DD-YYYY'), 'CARBON4861OK', 'CRM', '1385755'),
		('CARBON4861OK_CRM1391755', to_date('05/23/2016', 'MM-DD-YYYY'), to_date('08/02/2016', 'MM-DD-YYYY'), 'CARBON4861OK', 'CRM', '1391755'),
		('CARBON4861OK_MKT1387232', to_date('02/16/2016', 'MM-DD-YYYY'), to_date('05/21/2016', 'MM-DD-YYYY'), 'CARBON4861OK', 'MKT', '1387232'),
		('CARBON4861OK_MKT1388559', to_date('08/30/2015', 'MM-DD-YYYY'), to_date('11/22/2015', 'MM-DD-YYYY'), 'CARBON4861OK', 'MKT', '1388559'),
		('RENAUD4061LK_CRM1376827', to_date('06/02/2018', 'MM-DD-YYYY'), to_date('07/13/2018', 'MM-DD-YYYY'), 'RENAUD4061LK', 'CRM', '1376827'),
		('STREAM4961WD_CRM1353638', to_date('09/19/2014', 'MM-DD-YYYY'), to_date('12/21/2014', 'MM-DD-YYYY'), 'STREAM4961WD', 'CRM', '1353638')
) AS stg(id, purchase_date, registration_date, f_product, fp_person, fs_person)
ON dest.id = stg.id
WHERE dest.id IS NULL OR (
    dest.purchase_date <> stg.purchase_date
    OR dest.registration_date <> stg.registration_date
    OR COALESCE(dest.f_product, '') <> COALESCE(stg.f_product, '')
    OR COALESCE(dest.fp_person, '') <> COALESCE(stg.fp_person, '')
    OR COALESCE(dest.fs_person, '') <> COALESCE(stg.fs_person, '')
);

COMMIT;