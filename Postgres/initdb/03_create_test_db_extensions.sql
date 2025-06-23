--connect test_db
\connect test_db01

--add pg_stat_statements extension
create extension if not exists pg_stat_statements;

--add vector extension
create extension if not exists vector;

--add age extension
create extension if not exists age;

--set search path
alter database test_db01 set search_path to ag_catalog, "$user", public;