-- String Functions

use assignments;
show tables;

drop table employees;
CREATE TABLE employees (
	emp_id INT PRIMARY KEY,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	email VARCHAR(60),
	phone_number VARCHAR(20),
	department VARCHAR(30),
	city VARCHAR(30),
	salary DECIMAL(10,2)
);

INSERT INTO employees VALUES
(101,'Rahul','Kumar','rahul.kumar@gmail.com','987-654-3210','IT','Hyderabad',45000),
(102,'Anita','Sharma','anita.sharma@yahoo.com','912-345-6789','HR','Bangalore',38000),
(103,'Suresh','Verma','suresh.verma@gmail.com','998-123-4567','Sales','Chennai',52000),
(104,'Priya','Singh','priya.singh@outlook.com','900-456-7890','Finance','Pune',47000),
(105,'Rahul','Joshi','rahul.joshi@gmail.com','955-888-1111','Testing','Delhi',41000),
(106,'Kiran','Reddy','kiran.reddy@gmail.com','901-222-3333','IT','Hyderabad',56000),
(107,'Deepika','Naidu','deepika.naidu@yahoo.com','944-111-2222','HR','Vizag',39000),
(108,'Mahesh','Patel','mahesh.patel@gmail.com','933-444-5555','Sales','Mumbai',62000),
(109,'Divya','Gupta','divya.gupta@gmail.com','955-777-8888','Finance','Delhi',49000),
(110,'Arjun','Rao','arjun.rao@gmail.com','988-999-7777','Developer','Hyderabad',68000);

SELECT*FROM EMPLOYEES;

-- MySQL String Functions – 20 Practice Questions

-- Find employees whose first_name starts with 'R'.
select * from employees where first_name like 'r%';
-- Find employees whose email contains 'yahoo'.
select * from employees where email like '%yahoo%';
-- Display full name along with department as a single string.
select concat(first_name,' ',last_name) as full_name, department from employees;
-- Find the length of every email address.
select email,length(email) as count_email from employees;
--  Find employees whose first_name has more than 5 characters.
select * from employees where length(first_name)>5;
-- Replace 'gmail.com' with 'company.com' in email.
select replace(email,'gmail.com','company.com') as updated_email from employees;
-- Find the position of the '@' symbol in email.
SELECT email, INSTR(email,'@') AS position_at FROM employees;
-- Extract the username part of email (before '@') using SUBSTRING_INDEX().
SELECT email, SUBSTRING_INDEX(email, '@', 1) AS username FROM employees;
-- Extract the domain part of email (after '@') using SUBSTRING_INDEX().
SELECT email, SUBSTRING_INDEX(email, '@', -1) AS domain FROM employees;
-- Find employees whose last_name ends with 'a'.
select * from employees where last_name like'%a';
-- Display full name in uppercase for employees in the IT department.
select upper(concat(first_name,' ',last_name)) as fulL_name from employees where department='IT';
-- Find first names that are duplicated among employees.
select first_name,count(*) as dup_count from employees group by first_name having count(*)>1;
-- Format phone numbers by removing all dashes.
select replace(phone_number,'-','') as new_phone from employees;
-- Find employees whose first_name contains the letter 'i'.
select * from employees where first_name like '%i%';
-- Sort employees by the length of their first_name.
select * from employees order by length(first_name);
-- Find employees whose city name has more than 6 characters.
select * from employees where length(city)>6;
-- Build a formatted string "Name - Department" for every employee.
select concat(first_name,' ',last_name,' - ',department) as formatted from employees;
-- Display the initials of each employee (first letter of first and last name).
SELECT CONCAT(LEFT(first_name, 1), LEFT(last_name, 1)) AS initials FROM employees;
-- Remove leading and trailing spaces from employee names.
select trim(first_name) as clean_first,trim(last_name) as clean_last from employees;
-- Display the first three characters of every employee's first_name.
SELECT LEFT(first_name, 3) from employees;

-- Date And Time Functions
CREATE TABLE employee_attendance
(
	emp_id INT PRIMARY KEY AUTO_INCREMENT,
	emp_name VARCHAR(100),
	department VARCHAR(50),
	joining_date DATE,
	birth_date DATE,
	login_time DATETIME,
	logout_time DATETIME,
	salary DECIMAL(10,2)
);
INSERT INTO employee_attendance
(emp_name, department, joining_date, birth_date, login_time, logout_time, salary)
VALUES
('Rahul','IT','2021-06-15','1998-05-10','2024-11-20 09:05:10','2024-11-20 18:15:30',55000),
('Sneha','HR','2020-03-21','1996-11-18','2024-11-21 08:55:20','2024-11-21 17:45:50',48000),
('Arjun','Finance','2019-08-10','1994-07-30','2024-11-22 09:15:45','2024-11-22 18:35:20',62000),
('Priya','IT','2022-01-05','2000-01-25','2024-11-23 09:00:00','2024-11-23 17:55:40',51000),
('Kiran','Admin','2018-12-11','1992-09-15','2024-11-24 08:40:30','2024-11-24 17:30:00',45000),
('Anjali','Testing','2023-04-17','1999-12-20','2024-11-25 09:12:10','2024-11-25 18:05:00',47000),
('Vijay','IT','2021-09-14','1997-04-08','2024-11-26 09:08:15','2024-11-26 18:20:40',59000),
('Divya','HR','2019-10-19','1995-06-11','2024-11-27 08:50:30','2024-11-27 17:42:15',50000),
('Ramesh','Finance','2017-07-01','1991-08-14','2024-11-28 09:03:00','2024-11-28 18:12:00',70000),
('Pooja','Testing','2022-05-09','2001-03-19','2024-11-29 09:18:50','2024-11-29 18:25:10',53000);

