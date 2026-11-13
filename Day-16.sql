use da8;
show tables;

create table student(
SID int primary key,
sname varchar(30),email varchar(30));

start transaction;
insert into student values
(111,'GOWTHAM','kgowtham7731@gmail.com'),
(222,'POOJITHA','pooja@codegnan'),
(333,'NANI','nani@codegnan');
commit;

select * from student;

start transaction;
delete from student where sid=222;

rollback;
select * from student;
-- it will work only on command line

start transaction;
insert into student values(444,'Ramu','Rama@krishna');
update student set sname='Karna' where sid=333;
savepoint sp1;
delete from student where sid=222;
rollback to sp1;
select * from student;
-- by using savepooint we can control how many functions we can rollback.alter

drop table department;
CREATE TABLE department (
	dept_id INT PRIMARY KEY AUTO_INCREMENT,
	dept_name VARCHAR(50),
	location VARCHAR(50)
);

drop table employee;
CREATE TABLE employee (
	emp_id INT PRIMARY KEY AUTO_INCREMENT,
	emp_name VARCHAR(100),
	dept_id INT,
	designation VARCHAR(50),
	salary DECIMAL(10,2),
	join_date DATE,
	FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

INSERT INTO department (dept_name, location) VALUES
('IT','Hyderabad'), ('HR','Bangalore'), ('Finance','Chennai'), ('Sales','Mumbai');
 
INSERT INTO employee (emp_name, dept_id, designation, salary, join_date) VALUES
('Rahul',1,'Software Engineer',55000,'2021-06-15'),
('Anita',2,'HR Executive',38000,'2020-03-21'),
('Suresh',4,'Sales Manager',52000,'2019-08-10'),
('Priya',1,'Team Lead',65000,'2022-01-05'),
('Kiran',3,'Finance Analyst',48000,'2018-12-11'),
('Deepika',2,'HR Manager',60000,'2019-10-19');
select*from department;
select*from employee;

-- view a virtual table
create view vw_employee_department as
select e.emp_id,e.emp_name,e.designation,d.dept_name,d.location
from employee e join department d 
 on e.dept_id=d.dept_id;
 
 select * from vw_employee_department;
 
create view vw_department_salary as
select d.dept_name,
count(e.emp_id) as total_employees,
sum(e.salary) as total_salary,
avg(e.salary) as Average_salary
from employee e join department d
on e.dept_id=d.dept_id
group by dept_name;

select * from vw_department_salary;

create view vw_Yearly_salary as
select emp_name,salary as monthly_salary,
salary*12 as Yearly_salary
from employee;
select * from vw_Yearly_salary;

set sql_safe_updates=0;
update vw_yearly_salary set monthly_salary=35000 where emp_name='Rahul';
select * from vw_Yearly_salary;
select * from employee;

ALTER VIEW VW_EMPLOYEE_DEPARTMENT AS
SELECT E.EMP_ID,E.EMP_NAME,D.DEPT_NAME
FROM EMPLOYEE E JOIN DEPARTMENT D ON E.DEPT_ID=D.DEPT_ID;
SELECT*FROM VW_EMPLOYEE_DEPARTMENT;

DROP VIEW VW_EMPLOYEE_DEPARTMENT;