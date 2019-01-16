/*******************************************************************************
** PostgreSQL pgAdmin create schema scripts
** Semarchy xDM Tutorials
** Copy and paste the SQL DDL scripts and use them in the tutorial.
** Copyright (c) 2019 Semarchy
*******************************************************************************/

/******************************
Configure Database Schemas
******************************/
CREATE SCHEMA extensions;
GRANT USAGE ON SCHEMA extensions TO PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA extensions GRANT EXECUTE ON FUNCTIONS TO PUBLIC;
ALTER DATABASE postgres SET SEARCH_PATH TO "$user",public,extensions;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp"     with schema extensions;
CREATE EXTENSION IF NOT EXISTS "fuzzystrmatch" with schema extensions;

CREATE USER   semarchy_repository WITH PASSWORD 'semarchy_repository';
CREATE SCHEMA semarchy_repository AUTHORIZATION semarchy_repository;
GRANT USAGE ON SCHEMA semarchy_repository TO public;

CREATE USER   semarchy_product_retail_mdm WITH PASSWORD 'semarchy_product_retail_mdm';
CREATE SCHEMA semarchy_product_retail_mdm AUTHORIZATION semarchy_product_retail_mdm;
GRANT USAGE ON SCHEMA semarchy_product_retail_mdm TO public;

CREATE USER   semarchy_customer_b2c_mdm WITH PASSWORD 'semarchy_customer_b2c_mdm';
CREATE SCHEMA semarchy_customer_b2c_mdm AUTHORIZATION semarchy_customer_b2c_mdm;
GRANT USAGE ON SCHEMA semarchy_customer_b2c_mdm TO public;

CREATE USER   semarchy_emp_tutorial WITH PASSWORD 'semarchy_emp_tutorial';
CREATE SCHEMA semarchy_emp_tutorial AUTHORIZATION semarchy_emp_tutorial;
GRANT USAGE ON SCHEMA semarchy_emp_tutorial TO public;

CREATE USER   semarchy_b2b_tutorial WITH PASSWORD 'semarchy_b2b_tutorial';
CREATE SCHEMA semarchy_b2b_tutorial AUTHORIZATION semarchy_b2b_tutorial;
GRANT USAGE ON SCHEMA semarchy_b2b_tutorial TO public;

/* Cleanup scripts to start fresh */
/*
  DROP SCHEMA semarchy_repository CASCADE;
  DROP SCHEMA semarchy_product_retail_mdm CASCADE;
  DROP SCHEMA semarchy_customer_b2c_mdm CASCADE;
  DROP SCHEMA semarchy_emp_tutorial CASCADE;
  DROP SCHEMA semarchy_b2b_tutorial CASCADE;
*/

/******************************************************************************/
