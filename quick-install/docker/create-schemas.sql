-- Creates the Semarchy xDM schemas for a demo environment.

CREATE SCHEMA extensions;
GRANT USAGE ON SCHEMA extensions TO PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA extensions GRANT EXECUTE ON FUNCTIONS TO PUBLIC;
ALTER DATABASE postgres SET SEARCH_PATH TO "$user",public,extensions;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp"     with schema extensions;
CREATE EXTENSION IF NOT EXISTS "fuzzystrmatch" with schema extensions;

-- Create the repository user

CREATE USER   semarchy_repository WITH PASSWORD 'semarchy_repository';
CREATE SCHEMA semarchy_repository AUTHORIZATION semarchy_repository;
GRANT USAGE ON SCHEMA semarchy_repository TO public;

-- Create the repository read-only
CREATE USER semarchy_repository_ro WITH PASSWORD 'semarchy_repository_ro';
-- Granting database access to that user
GRANT CONNECT ON DATABASE postgres to semarchy_repository_ro;

-- Grant access to the repository schema
GRANT USAGE ON SCHEMA semarchy_repository TO semarchy_repository_ro;
-- Set the search path to include the repository
ALTER ROLE semarchy_repository_ro SET SEARCH_PATH TO "$user",semarchy_repository,public,extensions;
