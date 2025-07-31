-- Enable Database Vault Operations Control on CDB and all PDBs (as c##dbv_owner_root on CDB)
CONN c##dbv_owner_root/dbv_owner_root123#@localhost:1521/FREE
EXEC DBMS_MACADM.ENABLE_APP_PROTECTION;
