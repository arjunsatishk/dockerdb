--Create privileges (as sys on PDB)
CONN sys/example123#@localhost:1521/FREEPDB1 as SYSDBA
GRANT CREATE SESSION, SET CONTAINER TO dbv_owner IDENTIFIED BY dbv_owner123#;
GRANT CREATE SESSION, SET CONTAINER TO dbv_owner_backup IDENTIFIED BY dbv_owner_backup123#;
GRANT CREATE SESSION, SET CONTAINER TO dbv_acctmgr IDENTIFIED BY dbv_acctmgr123#;
GRANT CREATE SESSION, SET CONTAINER TO dbv_acctmgr_backup IDENTIFIED BY dbv_acctmgr_backup123#;

-- Configure backup accounts (as sys on PDB)
CONN sys/example123#@localhost:1521/FREEPDB1  as SYSDBA
BEGIN
CONFIGURE_DV (
dvowner_uname         => 'dbv_owner_backup',
dvacctmgr_uname       => 'dbv_acctmgr_backup');
END;
/

-- Execute UTLRP (as sys on PDB)
CONN sys/example123#@localhost:1521/FREEPDB1  as SYSDBA
@?/rdbms/admin/utlrp.sql

-- Enable Data Vault (as dbv_owner_backup on PDB)
CONN dbv_owner_backup/dbv_owner_backup123#@localhost:1521/FREEPDB1
EXEC DBMS_MACADM.ENABLE_DV;

-- Restart DB
CONN sys/example123#@localhost:1521/FREEPDB1 as SYSDBA
ALTER PLUGGABLE DATABASE FREEPDB1 CLOSE IMMEDIATE;
ALTER PLUGGABLE DATABASE FREEPDB1 OPEN;

-- Grant access to additional users
CONN dbv_acctmgr_backup/dbv_acctmgr_backup123#@localhost:1521/FREEPDB1
GRANT DV_ACCTMGR TO dbv_acctmgr WITH ADMIN OPTION CONTAINER=CURRENT;

CONN dbv_owner_backup/dbv_owner_backup123#@localhost:1521/FREEPDB1
GRANT DV_OWNER TO dbv_owner WITH ADMIN OPTION CONTAINER = CURRENT;
