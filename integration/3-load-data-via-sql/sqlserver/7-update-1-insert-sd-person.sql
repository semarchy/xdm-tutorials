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
        ,'Person' AS b_classname /* Entity name. Found in MDM Workbench UI. */
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
    from 
    (
        values
            ('CRM', '1123060', 'Mary-Ann', 'Markes', convert(date, '11/18/1993', 101), '1200 Summer St #-103', 'Stamford', 'CT', '06905', 'US', 'maryann@markes.com', '203-967-5612', 'CUSTOMER', 'HIGH'),
            ('CRM', '1313060', 'Mary-ann', 'Markes', convert(date, '11/18/1993', 101), '1200 Summer St #-103', 'Stamford', 'CT', '06905', 'US', 'maryann@markes.com', '203-967-5612', 'CUSTOMER', 'HIGH'),
            ('CRM', '1316294', 'Rey', 'Amason', convert(date, '12/16/1975', 101), '3 Depot St', 'Wapakoneta', 'OH', '45665', 'US', 'rey@amason.com', '419 738 9241', 'CUSTOMER', 'HIGH'),
            ('CRM', '1320830', 'Jass', 'Ellerbusch', convert(date, '12/11/1991', 101), '73 S Hamilton Ave', 'Doylestown', 'PA', '18901', 'US', 'jass@ellerbusch.com', '215-348-5078', 'PROSPECT', NULL),
            ('CRM', '1326294', 'Ray', 'Amason', convert(date, '12/16/1975', 101), '3 Depot St', 'Wapakoneta', 'OH', '45665', 'US', 'rey@amason.com', '419-738-9241', 'CUSTOMER', 'HIGH'),
            ('CRM', '1333590', 'John', 'Edelman', convert(date, '09/03/1976', 101), '591 Redwood Hwy #-1200', 'Mill Valley', 'CA', '94941', 'US', 'john@jedelman.com', '415.381.9176', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1333591', 'John', 'Edelman', convert(date, '09/03/1976', 101), '591 Redwood Hwy #-1200', 'Mill Valley', 'CA', '94941', 'US', 'john@jedelman.com', '415-381-9176', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1334125', 'Jasmine', 'Ellerbusch', convert(date, '12/11/1991', 101), '73 S Hamilton Ave', 'Doylestown', 'PA', '18901', 'US', 'jass@ellerbusch.com', '215-348-5078', 'PROSPECT', NULL),
            ('CRM', '1336294', 'Ray', 'Amason', convert(date, '12/16/1975', 101), '3 Depot St', 'Wapakoneta', 'OH', '45665', 'US', 'ray@amason.com', '419.738.9241', 'CUSTOMER', 'HIGH'),
            ('CRM', '1350076', 'Federico', 'Popp', convert(date, '04/30/1983', 101), '419 N Cascade Ave', 'Colorado Springs', 'CO', '60603', 'US', 'federico@popp.com', '719-635-5347', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1350480', 'Quinn', 'Mitchen', convert(date, '01/12/1992', 101), '67616 Desert View Ave', 'Desert Hot Springs', 'CA', '62240', 'US', 'quinn@mitchen.com', '760-329-3382', 'PROSPECT', NULL),
            ('CRM', '1351779', 'Lyman', 'Wengel', convert(date, '01/02/1986', 101), '1225 17th St', 'Denver', 'CO', '60202', 'US', 'lyman@wengel.com', '303-292-4338', 'PROSPECT', NULL),
            ('CRM', '1352226', 'Lucinda', 'Clingingsmith', convert(date, '03/18/1993', 101), '91195 Hanua St', 'Kapolei', 'HI', '68707', 'US', 'lucy@clingingsmith.com', '808-682-3122', 'PROSPECT', NULL),
            ('CRM', '1352415', 'Tuan', 'Corbett', convert(date, '11/09/1992', 101), '16 Maple St', 'Mechanic Falls', 'ME', '04258', 'US', 'tuan@corbett.com', '207-345-7845', 'PROSPECT', NULL),
            ('CRM', '1352961', 'Harry', 'Elbers', convert(date, '11/17/1995', 101), '106 T St', 'Eureka', 'CA', '65501', 'US', 'harold@elbers.com', '707-442-1642', 'PROSPECT', NULL),
            ('CRM', '1353445', 'Vernice', 'Southwood', convert(date, '10/22/1987', 101), '8 Commercial Blvd', 'Medford', 'NY', '11783', 'US', 'vernice@southwood.com', '631-698-8293', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1353638', 'Winnie', 'Gouker', convert(date, '08/17/1986', 101), 'Glaize Shopping', 'Osage Beach', 'MO', '85085', 'US', NULL, '573-348-0827', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1353672', 'Angelica', 'Aldaba', convert(date, '11/23/1986', 101), '1427 Nw Davis St', 'Portland', 'OR', '67206', 'US', 'angelica@aldaba.com', '503-228-3027', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1353814', 'Ross', 'Taulman', convert(date, '11/06/1978', 101), '1201 3rd Ave #-3400', 'Seattle', 'WA', '66101', 'US', 'roscoe@taulman.com', '206-682-4857', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1355424', 'Liza', 'Assante', convert(date, '12/03/1981', 101), '8589 Darrow Rd', 'Twinsburg', 'OH', '44067', 'US', 'liza@assante.com', '330-425-7382', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1355739', 'Weldon', 'Odegard', convert(date, '08/07/1985', 101), '6822 Academy Parkway W', 'Albuquerque', 'NM', '67106', 'US', 'weldon@odegard.com', '505-345-1780', 'PROSPECT', NULL),
            ('CRM', '1356431', 'Dino', 'Mitchen', convert(date, '01/11/1983', 101), '400 N Pennsylvania Ave #-500', 'Roswell', 'NM', '66201', 'US', 'dino@mitchen.com', '505-622-3923', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1356506', 'Katharine', 'Sankar', convert(date, '02/09/1977', 101), '5122 Lewis Ave', 'Toledo', 'OH', '43812', 'US', 'katharine@sankar.com', '419-476-7118', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1356510', 'Faye', 'Mcgrue', convert(date, '06/13/1983', 101), '1120 20th St Nw', 'Washington', 'DC', '20038', 'US', 'faye@mcgrue.com', '202-962-9236', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1357165', 'Caroline', 'LaPalme', convert(date, '05/22/1990', 101), '4910 Departure Drive', 'Raleigh', 'NC', '27804', 'US', 'carol.lapalme@yahoo.com', '919-876-7612', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1358759', 'Colton', 'Rave', convert(date, '01/19/1973', 101), '1644 N Honore St', 'Chicago', 'IL', '80822', 'US', 'colton@rave.com', '773-486-5500', 'CUSTOMER', NULL),
            ('CRM', '1359465', 'Leif', 'Defiguero', convert(date, '02/23/1992', 101), '4097 W Ramsey St', 'Banning', 'CA', '62220', 'US', 'leif@defiguero.com', '951-849-6891', 'PROSPECT', NULL),
            ('CRM', '1361292', 'Virgie', 'Geuder', convert(date, '09/05/1980', 101), '1922 S Laredo St', 'San Antonio', 'TX', '76207', 'US', 'virgie@geuder.com', '210-224-1698', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1363457', 'Zay', 'Hendel', convert(date, '08/01/1979', 101), '2332 E Division St', 'Springfield', 'MO', NULL, 'US', 'isaiah@hendel.com', '417-864-1286', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1363595', 'Nola', 'Girvan', convert(date, '04/10/1980', 101), '1620 Paonia St', 'Colorado Springs', 'CO', NULL, 'US', 'nola@girvan.com', '719-574-6245', 'PROSPECT', NULL),
            ('CRM', '1365204', 'Wesley', 'Sahagun', convert(date, '11/15/1978', 101), '2404 W Mercury Blvd', 'Hampton', 'VA', NULL, 'US', 'wesley@sahagun.com', '757-827-1035', 'PROSPECT', NULL),
            ('CRM', '1366067', 'Hanna', 'Waetzig', convert(date, '01/16/1994', 101), 'Hwy 80', 'Pooler', 'GA', NULL, 'US', NULL, '912-748-2988', 'PROSPECT', NULL),
            ('CRM', '1366369', 'Lisa', 'Hilgeman', convert(date, '08/11/1977', 101), '600 Grant St #-42', 'Pittsburgh', 'PA', NULL, 'US', 'elisa@hilgeman.com', '412-566-1804', 'PROSPECT', NULL),
            ('CRM', '1366458', 'Earline', 'Hendel', convert(date, '09/21/1969', 101), '4850 Rhawn Ave', 'Philadelphia', 'PA', '19136', 'US', 'earline@hendel.com', '215-338-6850', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1366536', 'Nelda', 'Elbers', convert(date, '02/02/1997', 101), '100 Federal Ave', 'Boston', 'MA', '02110', 'US', 'nelda@elbers.com', '617-330-5446', 'PROSPECT', NULL),
            ('CRM', '1368072', 'Sheena', 'Missel', convert(date, '09/20/1979', 101), '789 Sherman Ave', 'Denver', 'CO', '80203', 'US', 'sheena@missel.com', '303-860-0262', 'PROSPECT', NULL),
            ('CRM', '1368095', 'Edmundo', 'Resides', convert(date, '10/23/1988', 101), '222 W 6th Ave', 'Junction City', 'KS', '66441', 'US', 'edmundo@resides.com', '785-762-2986', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1368164', 'Lu', 'Geuder', convert(date, '07/03/1984', 101), '429 Themis Ave', 'Cape Girardeau', 'MO', '63701', 'US', 'luella@geuder.com', '573-334-9416', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1369203', 'Lynn', 'Willer', convert(date, '06/16/1983', 101), '343 Sansome Ave', 'San Francisco', 'CA', '94104', 'US', 'lynn@willer.com', '415-981-1865', 'PROSPECT', NULL),
            ('CRM', '1369708', 'Toni', 'Mattos', convert(date, '07/01/1973', 101), '3109 Main Ave', 'Melbourne', 'FL', '32901', 'US', 'toni@mattos.com', '321-727-6512', 'CUSTOMER', 'HIGH'),
            ('CRM', '1370125', 'Jasmine', 'Ellerbusch', convert(date, '12/11/1991', 101), '73 S Hamilton Ave', 'Doylestown', 'PA', '18901', 'US', 'jass@ellerbusch.com', '215-348-5078', 'PROSPECT', NULL),
            ('CRM', '1370624', 'Dan', 'Lamoureux', convert(date, '12/09/1978', 101), '810 W Bridge Ave', 'Streator', 'IL', '61364', 'US', 'daniel@lamoureux.com', '815-672-0290', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1370830', 'Jass', 'Ellerbusch', convert(date, '12/11/1991', 101), '73 S Hamilton Ave', 'Doylestown', 'PA', '18901', 'US', 'jass@ellerbusch.com', '215-348-5078', 'PROSPECT', NULL),
            ('CRM', '1370933', 'Tina', 'Maschak', convert(date, '03/12/1988', 101), '210 N Saint Clair Ave', 'Dayton', 'OH', '45402', 'US', 'christina@maschak.com', '937-222-7228', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1371322', 'DeShawn', 'Peters', convert(date, '09/18/1982', 101), '125 Ne 1st Ave', 'Ocala', 'FL', '34470', 'US', 'd@pedrogo.com', '217-243-7667', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1372230', 'Jame', 'Okimoto', convert(date, '10/23/1983', 101), '210 S Carancahua Ave', 'Corpus Christi', 'TX', '78401', 'US', 'jame@okimoto.com', '361-889-6534', 'PROSPECT', NULL),
            ('CRM', '1372234', 'Russ', 'Schettler', convert(date, '07/22/1981', 101), '689 W Main Ave', 'Freehold', 'NJ', '07728', 'US', 'russell@schettler.com', '732-409-1741', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1372351', 'Dan', 'Runions', convert(date, '12/28/1996', 101), '44 School Ave', 'Boston', 'MA', '02108', 'US', 'daniel@runions.com', '617-367-6047', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1373036', 'Eloisa', 'Resides', convert(date, '04/05/1974', 101), '224 Saint Louis Ave', 'Edwardsville', 'IL', '62025', 'US', 'eloisa@resides.com', '618-656-9506', 'PROSPECT', NULL),
            ('CRM', '1373060', 'Hallie', 'Lolli', convert(date, '12/20/1976', 101), '320 New Bridge Ave', 'Jacksonville', 'NC', '28540', 'US', 'hallie@lolli.com', '910-455-8087', 'PROSPECT', NULL),
            ('CRM', '1373064', 'Mary-Ann', 'Markes', convert(date, '11/18/1993', 101), '1200 Summer St #-103', 'Stamford', 'CT', '06905', 'US', 'maryann@markes.com', '203-967-5612', 'CUSTOMER', 'HIGH'),
            ('CRM', '1374265', 'Dale', 'Balliew', convert(date, '10/14/1980', 101), '216 Birch Ave', 'Kennett Square', 'PA', '19348', 'US', 'dale@balliew.com', '610-444-4527', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1374473', 'Buster', 'Tukuafa', convert(date, '10/24/1972', 101), '822 Baronne Ave', 'New Orleans', 'LA', '70113', 'US', 'buster@tukuafa.com', '504-522-0979', 'PROSPECT', NULL),
            ('CRM', '1375249', 'Marquis', 'Barayuga', convert(date, '01/30/1985', 101), '2 Allée Florian', 'Tassin-la-Demi-Lune', 'Rhône', '69160', 'France', 'marquis@barayuga.com', '+33 4 78 79 83 84', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1376294', 'Ray', 'Amason', convert(date, '12/16/1975', 101), '3 Depot St', 'Wapakoneta', 'OH', '45665', 'US', 'rey@amason.com', NULL, 'CUSTOMER', 'HIGH'),
            ('CRM', '1376534', 'Cortez', 'Derer', convert(date, '12/21/1976', 101), '1415 N 32nd Ave', 'Fort Smith', 'AR', '72904', 'US', 'cortez@derer.com', '479-785-7023', 'CUSTOMER', NULL),
            ('CRM', '1376827', 'Reginald', 'Kososky', convert(date, '01/11/1969', 101), '600 S Indian Hill Ave', 'Claremont', 'CA', '91711', 'US', 'reggie@kososky.com', '909-625-9884', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1376927', 'Lexi', 'Assante', convert(date, '03/02/1990', 101), '484 Lincoln Ave', 'Middlesex', 'NJ', '08846', 'US', 'alexis@assante.com', '732-563-0191', 'PROSPECT', NULL),
            ('CRM', '1377537', 'Mason', 'Shabazz', convert(date, '04/19/1974', 101), '89 E Nationwide Ave', 'Columbus', 'OH', '43215', 'US', 'mason@shabazz.com', '614-221-4018', 'CUSTOMER', 'HIGH'),
            ('CRM', '1378963', 'Jonah', 'Bamfield', convert(date, '08/14/1986', 101), '180 N Stetson Ave', 'Chicago', 'IL', '60601', 'US', 'jonah@bamfield.com', '312-565-2859', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1379472', 'Ted', 'Hilgeman', convert(date, '11/10/1984', 101), '1 Whitney Ave', 'New Haven', 'CT', '06510', 'US', 'edmund@hilgeman.com', '203-865-1215', 'PROSPECT', NULL),
            ('CRM', '1380101', 'Sara', 'Johnson', convert(date, '10/17/1997', 101), NULL, 'San Rafael', 'CA', NULL, 'US', 'saraj@yahoo.com', '415-472-3289', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1380327', 'Emilie', 'Svec', convert(date, '09/04/1991', 101), '2222 W Grandview Blvd', 'Erie', 'PA', '16506', 'US', 'emilie@svec.com', '814-833-6073', 'PROSPECT', NULL),
            ('CRM', '1380441', 'Barnabas', 'Summerset', convert(date, '05/24/1987', 101), '4499 Ruffin Rd', 'San Diego', 'CA', '92123', 'US', 'barney@summerset.com', '714-897-5451', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1381226', 'Mose', 'Pravata', convert(date, '02/15/1969', 101), '1011 Edgewater Ave', 'Ridgefield', 'NJ', '07657', 'US', 'mose@pravata.com', '201-941-5345', 'PROSPECT', NULL),
            ('CRM', '1381797', 'Pearlie', 'Ellerbusch', convert(date, '05/15/1991', 101), '2108 Menaul Blvd Ne', 'Albuquerque', 'NM', '87107', 'US', 'pearlie@ellerbusch.com', '505-889-8955', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1381799', 'Julianna', 'Quimby', convert(date, '08/05/1989', 101), '615 Franklin Tpke', 'Ridgewood', 'NJ', '07450', 'US', 'juliana@quimby.com', '201-444-6741', 'PROSPECT', NULL),
            ('CRM', '1381860', 'Roy', 'Semrad', convert(date, '07/16/1969', 101), '6555 Carnegie Ave', 'Cleveland', 'OH', '44103', 'US', 'roy@semrad.com', '216-361-9627', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1382839', 'Kelly', 'Graniela', convert(date, '12/31/1899', 101), '925 L St', 'Sacramento', 'CA', '95814', 'US', 'kelly@graniela.com', '916-442-8885', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1383060', 'Mary-ann', 'Markes', convert(date, '11/18/1993', 101), '1200 Summer St #-103', 'Stamford', 'CT', '06905', 'US', 'maryann@markes.com', '203-967-5612', 'CUSTOMER', 'HIGH'),
            ('CRM', '1383590', 'John', 'Edelman', convert(date, '09/30/1986', 101), '591 Redwood Hwy #-1200', 'Mill Valley', 'CA', '94941', 'US', 'john@jedelman.com', '415-381-9176', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1384577', 'Roy', 'Averhart', convert(date, '02/17/1973', 101), '101 S San Mateo Dr.', 'San Mateo', 'CA', '94401', 'US', 'roy@averhart.com', '650-342-2438', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1384862', 'Eloisa', 'Schaedler', convert(date, '11/17/1977', 101), '191 Peachtree St Ne', 'Atlanta', 'GA', '30303', 'US', 'eloisa@schaedler.com', '404-818-6870', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1385517', 'Mike', 'Larue', convert(date, '09/04/1991', 101), '109 N Mayo St', 'Americus', 'GA', '31709', 'US', 'mikelarue@amason.com', '229-924-2487', 'CUSTOMER', 'HIGH'),
            ('CRM', '1385755', 'Emilie', 'Svec', convert(date, '05/10/1984', 101), '2222 W Grandview Blvd', 'Erie', 'PA', '16506', 'US', 'emilie@svec.com', '814-833-6073', 'PROSPECT', NULL),
            ('CRM', '1385955', 'Cal', 'Taulman', convert(date, '03/31/1984', 101), 'Petroleum', 'Wichita', 'KS', '67202', 'US', 'caleb@taulman.com', '316-625-8492', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1386206', 'Kelley', 'Taulman', convert(date, '09/06/1976', 101), '1111 Superior Ave E', 'Cleveland', 'OH', '44114', 'US', 'kelley@taulman.com', '216-771-0715', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1386237', 'Callie', 'Aldaba', convert(date, '04/03/1972', 101), '2151 River Plaza Dr #-105', 'Sacramento', 'CA', '95833', 'US', 'callie@aldaba.com', '916-567-4449', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1386547', 'Alyce', 'Mercury', convert(date, '08/29/1973', 101), '108 N Columbus St', 'Alexandria', 'VA', '22314', 'US', 'alyce@mercury.com', '703-548-7115', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1387232', 'Anthony', 'Robaina', convert(date, '08/14/1986', 101), '1555 S Greenwood Ave', 'Montebello', 'CA', '90640', 'US', 'tony@robaina.com', '323-887-4889', 'PROSPECT', NULL),
            ('CRM', '1388087', 'Marquis', 'Barayuga', convert(date, '01/30/1985', 101), '2 Allée Florian', 'Tassin-la-Demi-Lune', 'Rhône', '69160', 'France', 'marquis@barayuga.com', '+33 4 78 79 83 84', 'PROSPECT', NULL),
            ('CRM', '1388210', 'Abe', 'Corbett-Lopéz', convert(date, '10/06/1986', 101), '12 S 12th St', 'Philadelphia', 'PA', '19107', 'US', 'abraham@corbett.com', '215-627-9067', 'PROSPECT', NULL),
            ('CRM', '1388630', 'Carmine', 'Anadio', convert(date, '02/28/1994', 101), '93 Main St', 'Orono', 'ME', '04473', 'US', 'carmine@anadio.com', '207-866-5602', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1388894', 'Mikel', 'Pete', convert(date, '09/05/1982', 101), '2 E Mifflin St', 'Madison', 'WI', '53703', 'US', NULL, '608-257-6727', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1388913', 'Marlon', 'Gouker', convert(date, '11/13/1979', 101), '167 E Main St', 'Lexington', 'KY', '40507', 'US', NULL, '859-253-6671', 'PROSPECT', NULL),
            ('CRM', '1389553', 'Fran', 'Sahagun', convert(date, '07/22/1972', 101), '220 S 6th St', 'Minneapolis', 'MN', '55402', 'US', 'francine@sahagun.com', '612-340-7052', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1390591', 'Lyle', 'Hilgeman', convert(date, '03/26/1991', 101), '115 N 20th St', 'Tampa', 'FL', '33605', 'US', 'lyle@hilgeman.com', '813-248-1861', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1390832', 'Jake', 'Schettler', convert(date, '05/09/1983', 101), '10400 Eaton Pl #-401', 'Fairfax', 'VA', '22030', 'US', 'jake@schettler.com', '703-591-4492', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1391074', 'Claude', 'Averhart', convert(date, '02/15/1969', 101), '49 S Carroll St', 'Frederick', 'MD', '21701', 'US', 'claude@averhart.com', '301-698-3706', 'PROSPECT', NULL),
            ('CRM', '1391721', 'Alex', 'Anadio', convert(date, '02/25/1992', 101), '1651 W Baseline Rd', 'Tempe', 'AZ', '85283', 'US', 'alexander@anadio.com', '480-491-3109', 'PROSPECT', NULL),
            ('CRM', '1391755', 'Ken', 'Robaina', convert(date, '11/18/1993', 101), '1455 91st Ave Ne', 'Minneapolis', 'MN', '55449', 'US', 'ken@robaina.com', '763.780.4712', 'PROSPECT', NULL),
            ('CRM', '1391914', 'Thanh', 'Spark', convert(date, '05/15/1991', 101), '1800 Ids Ctr', 'Minneapolis', 'MN', '55402', 'US', 'thanh@spark.com', '612-339-5614', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1392184', 'Clare', 'Poitier', convert(date, '07/16/1969', 101), '28500 Green Oak Dr', 'Roseville', 'MI', '48066', 'US', 'clair@poitier.com', '586-296-0808', 'PROSPECT', NULL),
            ('CRM', '1392270', 'Adele', 'Richardson', convert(date, '01/09/1981', 101), '15 Pleasant Ave E', 'Paramus', 'NJ', '07652', 'US', 'adelaide@mackson.com', '201-845-4885', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1392285', 'Quinton', 'Svec', convert(date, '09/28/1987', 101), '160 Belmont Ave', 'Garfield', 'NJ', '07026', 'US', 'quinton@svec.com', '973-772-6233', 'PROSPECT', NULL),
            ('CRM', '1392506', 'LaTonia', 'Williams', convert(date, '03/09/1991', 101), '7600 Olde Eight Rd', 'Hudson', 'OH', '44236', 'US', 'latonia.williams@yahoo.com', '330-656-1030', 'CUSTOMER', 'HIGH'),
            ('CRM', '1392939', 'Stacy', 'Schettler', convert(date, '08/01/1979', 101), '36 Exton St', 'South River', 'NJ', '08882', 'US', 'stacy@schettler.com', '732-254-0161', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1393125', 'Jude', 'Warstler', convert(date, '09/30/1986', 101), '205 Madison Ave', 'Scranton', 'PA', '18503', 'US', 'jude@warstler.com', '570-346-7206', 'PROSPECT', NULL),
            ('CRM', '1394755', 'Ken', 'Robaina', convert(date, '11/17/1977', 101), '1455 91st Ave Ne', 'Minneapolis', 'MN', '55449', 'US', 'ken@robaina.com', '7637804712', 'PROSPECT', NULL),
            ('CRM', '1395755', 'Kenneth', 'Robaina', convert(date, '01/05/1986', 101), '1455 91st Ave Ne', 'Minneapolis', 'MN', '55449', 'US', 'ken@robaina.com', '763-780-4712', 'PROSPECT', NULL),
            ('CRM', '1396755', 'Kenneth', 'Robaina', convert(date, '04/03/1972', 101), '1455 91st Ave Ne', 'Minneapolis', 'MN', '55449', 'US', 'ken@robaina.com', '763-780-4712', 'PROSPECT', NULL),
            ('CRM', '1397271', 'Harlan', 'Semrad', convert(date, '08/29/1973', 101), '459 River Rd', 'Bay City', 'MI', '48708', 'US', 'harlan@semrad.com', '989-893-3319', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1398304', 'Curt', 'Cha', convert(date, '04/08/1986', 101), '545 Chancellor Ave', 'Irvington', 'NJ', '07111', 'US', 'curtis@cha.com', '973-372-5969', 'CUSTOMER', NULL),
            ('CRM', '1398320', 'Jackson', 'Tea', convert(date, '05/09/1996', 101), '50 Robbers Roost Ln', 'Cedar City', 'UT', '84720', 'US', 'jack@jtea.com', '435-865-5139', 'CUSTOMER', NULL),
            ('CRM', '1398375', 'Mark', 'Waters', convert(date, '06/15/1980', 101), '2308 Bates Ave', 'Concord', 'CA', '94520', 'US', 'mark@markwaters.com', '925-682-6249', 'CUSTOMER', 'HIGH'),
            ('CRM', '1398396', 'Michelle', 'Garcia', convert(date, '03/18/1991', 101), '4311 Puma Drive', 'Casper', 'WY', '82604', 'US', 'michelle@garcia.com', '307-577-9333', 'CUSTOMER', NULL),
            ('CRM', '1399446', 'Sara', 'Johnson', convert(date, '02/28/1994', 101), '90 Mitchell Blvd #201', 'San Rafael', 'CA', '94903', 'US', 'saraj@yahoo.com', '415-472-3289', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1399550', 'Dixie', 'Jackowiak', convert(date, '12/16/1983', 101), '18017 Roseland Rd', 'Cleveland', 'OH', '44112', 'US', 'dixie@jackowiak.com', '216-531-6191', 'PROSPECT', NULL),
            ('CRM', '1399801', 'Jill', 'Guzzetta', convert(date, '11/13/1979', 101), '44 Galloway Rd', 'Warwick', 'NY', '10990', 'US', 'jill@guzzetta.com', '986-1216', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1400678', 'Frannie', 'Maggert', convert(date, '07/22/1972', 101), '8000 Cooper Ave', 'Ridgewood', 'NY', '11385', 'US', 'fran@maggert.com', '718-894-8022', 'PROSPECT', NULL),
            ('CRM', '1402251', 'Araceli', 'Creecy', convert(date, '12/31/1899', 101), '100 Federal Ave', 'Boston', 'MA', '02110', 'US', 'araceli@creecy.com', '527-4935', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1402262', 'Louis', 'Kyle', convert(date, '05/23/1988', 101), '9425 Stenton Ave', 'Philadelphia', 'PA', '19118', 'US', 'louis@kyle.com', '233-0367', 'CUSTOMER', 'HIGH'),
            ('CRM', '1403451', 'Chris', 'Ubaldo', convert(date, '01/26/1995', 101), '6840 N Cutter Cir', 'Portland', 'OR', '97217', 'US', 'kris@ubaldo.com', '240-0223', 'PROSPECT', NULL),
            ('CRM', '1403605', 'Margarito', 'Winland', convert(date, '01/05/1982', 101), '1856 Lombardy Dr', 'Rapid City', 'SD', '57701', 'US', 'margarito@winland.com', '348-4444', 'PROSPECT', NULL),
            ('CRM', '1404509', 'Alanna P.', 'Resides', convert(date, '05/25/1969', 101), '4892 River St. #102', 'Detroit', 'MI', '48208', 'US', 'a@aresides.com', '898-2211', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1405405', 'Linda', 'Bamfield', convert(date, '10/18/1981', 101), '2094 White Plains Rd', 'Bronx', 'NY', '10462', 'US', 'lynda@bamfield.com', '347-430-2736', 'CUSTOMER', 'HIGH'),
            ('CRM', '1406729', 'angelica', 'aldaba', convert(date, '12/31/1899', 101), '1427 Nw Davis St', 'Portland', 'OR', '67206', 'US', 'angelia@aldaba.com', '503.228.3027', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1408146', 'Josef', 'Taulman', convert(date, '04/29/1989', 101), '1620 Asheville Hwy', 'Hendersonville', 'NC', '28791', 'US', 'josef@taulman.com', '693-9775', 'PROSPECT', NULL),
            ('CRM', '1408293', 'J', 'Kososky', convert(date, '06/19/1989', 101), '100 Wilshire Blvd #-500', 'Santa Monica', 'CA', '90401', 'US', 'j@kososky.com', '458-6371', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1409489', 'Carroll', 'Spark', convert(date, '02/08/1992', 101), '500 S Randall St', 'Rhome', 'TX', '76078', 'US', 'carroll@spark.com', '636-2216', 'CUSTOMER', NULL),
            ('CRM', '1410025', 'Dell', 'Tarka', convert(date, '02/24/1978', 101), 'Kingsbury Squa', 'Zephyr Cove', 'NV', '89448', 'US', 'adele@tarka.com', '588-1343', 'PROSPECT', NULL),
            ('CRM', '1410141', 'Brett', 'Rave', convert(date, '02/05/1979', 101), '2501 Wayzata Blvd', 'Minneapolis', 'MN', '55405', 'US', 'britt@rave.com', '377-6491', 'PROSPECT', NULL),
            ('CRM', '1412102', 'Robbin', 'Durham', convert(date, '12/27/1990', 101), '105 W Superior St', 'Duluth', 'MN', '55802', 'US', 'robbin@durham.com', '720-7716', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1412528', 'Migdalia', 'Tukuafa', convert(date, '07/19/1979', 101), '215 E Hawaii Ave', 'Nampa', 'ID', '83686', 'US', 'migdalia@tukuafa.com', '465-9237', 'PROSPECT', NULL),
            ('CRM', '1418027', 'Gail', 'Taulman', convert(date, '12/10/1971', 101), '5094 Westbrook Rd', 'Union City', 'GA', '30291', 'US', 'gail@taulman.com', '969-4377', 'PROSPECT', NULL),
            ('CRM', '1419718', 'Antonia', 'Mattos', convert(date, '07/01/1973', 101), '3109 Main Ave', 'Melbourne', 'FL', '32901', 'US', 'toni@mattos.com', '727-6512', 'CUSTOMER', 'HIGH'),
            ('CRM', '1419728', 'Antonia', 'Mattos', convert(date, '07/01/1973', 101), '3109 Main Ave', 'Melbourne', 'FL', '32901', 'US', 'toni@mattos.com', '(321)727-6512', 'CUSTOMER', 'HIGH'),
            ('CRM', '1419748', 'Toni', 'Mattos', convert(date, '07/01/1973', 101), '3109 Main Ave', 'Melbourne', 'FL', '32901', 'US', 'toni@mattos.com', '321.727-.512', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1421940', 'Prince', 'Schettler', convert(date, '03/28/1981', 101), '412 Front St', 'Beaufort', 'NC', '28516', 'US', 'prince@schettler.com', '728-0135', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1422294', 'Buford', 'Cacace', convert(date, '04/27/1973', 101), '1030 Us Highway 46', 'Clifton', 'NJ', '07013', 'US', 'buford@cacace.com', '773-8628', 'PROSPECT', NULL),
            ('CRM', '1422971', 'Mark', 'Waters', convert(date, '06/15/1980', 101), '2308 Bates Ave', 'Concord', 'CA', '94520', 'US', 'markwaters@gmail.com', '682-6249', 'CUSTOMER', 'HIGH'),
            ('CRM', '1423914', 'Clo', 'Anadio', convert(date, '10/08/1985', 101), '114 N Main St', 'Mullica Hill', 'NJ', '08062', 'US', 'chloe@anadio.com', '478-4036', 'CUSTOMER', NULL),
            ('CRM', '1426631', 'Liza', 'Assante', convert(date, '12/03/1981', 101), '8589 Darrow Rd', 'Twinsburg', 'OH', '44087', 'US', 'liza@assante.com', '425-7382', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1428529', 'Chang', 'Svec', convert(date, '12/14/1989', 101), '3416 S 48th St #-6', 'Phoenix', 'AZ', '85040', 'US', 'chang@svec.com', '968-2792', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1429646', 'Huey', 'Gouker', convert(date, '10/27/1990', 101), '100 Habersham Dr', 'Fayetteville', 'GA', '30214', 'US', 'huey@gouker.com', '461-4303', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1433728', 'Saul', 'Rave', convert(date, '04/09/1986', 101), '1500 N 13th St', 'Reading', 'PA', '19604', 'US', 'saul@rave.com', '484-375-7261', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1434531', 'Lee', 'Coday', convert(date, '04/10/1982', 101), '27324 Camino Capistrano #-153', 'Laguna Niguel', 'CA', '92677', 'US', 'levi@coday.com', '348-4985', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1435348', 'Gail', 'Taulman', convert(date, '12/10/1971', 101), '5094 Westbrook Rd', 'Union City', 'GA', '30291', 'US', 'gail@taulman.com', '969-4377', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1436978', 'Deshawn', 'peters', convert(date, '12/31/1899', 101), '125 Ne 1st Ave', 'Ocala', 'FL', '34470', 'US', 'd@pedrogo.com', '217.243.7667', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1438474', 'Dianne', 'Kytle', convert(date, '09/07/1981', 101), '3501 W Lake Rd', 'Abilene', 'TX', '79601', 'US', 'dianne@kytle.com', '325-672-6016', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1438610', 'Nettie', 'Winland', convert(date, '10/14/1977', 101), '222 N 3rd St', 'Yakima', 'WA', '98901', 'US', 'natalie@winland.com', '509-575-7812', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1439057', 'Zack', 'Lessin', convert(date, '07/15/1990', 101), '44800 Industrial Dr', 'Fremont', 'CA', '94538', 'US', 'zack@lessin.com', '510-657-4870', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1439566', 'Reginald', 'Temores', convert(date, '12/12/1976', 101), '402 Bna Dr', 'Nashville', 'TN', '37217', 'US', 'reggie@temores.com', '615-360-5493', 'CUSTOMER', 'NORMAL'),
            ('CRM', '1439594', 'Kathie', 'Kum', convert(date, '11/05/1980', 101), '220 S Broadway', 'Rochester', 'MN', '55904', 'US', 'kathie@kum.com', '507-288-4102', 'PROSPECT', NULL),
            ('CRM', '1469708', 'Antonia', 'Mattos', convert(date, '07/01/1973', 101), '3109 Main Ave', 'Melbourne', 'FL', '32901', 'US', 'toni@mattos.com', '321-727-6512', 'CUSTOMER', 'HIGH'),
            ('CRM', '1483060', 'Mary-ann', 'Markes', convert(date, '11/18/1993', 101), '1200 Summer St #-103', 'Stamford', 'CT', '06905', 'US', 'maryann@markes.com', '203-967-5612', 'CUSTOMER', 'HIGH'),
            ('MKT', '1321830', 'Jass', 'Ellerbusch', convert(date, '12/11/1991', 101), '73 S Hamilton Ave', 'Doylestown', 'PA', '18901', 'US', 'jass@ellerbusch.com', '215-348-5078', 'PROSPECT', NULL),
            ('MKT', '1351755', 'Billie', 'Pedro', convert(date, '01/31/1973', 101), '419 N Cascade Ave', 'Colorado Springs', 'CO', '80903', 'US', 'billie@pedro.com', '303-288-4159', 'PROSPECT', NULL),
            ('MKT', '1352605', 'Cassie', 'Sandrowicz', convert(date, '01/19/1984', 101), 'Howells Rd', 'Middletown', 'NY', '10640', 'US', 'carrie@sandrowicz.com', '845-344-5941', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1353360', 'Linda', 'Pelham', convert(date, '08/21/1990', 101), 'Old Hwy #-72', 'Cherokee', 'AL', '35818', 'US', 'melinda@pelham.com', '256-360-5870', 'PROSPECT', NULL),
            ('MKT', '1353826', 'Teri', 'Neundorfer', convert(date, '11/09/1983', 101), '601 W Main #-815', 'Spokane', 'WA', '66201', 'US', 'teri@neundorfer.com', '509-838-6142', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1354026', 'Willy', 'Okimoto', convert(date, '05/18/1990', 101), '17 Hanover Rd', 'Florham Park', 'NJ', '07632', 'US', 'willy@okimoto.com', '973-822-8978', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1355044', 'Lexi', 'Derer', convert(date, '07/20/1986', 101), 'Rt 111', 'Hollis', 'NH', '03046', 'US', 'alexis@derer.com', '603-883-6221', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1356294', 'Rey', 'Amason', convert(date, '12/16/1975', 101), '3 Depot St', 'Wapakoneta', 'OH', '45665', 'US', 'rey@amason.com', '419-738-9241', 'CUSTOMER', 'HIGH'),
            ('MKT', '1356989', 'Lino', 'Sultaire', convert(date, '07/20/1986', 101), '1400 N Woodward Ave #-200', 'Bloomfield Hills', 'MI', '46304', 'US', 'lino@sultaire.com', '248-647-7623', 'PROSPECT', NULL),
            ('MKT', '1357114', 'Latonia', 'Williams', convert(date, '07/18/1986', 101), '7600 Olde Eight Rd', 'Hudson', 'OH', '44236', 'US', 'latonia.williams@yahoo.com', '330-656-1030', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1358864', 'Evan', 'Cacace', convert(date, '12/12/1971', 101), '1400 Old Country Rd', 'Westbury', 'NY', '11560', 'US', 'evan@cacace.com', '516-997-9354', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1362223', 'Opal', 'Roecker', convert(date, '11/14/1975', 101), '27 Washington', 'Westborough', 'MA', '01561', 'US', 'opal@roecker.com', '508-870-0435', 'PROSPECT', NULL),
            ('MKT', '1363038', 'Lois', 'Kyle', convert(date, '03/13/1972', 101), '9425 Stenton Ave', 'Philadelphia', 'PA', NULL, 'US', 'lois@kyle.com', '215-233-0367', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1363200', 'Karin', 'Camell', convert(date, '06/15/1975', 101), 'Cedar', 'Mountain Grove', 'MO', NULL, 'US', 'karin@camell.com', '417-962-5985', 'PROSPECT', NULL),
            ('MKT', '1363548', 'Kenneth', 'Robaina', convert(date, '10/24/1996', 101), '1455 91st Ave Ne', 'Minneapolis', 'MN', NULL, 'US', 'ken@robaina.com', '763-780-4712', 'PROSPECT', NULL),
            ('MKT', '1363938', 'Jake', 'Schettler', convert(date, '08/26/1979', 101), '10400 Eaton Pl #-401', 'Fairfax', 'VA', NULL, 'US', 'jake@schettler.com', '703-591-4492', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1364608', 'Rey', 'Amason', convert(date, '12/16/1975', 101), '3 Depot St', 'Wapakoneta', 'OH', NULL, 'US', 'rey@amason.com', '419-738-9241', 'CUSTOMER', 'HIGH'),
            ('MKT', '1364655', 'Jeri', 'Willer', convert(date, '07/19/1985', 101), '1660 S Albion St', 'Denver', 'CO', NULL, 'US', 'jeri@willer.com', '303-753-2153', 'PROSPECT', NULL),
            ('MKT', '1364815', 'Chuck', 'Mattos', convert(date, '09/11/1985', 101), '137 Farnsworth Ave', 'Bordentown', 'NJ', NULL, 'US', 'charlie@mattos.com', '609-298-3130', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1366323', 'Ed', 'Markes', convert(date, '06/11/1970', 101), '2444 Madison Rd', 'Cincinnati', 'OH', NULL, 'US', 'elisa@markes.com', '513-871-6770', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1367021', 'Nelly', 'Graniela', convert(date, '03/09/1991', 101), '925 L Ave', 'Sacramento', 'CA', '95814', 'US', 'e@graniela.com', '916-442-88', 'PROSPECT', NULL),
            ('MKT', '1367261', 'Fran', 'Sahagun', convert(date, '11/17/1981', 101), '220 S 6th Ave', 'Minneapolis', 'MN', '55402', 'US', 'francine@sahagun.com', '612-340-7052', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1367501', 'Shanna', 'Seyfarth', convert(date, '08/01/1970', 101), '631 Grove Ave', 'Jersey City', 'NJ', '07310', 'US', 'shanna@seyfarth.com', '201-659-6516', 'PROSPECT', NULL),
            ('MKT', '1368178', 'Nola', 'Girvan', convert(date, '04/10/1980', 101), '1620 Paonia Ave', 'Colorado Springs', 'CO', '80915', 'US', 'nola@girvan.com', '719-574-6245', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1370265', 'Betsy', 'Pravata', convert(date, '12/12/1987', 101), '7230 Woodland Dr', 'Indianapolis', 'IN', '46278', 'US', 'betsy@pravata.com', '630-801-2462', 'PROSPECT', NULL),
            ('MKT', '1372469', 'Billie', 'Balliew', convert(date, '12/09/1975', 101), '166 Boulder Dr', 'Fitchburg', 'MA', '01420', 'US', 'billie@balliew.com', '508-548-4717', 'PROSPECT', NULL),
            ('MKT', '1372958', 'Leann', 'Creecy', convert(date, '03/17/1974', 101), '3850 W 20th Ave', 'Cleveland', 'OH', '44109', 'US', 'leann@creecy.com', '216-749-0767', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1373514', 'Aida', 'James', convert(date, '05/01/1994', 101), '1200 Main Ave', 'Kansas City', 'MO', '64105', 'US', 'aida@neundorfer.com', '374-9387', 'PROSPECT', NULL),
            ('MKT', '1373598', 'Bryon', 'Ubaldo', convert(date, '08/09/1994', 101), '1922 S Laredo St', 'San Antonio', 'TX', '78207', 'US', 'bryon@ubaldo.com', '210-436-9996', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1374096', 'Claudine', 'Hudy', convert(date, '08/03/1988', 101), '1540 S 21st Ave', 'Colorado Springs', 'CO', '80904', 'US', 'claudine@hudy.com', '719-633-3092', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1374707', 'Alanna', 'Glasser', convert(date, '12/31/1899', 101), '4892 River', 'DETROIT', 'Michigan', ' ', NULL, 'a@aresides.com', '618-594-3207', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1374829', 'Prince', 'Anadio', convert(date, '07/18/1988', 101), '100 Boxart Ave', 'Rochester', 'NY', '14612', 'US', 'prince@anadio.com', '585-663-6442', 'PROSPECT', NULL),
            ('MKT', '1375542', 'Cheri', 'Defiguero', convert(date, '02/16/1973', 101), '2844 Fresno Ave', 'Fresno', 'CA', '93721', 'US', 'cheri@defiguero.com', '559-486-5603', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1375653', 'Lino', 'Maggert', convert(date, '11/30/1978', 101), '6 Beacon Ave', 'Boston', 'MA', '02108', 'US', 'lino@maggert.com', '617-227-6545', 'PROSPECT', NULL),
            ('MKT', '1375815', 'Florencio', 'Michna', convert(date, '05/17/1990', 101), '201 S Main Ave', 'Salt Lake City', 'UT', '84111', 'US', 'florencio@michna.com', '801-536-1091', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1376216', 'Ashleigh', 'Schiveley', convert(date, '01/29/1997', 101), '8 Commercial Ave', 'Medford', 'NY', '11763', 'US', 'ashleigh@missel.com', '716-372-9571', 'PROSPECT', NULL),
            ('MKT', '1376987', 'Vernice', 'Southwood', convert(date, '10/22/1987', 101), '8 Commercial Ave', 'Medford', 'NY', '11763', 'US', 'vernice@southwood.com', '631-698-8293', 'PROSPECT', NULL),
            ('MKT', '1377623', 'Edward', 'Michaels', convert(date, '06/09/1979', 101), '3601 N Lincoln Ave', 'Oklahoma City', 'OK', '73105', 'US', 'emily@gouker.com', '405-524-6481', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1378547', 'Tonya', 'Joehnck', convert(date, '01/21/1993', 101), '30 7th St E #-510', 'Saint Paul', 'MN', '55101', 'US', 'tonya@joehnck.com', '651-298-9175', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1378817', 'Patty', 'Mitchen', convert(date, '04/19/1980', 101), '220 Park Ave S', 'Saint Cloud', 'MN', '56301', 'US', 'martha@mitchen.com', '320-251-3787', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1379005', 'Mark', 'Waters', convert(date, '06/15/1980', 101), '2308 Bates Ave', 'Concord', 'CA', '94520', 'US', 'mark@markwaters.com', '925-682-6249', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1379404', 'Emily', 'Michaels', convert(date, '05/09/1983', 101), '108 W Randolph Ave', 'Enid', 'OK', '73701', 'US', 'emily@gouker.com', '580-233-9834', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1379537', 'David', 'Camell', convert(date, '07/01/1989', 101), '4 E 8th St #-200', 'Wilmington', 'DE', '19801', 'US', 'dave@camell.com', '302-655-4884', 'PROSPECT', NULL),
            ('MKT', '1379608', 'Harry', 'Masters', convert(date, '04/13/1971', 101), '7220 Woodland Drive', 'Indianapolis', 'IN', '46278', 'US', 'harry@icloudnet.com', '317-290-2614', 'PROSPECT', NULL),
            ('MKT', '1380531', 'Carol', 'Lapalme', convert(date, '03/26/1991', 101), '4910 Departure Dr', 'Raleigh', 'NC', '27605', 'US', 'carol.lapalme@yahoo.com', '919-876-7612', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1380884', 'R', 'Mares', convert(date, '05/09/1983', 101), '220090 S 7th St', 'Minneapolis', 'MN', '55402', 'US', 'reinaldo@mares.com', '612-336-4873', 'PROSPECT', NULL),
            ('MKT', '1381567', 'Earnestine', 'Waetzig', convert(date, '02/25/1992', 101), '16161 Brookpark Rd', 'Brook Park', 'OH', '44142', 'US', 'earnestine@waetzig.com', '216-267-1844', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1381582', 'Mary-Ann', 'Markes', convert(date, '12/31/1899', 101), '1200 Summer St #-103', 'Stamford', 'CT', '06905', 'US', 'maryann@markes.com', '203-967-5612', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1381873', 'Omer', 'Averhart', convert(date, '01/09/1981', 101), '400 Capitol Mall', 'Sacramento', 'CA', '95814', 'US', 'omer@averhart.com', '916-927-6221', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1382583', 'Aimee', 'Singh', convert(date, '09/28/1987', 101), '2211 Parsons Ave', 'Columbus', 'OH', '43207', 'US', 'aimee@pulkrabek.com', '614-445-5812', 'PROSPECT', NULL),
            ('MKT', '1382655', 'Latonya', 'Odegard', convert(date, '03/09/1991', 101), '4499 Ruffin Rd', 'San Diego', 'CA', '92123', 'US', 'latonya@odegard.com', '858-277-6570', 'CUSTOMER', 'HIGH'),
            ('MKT', '1383342', 'Zay', 'Hendel', convert(date, '09/03/1976', 101), '2332 E Division St', 'Springfield', 'MO', '65803', 'US', 'isaiah@hendel.com', '417-864-1286', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1385863', 'Mario', 'Averhart', convert(date, '01/05/1986', 101), '111 Lyon St Nw', 'Grand Rapids', 'MI', '49503', 'US', 'mario@averhart.com', '752-3959', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1386889', 'Porfirio', 'Creecy', convert(date, '05/24/1976', 101), '1440 Poplar Ave', 'Memphis', 'TN', '38104', 'US', 'porfirio@creecy.com', '901-272-9572', 'PROSPECT', NULL),
            ('MKT', '1386998', 'Jack', 'Guzzetta', convert(date, '08/05/1985', 101), 'Rr 1', 'Lawsonville', 'NC', '27022', 'US', NULL, '336-871-7622', 'PROSPECT', NULL),
            ('MKT', '1387000', 'Franklin', 'Pappan', convert(date, '04/08/1986', 101), '5 Post Oak Park', 'Houston', 'TX', '77027', 'US', 'frank@pappan.com', '713-961-3153', 'PROSPECT', NULL),
            ('MKT', '1387710', 'Sandra', 'Lessin', convert(date, '01/30/1985', 101), '401 B St', 'San Diego', 'CA', '92101', 'US', 'alexandria@lessin.com', '619-687-1471', 'PROSPECT', NULL),
            ('MKT', '1388393', 'Jose', 'Gumm', convert(date, '12/04/1978', 101), '198 S 2nd Ave', 'Piggott', 'AR', '72454', 'US', 'jose@gumm.com', '870-598-1132', 'PROSPECT', NULL),
            ('MKT', '1388559', 'Lana', 'Ramming', convert(date, '02/17/1986', 101), '2930 Carol Rd', 'York', 'PA', '17402', 'US', 'lana@ramming.com', '717-840-9610', 'PROSPECT', NULL),
            ('MKT', '1388757', 'Moises', 'Lessin', convert(date, '12/16/1983', 101), '3703 W Highway 14', 'Owatonna', 'MN', '55060', 'US', 'moises@lessin.com', '507-451-6685', 'PROSPECT', NULL),
            ('MKT', '1389085', 'Bennie', 'Lessin', convert(date, '11/17/1981', 101), '200 A St', 'Crescent City', 'CA', '95531', 'US', 'bennie@lessin.com', '661-324-1207', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1389913', 'Claudine', 'Coday', convert(date, '06/17/1977', 101), 'Exit #-21', 'Stevens', 'PA', '17578', 'US', 'claudine@coday.com', '717-336-5449', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1392031', 'T', 'Polacek', convert(date, '08/05/1989', 101), '1100 Alakea St #-12', 'Honolulu', 'HI', '96813', 'US', 'terri@polacek.com', '808-237-6644', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1392625', 'Viv', 'Jackowiak', convert(date, '12/31/1899', 101), '1320 Hodges St', 'Raleigh', 'NC', '27604', 'US', 'vivian@jackowiak.com', '919-832-9928', 'PROSPECT', NULL),
            ('MKT', '1393026', 'Cari', 'Isaacson', convert(date, '09/03/1976', 101), '820 Lester Ave', 'Saint Joseph', 'MI', '49085', 'US', 'cari@isaacson.com', '269-983-2318', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1393927', 'Fred', 'Tarka', convert(date, '02/17/1973', 101), 'Box #-34506', 'Houston', 'TX', '77234', 'US', 'willie@tarka.com', '713-731-5570', 'PROSPECT', NULL),
            ('MKT', '1394793', 'Isiah', 'Durham', convert(date, '09/04/1991', 101), '7427 Arlington Rd', 'Bethesda', 'MD', '20814', 'US', 'isiah@durham.com', '301-986-1395', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1395419', 'Federico', 'Popp', convert(date, '05/10/1984', 101), '419 N Cascade Ave', 'Colorado Springs', 'CO', '80903', 'US', 'federico@popp.com', '719-635-5347', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1396700', 'Ross', 'Glueckert', convert(date, '03/31/1984', 101), '1106 E 3rd St', 'Dayton', 'OH', '45402', 'US', 'ross@glueckert.com', '937-228-3007', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1396727', 'Dustin', 'Hysmith', convert(date, '09/06/1976', 101), '6371 Burnt Poplar Rd', 'Greensboro', 'NC', '27409', 'US', 'dustin@hysmith.com', '336-852-6077', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1397394', 'O', 'Tukuafa', convert(date, '05/24/1976', 101), '6805 Capitol Hwy #-32', 'Austin', 'TX', '78731', 'US', 'octavio@tukuafa.com', '512-327-8399', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1398218', 'Mohammed', 'Mikell', convert(date, '08/05/1985', 101), 'Box #-1092', 'Crescent City', 'CA', '95531', 'US', 'mohammed@mikell.com', '707-464-9425', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1398717', 'Justina', 'Ubaldo', convert(date, '01/30/1985', 101), '320 W Front St', 'Media', 'PA', '19063', 'US', 'justina@ubaldo.com', '610-565-9373', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1398731', 'Marlene', 'Hilgeman', convert(date, '09/20/1982', 101), '300 S 4th St #-1700', 'Las Vegas', 'NV', '89101', 'US', 'marlene@hilgeman.com', '383-2994', 'PROSPECT', NULL),
            ('MKT', '1398789', 'Leopoldo', 'Michna', convert(date, '10/06/1986', 101), '166 Boulder Dr', 'Fitchburg', 'MA', '01420', 'US', 'leopoldo@michna.com', '978-343-6343', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1398995', 'Henry', 'Masters', convert(date, '12/04/1978', 101), '7220 Woodland Dr', 'Indianapolis', 'IN', '46278', 'US', 'harry@icloudnet.com', '317-290-2614', 'PROSPECT', NULL),
            ('MKT', '1399171', 'Francesco', 'Roecker', convert(date, '02/17/1986', 101), '334 Us Highway 46', 'Wayne', 'NJ', '07470', 'US', 'francesco@roecker.com', '973-890-9344', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1399642', 'Emilie', 'Svec', convert(date, '09/05/1982', 101), '2222 W Grandview Blvd', 'Erie', 'PA', '16506', 'US', 'emilie@svec.com', '814-833-6073', 'PROSPECT', NULL),
            ('MKT', '1399854', 'Tammi', 'Eilert', convert(date, '11/17/1981', 101), '425 Maluniu Ave #-b', 'Kailua', 'HI', '96734', 'US', 'tammi@eilert.com', '808-263-1923', 'PROSPECT', NULL),
            ('MKT', '1401213', 'Juliana', 'Quimby', convert(date, '06/17/1977', 101), '615 Franklin Tpke', 'Ridgewood', 'NJ', '07450', 'US', 'juliana@quimby.com', '201.444.6741', 'PROSPECT', NULL),
            ('MKT', '1404880', 'John', 'Edelman', convert(date, '09/03/1976', 101), '591 Redwood Hwy #-1200', 'Mill Valley', 'CA', '94941', 'US', 'john@jedelman.com', '415.381.9176', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1405814', 'Tina', 'Poitier', convert(date, '04/01/1980', 101), '2571 Timber Ln', 'Dayton', 'OH', '45414', 'US', 'christine@poitier.com', '277-1814', 'PROSPECT', NULL),
            ('MKT', '1406654', 'Dana', 'Missel', convert(date, '02/10/1987', 101), '2445 M St Nw', 'Washington', 'DC', '20037', 'US', 'dana@missel.com', '663-4512', 'PROSPECT', NULL),
            ('MKT', '1408222', 'Eldon', 'Lolli', convert(date, '09/27/1997', 101), '8350 E Mcdonald Dr', 'Scottsdale', 'AZ', '85250', 'US', 'eldon@lolli.com', '443-6788', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1409121', 'Nonie', 'Pete', convert(date, '04/01/1979', 101), '313 Price Pl', 'Madison', 'WI', '53705', 'US', 'nora@pete.com', '231-6751', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1409934', 'Sara', 'Johnson', convert(date, '10/17/1997', 101), '90 Mitchell Boulevard', 'San Rafael', 'CA', '94903', 'US', 'saraj@yahoo.com', '472-3289', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1410024', 'Homer', 'Southwood', convert(date, '06/01/1995', 101), '1430 N Meacham Rd', 'Schaumburg', 'IL', '60173', 'US', 'homer@southwood.com', '884-7511', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1412252', 'Alice', 'Shabazz', convert(date, '09/12/1985', 101), '16 S Ketcham Ave', 'Amityville', 'NY', '11701', 'US', 'alyce@shabazz.com', '691-6477', 'PROSPECT', NULL),
            ('MKT', '1413179', 'Jude', 'Warstler', convert(date, '10/24/1975', 101), '205 Madison Ave', 'Scranton', 'PA', '18503', 'US', 'jude@warstler.com', '346-7206', 'PROSPECT', NULL),
            ('MKT', '1413527', 'Daron', 'Seyfarth', convert(date, '09/25/1991', 101), '1211 Sw 5th Ave', 'Portland', 'OR', '97204', 'US', 'daron@seyfarth.com', '796-4738', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1414505', 'Jarod', 'Mercury', convert(date, '10/21/1995', 101), '5901 N Western Ave', 'Oklahoma City', 'OK', '73118', 'US', 'jarod@mercury.com', '2907', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1416366', 'Saul', 'Rave', convert(date, '04/19/1986', 101), '1500 N 13th St', 'Reading', 'PA', '19604', 'US', 'saul@rave.com', '(484) 375-7261', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1420684', 'Delmar', 'Quimby', convert(date, '08/03/1981', 101), '212 W Gibson Dr', 'Greenville', 'MI', '48838', 'US', 'delmar@quimby.com', '754-6715', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1422861', 'Lynda', 'Bamfield', convert(date, '10/18/1981', 101), '2094 White Plains Rd', 'Bronx', 'NY', '10462', 'US', 'lynda@bamfield.com', '3474302736', 'CUSTOMER', 'HIGH'),
            ('MKT', '1424076', 'Burl', 'Maggert', convert(date, '02/09/1993', 101), '129 Lockwood St', 'Newark', 'NJ', '07105', 'US', 'burl@maggert.com', '589-0421', 'PROSPECT', NULL),
            ('MKT', '1425005', 'Toni', 'Mattos', convert(date, '07/01/1973', 101), '3109 Main St', 'Melborne', 'FL', '32901', 'US', 'toni@mattos.com', '727-6512', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1425478', 'Josef', 'Taulman', convert(date, '04/29/1989', 101), '1620 Asheville Hwy', 'Hendersonville', 'NC', '28791', 'US', 'josef@taulman.com', '693-9775', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1427534', 'mike', 'larue', convert(date, '11/17/1977', 101), '109 N Mayo St', 'Americus', 'GA', '31709', 'US', 'mikelarue@amason.com', '229 924-2487', 'CUSTOMER', 'HIGH'),
            ('MKT', '1428866', 'Shauna', 'Ellerbusch', convert(date, '03/18/1985', 101), '1042 Ih 35 E', 'New Braunfels', 'TX', '78130', 'US', 'shauna@ellerbusch.com', '2591', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1429319', 'Oscar', 'Graniela', convert(date, '03/22/1990', 101), '6905 E Us Highway 87', 'San Antonio', 'TX', '78263', 'US', 'oscar@graniela.com', '648-7659', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1429729', 'Cissy', 'Hysmith', convert(date, '09/26/1983', 101), '3200 W Market St #-108', 'Akron', 'OH', '44333', 'US', 'cecilia@hysmith.com', '864-0619', 'PROSPECT', NULL),
            ('MKT', '1432608', 'Merle', 'Cha', convert(date, '11/26/1986', 101), '450 S Australian Ave', 'West Palm Beach', 'FL', '33401', 'US', 'merle@cha.com', '832-1820', 'PROSPECT', NULL),
            ('MKT', '1433965', 'Ronnie', 'Ellerbusch', convert(date, '06/02/1995', 101), '1126 17th Ave', 'Monroe', 'WI', '53566', 'US', 'ron@ellerbusch.com', '325-2068', 'CUSTOMER', 'NORMAL'),
            ('MKT', '1438732', 'Callie', 'Aldaba', convert(date, '09/06/1976', 101), '2151 River Plaza Dr #-105', 'Sacramento', 'CA', '95833', 'US', 'callie@aldaba.com', '916-567-4449', 'CUSTOMER', 'NORMAL')
    ) AS stg(b_pubid, b_sourceid, first_name, last_name, date_of_birth, addstreet, addcity, addstate, addpostal_code, addcountry, source_email, source_phone, person_type, value_status)
    where not exists (
        select 1
        from semarchy_customer_b2c_mdm.dbo.sd_person dest
        where dest.b_sourceid = stg.b_sourceid
            and dest.b_pubid = stg.b_pubid
            /* duplicate data detection */
            and coalesce(dest.first_name, '') = coalesce(stg.first_name, '')
            and coalesce(dest.last_name, '') = coalesce(stg.last_name, '')
            and dest.date_of_birth = stg.date_of_birth
            and coalesce(dest.addstreet, '') = coalesce(stg.addstreet, '')
            and coalesce(dest.addcity, '') = coalesce(stg.addcity, '')
            and coalesce(dest.addstate, '') = coalesce(stg.addstate, '')
            and coalesce(dest.addcountry, '') = coalesce(stg.addcountry, '')
            and coalesce(dest.source_email, '') = coalesce(stg.source_email, '')
            and coalesce(dest.source_phone, '') = coalesce(stg.source_phone, '')
            and coalesce(dest.person_type, '') = coalesce(stg.person_type, '')
            and coalesce(dest.value_status, '') = coalesce(stg.value_status, '')
    )
end
