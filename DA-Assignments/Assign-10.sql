use assignments;
show tables;

-- PART 1: TABLE CREATION AND SAMPLE RECORDS
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product VARCHAR(50),
    category VARCHAR(50),
    units_sold INT,
    unit_price INT,
    region VARCHAR(50)
);
INSERT INTO sales
(sale_id, product, category, units_sold, unit_price, region)
VALUES
(1, 'Keyboard', 'Electronics', 10, 1200, 'North'),
(2, 'Monitor', 'Electronics', 5, 7000, 'South'),
(3, 'Chair', 'Furniture', 15, 2500, 'North'),
(4, 'Desk', 'Furniture', 7, 4500, 'West'),
(5, 'Mouse', 'Electronics', 20, 800, 'East'),
(6, 'Sofa', 'Furniture', 3, 15000, 'South'),
(7, 'Headphones', 'Electronics', 8, 1800, 'North'),
(8, 'Laptop', 'Electronics', 6, 55000, 'West'),
(9, 'Table', 'Furniture', 12, 6000, 'East'),
(10, 'Fan', 'HomeAppliance', 18, 3000, 'South'),
(11, 'AC', 'HomeAppliance', 4, 35000, 'North'),
(12, 'Cupboard', 'Furniture', 5, 12000, 'West'),
(13, 'Printer', 'Electronics', 9, 9000, 'East'),
(14, 'Bed', 'Furniture', 2, 25000, 'South'),
(15, 'Mobile', 'Electronics', 14, 20000, 'North');
select * from sales;

-- WHERE CLAUSE
select product from sales where category='Electronics';
select product from sales where unit_price>10000;
select product from sales where region='North';
select product from sales where units_sold between 5 and 15;
select * from sales where category='Furniture' and unit_price>5000;

-- GROUP BY + HAVING
select category,sum(units_sold) as Total_units from sales group by category having Total_units>20;
select region,sum(unit_price*units_sold) as Revenue from sales group by region having revenue>50000;
select category,count(product) as Total_products from sales group by category having Total_products>2;
select category,avg(unit_price) as Avg_price from sales group by category having Avg_price<5000;
select region,count(category='Electronics') as Electronics_count from sales group by region having Electronics_count>1;

-- GROUP BY + ORDER BY
select category,sum(units_sold) as TOtal_units from sales group by category order by Total_units desc;
select region,avg(unit_price) as Avg_price from sales group by region order by region;
select category,sum(unit_price*units_sold) as Revenue from sales group by category order by revenue desc;
select region,count(product) as Total_products from sales group by region order by Total_products desc;
select region,sum(units_sold) as Total_units from sales group by region order by region;
 
-- GROUP BY + HAVING + ORDER BY
select region,sum(unit_price*units_sold) as Revenue from sales group by region
 having revenue>20000 order by revenue desc;
select category,sum(units_sold) as TOtal_units from sales group by category
 having TOtal_units>10 order by category;
select region,count(product) as Total_products from sales group by region
having Total_products>1 order by region;
select category,avg(unit_price) as Avg_price from sales group by category
having Avg_price<6000 order by Avg_price;
select category,avg(units_sold) as Avg_units from sales group by category
having Avg_units>5 order by Avg_units desc;

-- WHERE + GROUP BY + HAVING + ORDER BY
select region,sum(units_sold) as Total_units from sales
where category='Electronics' group by region
having Total_units>15 order by Total_units desc;

select category,sum(unit_price*units_sold) as Revenue from sales
where unit_price>2000 group by category
having Revenue>100000 order by revenue desc;

select region,avg(unit_price) as Avg_price from sales
where units_sold>=5 group by region
having Avg_price>5000 order by region;

select category,count(product) as Total_products from sales
where region in ('North','South') group by category
having Total_products>2 order by Total_products desc;

select region,sum(unit_price*units_sold) as Revenue from sales
where unit_price<10000 group by region
having revenue>50000 order by revenue desc;
