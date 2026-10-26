use da8;
show tables;
desc employees;

insert into employees(Empid, FirstName, LastName, Age, DOJ, Address, Dept)
values
('EMP01','KANNURU','GOWTHAM',21,'2024-02-14','VSP','IT');

insert into employees(Empid, FirstName, LastName, Age, DOJ, Address, Dept)
values
('EMP02','BUSHIPAKA','POOJITHA',17,'2026-03-11','HYD','SALES'),
('EMP03','DUDA','MANOJ',22,'2024-06-15','VSP','HR'),
('EMP04','KUNDRAPU','RAJU',28,'2015-05-01','VZM','TESTING');

insert into employees values
('EMP05','ALAPATI','VARUN SRI TEJA',20,'2024-06-30','RJM','MARKETING'),
('EMP06','OMKAR','ASHOK',23,'2020-09-03','BAN','SERVICE');

insert into employees(Empid,LastName,Age,DOJ,Address)
values
('EMP07','KARNA',32,'2000-01-01','ANGA');

insert into employees(Empid,FirstName,Age,Address,Dept)
values
('EMP08','KRISHNA',99,'DWK','HR');

insert into employees set
Empid='EMP09',FirstName='KARRA',LastName='KARTHIK',Age=25,DOJ='2022-10-19',Address='NOIDA',Dept='QA';

select * from employees;

set sql_safe_updates=0;
update employees set age=18 where Empid='EMP02';
select * from employees where Empid='EMP02';

update employees set LastName='VARUN' where dept='MARKETING';
update employees set DOJ='2026-10-24' where FirstName='KRISHNA';
update employees set dept='SALES' where LastName='KARNA';
update employees set LastName='RADHA' where age=99;
update employees set FirstName='ANGRAJ' where Address='ANGA';

select * from employees;

delete from employees where FirstName='KARRA';
delete from employees where Dept='Sales';
delete from employees where (Address='VSP' and Dept='HR');

select * from employees;

create database assginments;

