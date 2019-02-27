/*
 * SQL Server Insert Products Data
 * Semarchy xDM Tutorials
 * Run these insert statements to load product data into the Customer B2C
 * Demo Application.
 * Copyright (c) 2019 Semarchy
 */

DECLARE
        @LoadID integer


exec SEMARCHY_REPOSITORY..GET_CONTINUOUS_LOADID @LoadID output, 'CONTINUOUS_LOAD_INTEGRATE_ALL'


INSERT INTO SA_PRODUCT (B_LOADID, B_CLASSNAME, ID, PRODUCT_NAME, DESCRIPTION, ORIGIN, SALES_UNIT, PRICE)
VALUES (@LoadID, 'Product', 'FORCEP24461WD', 'Force Plane FX 2.0', 'Full Suspension Mountain Bike, disc breaks front and back, long-lasting aluminum frame. Adjustable suspenders.', 'USA', 'Each', 10049.99);

INSERT INTO SA_PRODUCT (B_LOADID, B_CLASSNAME, ID, PRODUCT_NAME, DESCRIPTION, ORIGIN, SALES_UNIT, PRICE)
VALUES (@LoadID, 'Product', 'STREAM4961WD', 'Streamliner Roadster ', 'High-tech, top-of-the line, carbon fiber frame. Road bike designed for racing on the weekends and commuting during week days. ', 'Japan', 'Each', 6999.0);

INSERT INTO SA_PRODUCT (B_LOADID, B_CLASSNAME, ID, PRODUCT_NAME, DESCRIPTION, ORIGIN, SALES_UNIT, PRICE)
VALUES (@LoadID, 'Product', 'CARBON6061WD', 'Carbonite Century ', 'Full carbon aerodynamic road bike with extra durable frame. Ultra lightweight. Disc brakes and mechanical shifting. ', 'USA', 'Each', 13499.0);

INSERT INTO SA_PRODUCT (B_LOADID, B_CLASSNAME, ID, PRODUCT_NAME, DESCRIPTION, ORIGIN, SALES_UNIT, PRICE)
VALUES (@LoadID, 'Product', 'CARBON4861OK', 'Carbonite Helmet', 'Aerodynamic helmet designed for hitting the road. Breathable design made for long bike rides. ', 'China', 'Each', 74.99);

INSERT INTO SA_PRODUCT (B_LOADID, B_CLASSNAME, ID, PRODUCT_NAME, DESCRIPTION, ORIGIN, SALES_UNIT, PRICE)
VALUES (@LoadID, 'Product', 'FOXYEL4961UY', 'Foxy Elite Cycling Shoes', 'Elite cycling clip-ins provide the most efficient and top-performance road shows. Super stiff soles keep feet cool. ', 'Vietnam', 'Each', 259.99);

INSERT INTO SA_PRODUCT (B_LOADID, B_CLASSNAME, ID, PRODUCT_NAME, DESCRIPTION, ORIGIN, SALES_UNIT, PRICE)
VALUES (@LoadID, 'Product', 'STREAM2061RS', 'Streamliner Saddle', 'Latest top-of-the line saddle with moisture wicking material to keep you cool while racing. Extra comfort for long commutes.', 'China', 'Each', 389.99);

INSERT INTO SA_PRODUCT (B_LOADID, B_CLASSNAME, ID, PRODUCT_NAME, DESCRIPTION, ORIGIN, SALES_UNIT, PRICE)
VALUES (@LoadID, 'Product', 'RENAUD4061LK', 'Renaud Martin Skin Suit', 'One-piece suit with the most aerodynamic and compressive materials. Tested by the Australian Tour de France team. ', 'France', 'Each', 384.96);
