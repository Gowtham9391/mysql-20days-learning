CREATE DATABASE companydb;

USE companydb;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    experience INT,
    city VARCHAR(50),
    age INT
);

INSERT INTO employees
VALUES
(101, 'Ravi', 'IT', 45000, 2, 'Hyderabad', 24),
(102, 'Kiran', 'HR', 40000, 3, 'Vijayawada', 27),
(103, 'Suresh', 'IT', 55000, 5, 'Hyderabad', 30),
(104, 'Anil', 'Sales', 35000, 1, 'Chennai', 23),
(105, 'Priya', 'Finance', 60000, 6, 'Bangalore', 32),
(106, 'Sneha', 'IT', 50000, 4, 'Vizag', 28),
(107, 'Rahul', 'HR', 42000, 2, 'Hyderabad', 25),
(108, 'Arjun', 'Sales', 38000, 3, 'Chennai', 26),
(109, 'Divya', 'Finance', 65000, 7, 'Bangalore', 34),
(110, 'Manoj', 'IT', 70000, 8, 'Hyderabad', 35);

SELECT*FROM EMPLOYEES;

delimiter //
create procedure GETITEMPLOYEES()
BEGIN
select * from employees where department='IT';
end //
delimiter ;
call GETITEMPLOYEES;

DELIMITER //
create procedure exp_above5()
begin
select * from employees where experience>5;
end //
delimiter ;
call exp_above5();

delimiter //
create procedure GETEMPSBYDEPT(IN DEPT varchar(20))
begin
select * from employees where department=dept;
end //
delimiter //
call GETEMPSBYDEPT('Finance');

delimiter //
create procedure GetEmpsBySalary(in sal int)
begin
select * from employees where salary=sal;
end //
delimiter ;
call GetEmpsBySalary(60000);

set sql_safe_updates=0;
delimiter //
create procedure IncrementByEXP(in exp int, in sal decimal(10,2))
begin
update employees set salary=salary+sal where experience>exp;
end //
delimiter ;
call IncrementByEXP(6,20000);

delimiter //
create procedure GetEmpBySalaryRange(in sal1 decimal(10,2),in sal2 decimal(10,2))
begin
select * from employees where salary>sal1 and salary<sal2;
end //
delimiter ;
call GetEmpBySalaryRange(50000,90000);

delimiter //
create procedure GetITEmpsByOut2(out ITEmps int)
begin
select count(*) into ITEmps from employees where department='IT';
end //
delimiter ;
call GetITEmpsByOut2(@G);
select(@G);

delimiter //
create procedure ADDBONUS(in empid int,inout bonus decimal(10,2))
begin
update employees set salary=salary+bonus where emp_id=empid;
select salary into bonus from employees where emp_id=empid;
end //
delimiter ;
set @b=5000;
call ADDBONUS(101,@b);
select @b;

delimiter //
create procedure DEDUCTSALARY(in empid int,inout sal decimal(10,2))
begin
update employees set salary=salary-sal where emp_id=empid;
select salary into sal from employees where emp_id=empid;
end //
delimiter ;
set @d=5000;
call DEDUCTSALARY(101,@d);
select @d;