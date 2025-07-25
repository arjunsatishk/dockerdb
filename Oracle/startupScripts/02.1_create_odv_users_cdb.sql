--Create users (as sys on CDB)
GRANT CREATE SESSION, SET CONTAINER TO c##dbv_owner_root IDENTIFIED BY dbv_owner_root123# CONTAINER = ALL;
GRANT CREATE SESSION, SET CONTAINER TO c##dbv_owner_root_backup IDENTIFIED BY dbv_owner_root_backup123# CONTAINER = ALL;
GRANT CREATE SESSION, SET CONTAINER TO c##dbv_acctmgr_root IDENTIFIED BY dbv_acctmgr_root123# CONTAINER = ALL;
GRANT CREATE SESSION, SET CONTAINER TO c##dbv_acctmgr_root_backup IDENTIFIED BY dbv_acctmgr_root_backup123# CONTAINER = ALL;

--Create user profile (as sys on CDB)
CREATE PROFILE c##dv_profile limit
FAILED_LOGIN_ATTEMPTS UNLIMITED
PASSWORD_VERIFY_FUNCTION ORA12C_VERIFY_FUNCTION
PASSWORD_LOCK_TIME UNLIMITED
CONTAINER=ALL;

--Assign user profile (as sys on CDB)
ALTER USER c##dbv_owner_root PROFILE c##dv_profile CONTAINER = ALL;
ALTER USER c##dbv_owner_root_backup PROFILE c##dv_profile CONTAINER = ALL;
ALTER USER c##dbv_acctmgr_root PROFILE c##dv_profile CONTAINER = ALL;
ALTER USER c##dbv_acctmgr_root_backup PROFILE c##dv_profile CONTAINER = ALL;

--Create audit policies (as sys on CDB)
CREATE AUDIT POLICY dv_logins_root ACTIONS LOGON;
AUDIT POLICY dv_logins_root BY USERS WITH GRANTED ROLES DV_OWNER, DV_ACCTMGR WHENEVER NOT SUCCESSFUL;
