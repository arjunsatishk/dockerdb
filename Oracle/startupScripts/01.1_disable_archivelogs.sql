--Disable forced logging
ALTER DATABASE NO FORCE LOGGING;

-- Restart CDB in mount mode
SHUTDOWN IMMEDIATE;
STARTUP MOUNT;

--Disable archived log mode
ALTER DATABASE NOARCHIVELOG;

--Open CDB in read-write mode
ALTER DATABASE OPEN;
