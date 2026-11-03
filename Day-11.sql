use da8;

-- Numeric and String functions
select abs(-100) as Absolute_value;
select ceil(12.34) as Rounded_Up;
select floor(12.34) as Rounded_down;
select mod(123,5) as Remainder;
select pow(2,3) as Power_value;
select sqrt(81) as Square_roots;
select radians(180) as Radians_value;
select degrees(pi()) as Degree_value;
select sign(0) as Sign_value;
select rand() as random_numbers;
select greatest(-10,20,300,160) as Greatest_value;
select least(-10,20,300,160) as Least_value;

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

-- String Functions
select concat(first_name,' ',last_name) as Full_name from employees;
select first_name,upper(first_name) as Upper_name from employees;
select last_name,lower(last_name) as lower_name from employees;
select email,substring(email,1,5) as Email_Prfix from employees;
select first_name,length(first_name) as length_name from employees;
select phone_number,replace(phone_number,'-','') as Clean_phone from employees;
select * from employees;
insert into employees(emp_id,first_name) values (111,'   Sunny  ');
select first_name,trim(first_name) as Trimmed_name from employees;
select first_name,position('a' in first_name) as Position_of_a from employees;
select last_name,reverse(last_name) as Reversed_name from employees;
select last_name,left(last_name,3) as Short_name from employees;
select last_name,right(last_name,3) as Short_name from employees;
select last_name,lpad(last_name,10,'*') as Padded_name from employees;
select first_name,rpad(first_name,10,'_') as Padded_name from employees;

-- Date and Time Functions
select curdate() as Current__Date;
select curtime() as current__time;
select now() as current_date_time;
select sysdate() as System_date_time;
select date(now()) as Extracted_date;
select time(now()) as Extracted_time;
select year(now()) as year_part;
select month(now()) as month_part;
select day(now()) as day_part;
select dayofweek(now()) as Day_of_week;
select date_add(now(),interval 10 day) as New_date;
select date_sub(now(),interval 20 day) as Early_date;
select datediff(now(),'2005-01-13') as Alive_days;
select last_day(now()) as Last_day;
select makedate(2024,60) as Result_date;
select maketime(14,30,15) as Result_time;
select monthname(now()) as Month_name;
select dayname(now()) as Day_name;
select quarter(now()) as Quarteer_value;
select sec_to_time(3661) as Time_value;
select time_to_sec('01:01:01') as Sec_value;