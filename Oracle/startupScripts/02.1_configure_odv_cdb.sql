--Create users (as sys on CDB)
GRANT CREATE SESSION, SET CONTAINER TO c##dbv_owner_root IDENTIFIED BY dbv_owner_root123# CONTAINER = ALL;
GRANT CREATE SESSION, SET CONTAINER TO c##dbv_owner_root_backup IDENTIFIED BY dbv_owner_root_backup123# CONTAINER = ALL;
GRANT CREATE SESSION, SET CONTAINER TO c##dbv_acctmgr_root IDENTIFIED BY dbv_acctmgr_root123# CONTAINER = ALL;
GRANT CREATE SESSION, SET CONTAINER TO c##dbv_acctmgr_root_backup IDENTIFIED BY dbv_acctmgr_root_backup123# CONTAINER = ALL;

-- Configure backup accounts (as sys on CDB)
BEGIN
CONFIGURE_DV (
dvowner_uname         => 'c##dbv_owner_root_backup',
dvacctmgr_uname       => 'c##dbv_acctmgr_root_backup',
force_local_dvowner   => FALSE);
END;
/

-- Execute UTLRP (as sys on CDB)
@?/rdbms/admin/utlrp.sql

-- Enable Data Vault (as c##dbv_owner_root_backup on CDB)
CONN c##dbv_owner_root_backup/dbv_owner_root_backup123#@localhost:1521/FREE
EXEC DBMS_MACADM.ENABLE_DV (strict_mode => 'n');

-- Grant access to additional users
CONN c##dbv_acctmgr_root_backup/dbv_acctmgr_root_backup123#@localhost:1521/FREE
GRANT DV_ACCTMGR TO c##dbv_acctmgr_root WITH ADMIN OPTION CONTAINER=ALL;

CONN c##dbv_owner_root_backup/dbv_owner_root_backup123#@localhost:1521/FREE
GRANT DV_OWNER TO c##dbv_owner_root WITH ADMIN OPTION CONTAINER = ALL;
