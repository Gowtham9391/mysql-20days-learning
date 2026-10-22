create database pfs8;
drop database pfs8;

create database DA8;
show databases;
USE DA8;

create table Employees(
EMPID CHAR(5), FNAME VARCHAR(50),
LNAME VARCHAR(50), AGE INT, DOJ DATE,
ADDRESS TINYTEXT, DEPT VARCHAR(20));

DESC EMPLOYEES;

