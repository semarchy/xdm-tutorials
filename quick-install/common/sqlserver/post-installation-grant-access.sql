/*******************************************************************************
** SQL Server database post-installation scripts
** Semarchy xDM Tutorials
** Copy and paste the SQL DDL scripts and use them in the tutorial.
** Copyright (c) 2021 Semarchy
*******************************************************************************/

/************************************************
Grant the read-only user access to the repository
************************************************/
USE SEMARCHY_REPOSITORY
GO
GRANT SELECT ON PRF_PROFILING TO SEMARCHY_REPOSITORY_RO;
GRANT SELECT ON PRF_TABLE TO SEMARCHY_REPOSITORY_RO;
GRANT SELECT ON PRF_COLUMN TO SEMARCHY_REPOSITORY_RO;
GRANT SELECT ON PRF_DIST_VALS TO SEMARCHY_REPOSITORY_RO;
GRANT SELECT ON PRF_DIST_PATTERNS TO SEMARCHY_REPOSITORY_RO;