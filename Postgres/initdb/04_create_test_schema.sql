--connect test_db
\connect test_db01

--create schema
create schema test_schema01;
alter schema test_schema01 owner to test_usr01;