SELECT*FROM employee_attendance;

-- Basic Level Date And Time Practicing Questions

-- Display only the date part from every employee's login time.
select date(login_time) as date_part from employee_attendance;
-- Display only the time part from every employee's login time.
select time(login_time) as time_part from employee_attendance;
-- Display employee names along with their joining year.
select emp_name,year(joining_date) as Join_year from employee_attendance;
-- Display employee names along with their birth month number.
select emp_name,month(birth_date) as birth_month from employee_attendance;
-- Display employee names and day of birth.
select emp_name,day(birth_date) as birth_day from employee_attendance;
-- Display the week number of every employee's joining date.
select emp_name,week(joining_date) as joining_week from employee_attendance;
-- Display the weekday number of each employee's joining date.
select emp_name,weekday(joining_date) as joining_week_day from employee_attendance;
-- Add 30 days to every employee's joining date.
select joining_date,date_add(joining_date,interval 30 day) as after_30 from employee_attendance;
-- Subtract 15 days from every employee's joining date.
select joining_date,date_sub(joining_date,interval 15 day) as before_15 from employee_attendance;
-- Find how many days each employee has worked from joining date until today.
select emp_name,joining_date,datediff(curdate(),joining_date) as days_worked from employee_attendance;
-- Find the number of days between login time and logout time.
SELECT login_time, logout_time, TIMESTAMPDIFF(DAY, login_time, logout_time)
 AS days_difference FROM employee_attendance;
-- Display the Unix timestamp of login_time.
SELECT login_time,UNIX_TIMESTAMP(login_time) AS unix_timestamp FROM employee_attendance;
-- Convert Unix timestamp 1700000000 into DateTime.
SELECT FROM_UNIXTIME(1700000000) AS datetime_value;
-- Display the last day of each employee's joining month.
SELECT emp_name, joining_date,LAST_DAY(joining_date)
AS last_day_of_month FROM employee_attendance;
-- Display the month name and day name of every employee's birth date.
select monthname(birth_date),dayname(birth_date) from employee_attendance;


-- Advanced Level

-- Display employees who joined in the current year.
select * from employee_attendance where year(curdate())=year(joining_date);
-- Display employees born in November.
select * from employee_attendance where monthname(birth_date)='November';
-- Display employees whose joining month is June.
select * from employee_attendance where monthname(joining_date)='june';
-- Display employees whose birthday falls on the 10th day.
select * from employee_attendance where day(birth_date)=10;
-- Display employees who joined in Quarter 2.
select * from employee_attendance where quarter(joining_date)=2;
-- Display employee names and their age in years using TIMESTAMPDIFF().
select emp_name,timestampdiff(year,birth_date,curdate()) as age from employee_attendance;
-- Display employees who have completed more than 3 years in the company.
select * from employee_attendance where timestampdiff(year,joining_date,curdate())>3;
-- Display employee names and their total working hours.
select emp_name,timestampdiff(hour,login_time,logout_time) as aworking_hours from employee_attendance;
-- Display employee names and working minutes.
select emp_name,timestampdiff(minute,login_time,logout_time) as working_minutes from employee_attendance;
-- Display employees whose login time is before 9 AM.
select * from employee_attendance where time(login_time)<'09:00:00';
-- Display employees who logged in after 9:10 AM.
select * from employee_attendance where time(login_time)>'09:10:00';
-- Display employees whose joining date falls on Monday.
select * from employee_attendance where dayname(joining_date)='Monday';
-- Display employees whose birth month name starts with 'J'.
select * from employee_attendance where monthname(birth_date) like 'j%';
-- Display employees who joined in Week Number 25.
select * from employee_attendance where week(joining_date)=25;
-- Display employee names and the last day of their birth month.
select emp_name,last_day(birth_date) as last_day from employee_attendance;
-- Display employee names with joining date after adding one year.
select emp_name,date_add(joining_date,interval 365 day) as after_1yr_join from employee_attendance;
-- Display employee names with joining date before subtracting two months.
select emp_name,date_sub(joining_date,interval 61 day) as before_2months from employee_attendance;
-- Display employees who were born in the current year.
select * from employee_attendance where year(birth_date)=year(curdate());
-- Display employee names along with their joining date in the format DD-MM-YYYY.
select emp_name,date_format(joining_date,'%d-%m-%Y') as formatted from employee_attendance;
-- Display employee names along with their login date in the format DD-MONTH-YYYY.
select emp_name,date_format(joining_date,'%d-%M-%Y') as formatted from employee_attendance;
