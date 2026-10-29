use da8;
show tables;

drop table products;
CREATE TABLE Products (
 id INT,
 name VARCHAR(100),
 price DECIMAL(10,2),
 qty INT
 );
 
 INSERT INTO Products VALUES
 (1, 'Pen', 10.00, 100),
 (2, 'Notebook', 25.00, 50),
 (3, 'Pencil', 5.00, 200),
 (4, 'Eraser', 3.00, 300),
 (5, 'Marker', 15.00, 80),
 (6, 'Scale', 20.00, 150),
 (7, 'Sharpener', 8.00, 120),
 (8, 'Geometry Box', 120.00, 40),
 (9, 'Sketch Pen', 60.00, 75),
 (10, 'Crayons', 90.00, 55);
 
 select * from products;
 
 -- 1. Calculate total value of each product adding tax of 12 percent.
 select name,price,(price*1.12) as price_with_tax from products;
 -- 2. Calculate discounted price by subtracting price with 5 rs.
 select name,price,(price-5) as discounted_price from products;
 -- 3. Total inventory value of each product.
 select name,price,qty,(price*qty) as inventory_value from products;
 -- 4. Calculate price per 10 units.
 select name,price,(price*10) AS price_per_10 from products;
 -- 5. Find products where quantity is not a multiple of 50.
 select name,qty,(qty%50!=0) as price_not_50 from products;
 
 set sql_safe_updates=0;
 select * from products;
 
 -- 1. Add 2 quantity to all products.
 update products set qty=qty+2;
 -- 2. subtract 5 from price of each product.
 update products set price=price-5;
 -- 3. Double the quantity of erasers.
 update products set qty=qty*2 where name='Eraser';
 -- 4. Halve the quantity of markers.
 update products set qty=qty/2 where name='Marker';
 -- 5. Delete products where quantity is less than 100.
 delete from products where qty<100;
 delete from products where price<10;
 
 select * from products;
 
 CREATE TABLE StudentScores (
 id INT,
 name VARCHAR(100),
 subject VARCHAR(50),
 marks INT
 );

INSERT INTO StudentScores VALUES
 (1, 'Alice', 'Math', 95),
 (2, 'Bob', 'Math', 76),
 (3, 'Charlie', 'Math', 59),
 (4, 'Diana', 'Math', 88),
 (5, 'Eve', 'Math', 40),
 (6, 'Frank', 'Math', 95),
 (7, 'Grace', 'Science', 67),
 (8, 'Henry', 'Science', 82),
 (9, 'Ivy', 'English', 91),
 (10, 'Jack', 'English', 55),
 (11, 'Kevin', 'Math', 73),
 (12, 'Lily', 'Science', 48),
 (13, 'Mia', 'English', 100),
 (14, 'Noah', 'Math', 64),
 (15, 'Olivia', 'Science', 79);

SELECT*FROM STUDENTSCORES;

-- 1. Students who scored more than 80.
select * from studentscores where marks>80;
-- 2. Students who scored 60 or more.
select * from studentscores where marks>=60;
-- 3. Students who scored less than 50.
select * from studentscores where marks<50;
-- 4. Students who scored 95.
select * from studentscores where marks=95;
-- 5. Students who did not scored 95.
select * from studentscores where marks!=95;
-- 6. Students who scored 60 or less.
select * from studentscores where marks<=60;

select * from studentscores;

update studentscores set marks=marks+10 where marks<50;
update studentscores set marks=marks+5 where marks<=60;
update studentscores set marks=marks+2 where marks>90;
update studentscores set marks=marks+3 where marks>=80;
update studentscores set marks=marks-1 where marks!=95;
update studentscores set marks=100 where marks=95;

select * from studentscores;
 
delete from studentscores where marks<50;
delete from studentscores where marks<=60;
delete from studentscores where marks>90;
delete from studentscores where marks>90;
delete from studentscores where marks>=80;
delete from studentscores where marks!=95;
delete from studentscores where marks=76;

select * from studentscores;

drop table employees;
CREATE TABLE Employees (
   id INT,
   name VARCHAR(100),
   department VARCHAR(100),
   salary INT,
   isactive BOOLEAN
);
insert into employees values
(1, 'Rahul Sharma', 'IT', 50000, TRUE),
(2, 'Priya Reddy', 'HR', 30000, TRUE),
(3, 'Amit Kumar', 'Finance', 45000, FALSE),
(4, 'Sneha Patel', 'IT', 35000, TRUE),
(5, 'Vikram Singh', 'Finance', 28000, TRUE),
(6, 'Anjali Mehta', 'HR', 32000, FALSE),
(7, 'Kiran Rao', 'IT', 60000, TRUE),
(8, 'Pooja Verma', 'Marketing', 27000, TRUE);
select * from employees;

select * from employees where department='IT' and salary>40000;
select * from employees where department='HR' or salary<35000;
select * from employees where not department='HR';
select * from employees where department='Finance' or (salary>30000 and isactive=True);

select * from employees;

update employees set salary=salary+2000 where department='IT' and isactive=true and salary<60000;
update employees set salary=salary*0.9 where department='Finance' or isactive=false;

