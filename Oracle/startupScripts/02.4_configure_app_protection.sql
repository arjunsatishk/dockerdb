-- Enable Database Vault Operations Control (as c##dbv_owner_root_backup on CDB)
CONN c##dbv_owner_root_backup/dbv_owner_root_backup123#@localhost:1521/FREE
EXEC DBMS_MACADM.ENABLE_APP_PROTECTION;

-- Enable Database Vault Operations Control (as dbv_owner_backup on PDB)
CONN dbv_owner_backup/dbv_owner_backup123#@localhost:1521/FREEPDB1
EXEC DBMS_MACADM.ENABLE_APP_PROTECTION;
