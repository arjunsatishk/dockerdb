--create user
create user test_usr01 with password 'test_usr01#';

--create database
create database test_db01;
alter database test_db01 owner to test_usr01;

--create schema
\connect test_db01

create schema test_schema01;
alter schema test_schema01 owner to test_usr01;