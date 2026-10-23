use da8;
show tables;
drop table employees;
show tables;

create table employees(
Empid char(5), Fname varchar(50),
Lname varchar(50), Age int,
DOJ date, Address tinytext,
Dept varchar(20));

desc employees;

alter table employees modify Lname varchar(30);
alter table employees modify Fname varchar(20);
desc employees;

alter table employees add PFID int after Address;
alter table employees add Location tinytext;
alter table employees add Company_Name text first;
desc employees;

alter table employees change Fname FirstName varchar(30);
alter table employees change Lname LastName varchar(30);
desc employees;

alter table employees drop column Company_Name;
alter table employees drop column PFID;
alter table employees drop column Location;
desc employees;

alter table employees rename to Codegnan_emp;
show tables;
alter table Codegnan_emp rename to employees;

create table company_staff(
EmpID int, Age tinyint,
Experience smallint, Gender char(1),
Emp_Name varchar(50), Address tinytext,
Salary decimal(10,2),
Department enum('HR','IT','Sales','Finance','Support'),
Skills set('Java','Python','SQL','Excel','Communication'),
Joining_Date date);

alter table company_staff modify EmpID int primary key;
desc company_staff;
show tables;

alter table company_staff add email varchar(100);
alter table company_staff add Phone_Number bigint;
alter table company_staff add Bonus decimal(8,2) after Salary;
alter table company_staff add Status varchar(20) after Department;
alter table company_staff add Company_Name varchar(50) first;
alter table company_staff add Qualification varchar(50) after Emp_Name;
alter table company_staff modify Emp_Name varchar(100);
alter table company_staff modify Salary decimal(12,2);
alter table company_staff change Emp_Name Employee_Name varchar(100);
alter table company_staff change Joining_Date Date_Of_Joining date;
alter table company_staff drop column Bonus;
alter table company_staff drop column Phone_Number;
alter table company_staff rename to Staff_Records;
desc Staff_Records;
alter table Staff_records add Last_Updated date after Skills;
alter table Staff_records rename to Company_Staff;
desc Company_Staff;
