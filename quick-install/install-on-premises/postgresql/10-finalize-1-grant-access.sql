/*******************************************************************************
** Oracle database post-installation scripts
** Semarchy xDM Tutorials
** Copy and paste the SQL DDL scripts and use them in the tutorial.
** Copyright (c) 2021 Semarchy
*******************************************************************************/

/************************************************
Grant the read-only user access to the repository
************************************************/
GRANT SELECT ON TABLE
    semarchy_repository.PRF_PROFILING,
    semarchy_repository.PRF_TABLE,
    semarchy_repository.PRF_COLUMN,
    semarchy_repository.PRF_DIST_VALS,
    semarchy_repository.PRF_DIST_PATTERNS
TO semarchy_repository_ro;