 -- JEEVAN RAKSHA PHARMACY  |  END-TO-END MYSQL PROJECT
-- =====================================================================
--  Contents:
--    PART 1  : Database & Table Creation (schema)
--    PART 2  : Sample Data (INSERT statements)
--    PART 3  : Indexes
--    PART 4  : Views
--    PART 5  : Stored Procedures
--    PART 6  : Triggers (+ supporting stock_log table)
--    PART 7  : Query Bank - Level 1 (Original Q1-Q4)   + Answers
--    PART 8  : Query Bank - Level 2 (Original Q5-Q8)   + Answers
--    PART 9  : Query Bank - Level 3 (Original Q9-Q11)  + Answers
--    PART 10 : Query Bank - New Queries (Q12-Q21)      + Answers
--    PART 11 : Demo calls for Views / Procedures / Triggers
--
--  RDBMS   : MySQL 8.0+ (also compatible with MariaDB 10.x)
--  Notes   : Every ANSWER below each query is a comment showing what
--            that query returns when run against the sample data in
--            PART 2. Run the SELECT yourself to confirm.

-- PART 1: DATABASE & TABLE CREATION
-- =====================================================================
DROP DATABASE IF EXISTS jeevan_raksha_pharmacy;
CREATE DATABASE jeevan_raksha_pharmacy;
USE jeevan_raksha_pharmacy;

-- ---------- Strong Entity: CUSTOMERS ----------
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100),
    phone       VARCHAR(15),
    city        VARCHAR(50)
);

-- ---------- Strong Entity: SUPPLIERS ----------
CREATE TABLE suppliers (
    supplier_id    INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name  VARCHAR(100),
    contact_person VARCHAR(100),
    phone          VARCHAR(15)
);

-- ---------- Strong Entity: MEDICINES ----------
CREATE TABLE medicines (
    medicine_id    INT AUTO_INCREMENT PRIMARY KEY,
    name           VARCHAR(100),
    category       VARCHAR(50),
    price          DECIMAL(10,2),
    stock_quantity INT,
    expiry_date    DATE,
    supplier_id    INT,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- ---------- Strong Entity: ORDERS (Bills) ----------
CREATE TABLE orders (
    order_id     INT AUTO_INCREMENT PRIMARY KEY,
    customer_id  INT,
    order_date   DATE,
    total_amount DECIMAL(10,2),
    payment_mode ENUM('UPI', 'Cash', 'Card'),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ---------- Weak Entity: ORDER_ITEMS ----------
-- Cannot exist without a parent ORDER (identifying relationship).
-- True identity of a row = order_id (owner key) + item_id (partial key).
CREATE TABLE order_items (
    item_id     INT AUTO_INCREMENT PRIMARY KEY,
    order_id    INT,
    medicine_id INT,
    quantity    INT,
    subtotal    DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

-- PART 2: SAMPLE DATA
-- =====================================================================

-- Customers
INSERT INTO customers (name, phone, city) VALUES
('Rahul Sharma', '9876543210', 'Mumbai'),
('Priya Verma',  '9123456789', 'Delhi'),
('Amit Patel',   '9988776655', 'Ahmedabad'),
('Sneha Reddy',  '8877665544', 'Hyderabad'),
('Vikram Singh', '7766554433', 'Mumbai');

-- Suppliers
INSERT INTO suppliers (supplier_name, contact_person, phone) VALUES
('Apollo Distributors',   'Rajesh Gupta', '022-123456'),
('MedPlus Supply Chain',  'Suresh Nair',  '040-987654'),
('Himalaya Wellness',     'Anjali Mehta', '011-456789');

-- Medicines
INSERT INTO medicines (name, category, price, stock_quantity, expiry_date, supplier_id) VALUES
('Dolo 650',     'Tablet',    30.00,  500, '2025-12-31', 1),
('Azithral 500', 'Tablet',   120.00,   50, '2024-05-20', 1),
('Benadryl',     'Syrup',    110.00,   20, '2024-11-15', 2),
('Combiflam',    'Tablet',    45.00,  200, '2026-01-01', 3),
('Insulin Pen',  'Injection',800.00,    5, '2024-03-10', 2);

-- Orders (Bills)
INSERT INTO orders (customer_id, order_date, total_amount, payment_mode) VALUES
(1, '2023-10-01', 150.00,  'UPI'),
(2, '2023-10-02', 240.00,  'Card'),
(3, '2023-10-05',  45.00,  'Cash'),
(1, '2023-10-10', 800.00,  'UPI'),
(4, '2023-10-12',1200.00,  'Card');

-- Order Items
INSERT INTO order_items (order_id, medicine_id, quantity, subtotal) VALUES
(1, 1, 5, 150.00),  -- Rahul bought 5 Dolo 650
(2, 2, 2, 240.00),  -- Priya bought 2 Azithral 500
(3, 4, 1,  45.00),  -- Amit  bought 1 Combiflam
(4, 5, 1, 800.00),  -- Rahul bought 1 Insulin Pen
(5, 5, 1, 800.00),  -- Sneha bought 1 Insulin Pen
(5, 2, 2, 240.00),  -- Sneha bought 2 Azithral 500
(5, 1, 5, 150.00);  -- Sneha bought 5 Dolo 650

-- PART 3: INDEXES
-- =====================================================================
-- Foreign-key / frequently-filtered columns get explicit indexes to
-- speed up the JOINs and WHERE clauses used throughout this project.

CREATE INDEX idx_medicines_supplier   ON medicines(supplier_id);
CREATE INDEX idx_orders_customer      ON orders(customer_id);
CREATE INDEX idx_orderitems_order     ON order_items(order_id);
CREATE INDEX idx_orderitems_medicine  ON order_items(medicine_id);
CREATE INDEX idx_medicines_category   ON medicines(category);
CREATE INDEX idx_medicines_expiry     ON medicines(expiry_date);
CREATE INDEX idx_customers_city       ON customers(city);
CREATE INDEX idx_orders_paymentmode   ON orders(payment_mode);
CREATE INDEX idx_orders_date          ON orders(order_date);

-- Verify indexes:
-- SHOW INDEX FROM medicines;
-- SHOW INDEX FROM orders;
-- SHOW INDEX FROM order_items;

-- PART 4: VIEWS
-- =====================================================================

-- 4.1 Flattened order + customer info (for reporting/UI)
CREATE OR REPLACE VIEW view_order_details AS
SELECT
    o.order_id,
    c.name        AS customer_name,
    c.city        AS customer_city,
    o.order_date,
    o.total_amount,
    o.payment_mode
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- 4.2 Medicines that need reordering (stock below 50 units)
CREATE OR REPLACE VIEW view_low_stock AS
SELECT
    m.medicine_id,
    m.name,
    m.stock_quantity,
    s.supplier_name
FROM medicines m
JOIN suppliers s ON m.supplier_id = s.supplier_id
WHERE m.stock_quantity < 50;

-- 4.3 Lifetime spend per customer
CREATE OR REPLACE VIEW view_customer_spend AS
SELECT
    c.customer_id,
    c.name,
    COUNT(o.order_id)                 AS total_orders,
    COALESCE(SUM(o.total_amount), 0)  AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- 4.4 Best-seller ranking (quantity sold per medicine)
CREATE OR REPLACE VIEW view_medicine_sales AS
SELECT
    m.medicine_id,
    m.name,
    COALESCE(SUM(oi.quantity), 0) AS total_qty_sold
FROM medicines m
LEFT JOIN order_items oi ON m.medicine_id = oi.medicine_id
GROUP BY m.medicine_id, m.name;

-- PART 5: STORED PROCEDURES
-- =====================================================================

-- 5.1 All orders placed by one customer
DROP PROCEDURE IF EXISTS sp_get_customer_orders;
DELIMITER $$
CREATE PROCEDURE sp_get_customer_orders(IN p_customer_id INT)
BEGIN
    SELECT o.order_id, o.order_date, o.total_amount, o.payment_mode
    FROM orders o
    WHERE o.customer_id = p_customer_id
    ORDER BY o.order_date;
END $$
DELIMITER ;

-- 5.2 Place a new order for ONE medicine (transactional, stock-checked)
--     Creates the order + order_item; the trg_reduce_stock trigger
--     (PART 6) automatically decrements medicines.stock_quantity.
DROP PROCEDURE IF EXISTS sp_place_order;
DELIMITER $$
CREATE PROCEDURE sp_place_order(
    IN p_customer_id  INT,
    IN p_medicine_id  INT,
    IN p_quantity     INT,
    IN p_payment_mode VARCHAR(10)
)
BEGIN
    DECLARE v_price    DECIMAL(10,2);
    DECLARE v_stock    INT;
    DECLARE v_subtotal DECIMAL(10,2);
    DECLARE v_order_id INT;

    SELECT price, stock_quantity INTO v_price, v_stock
    FROM medicines
    WHERE medicine_id = p_medicine_id
    FOR UPDATE;

    IF v_stock < p_quantity THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Insufficient stock for this medicine';
    ELSE
        START TRANSACTION;
        SET v_subtotal = v_price * p_quantity;

        INSERT INTO orders (customer_id, order_date, total_amount, payment_mode)
        VALUES (p_customer_id, CURDATE(), v_subtotal, p_payment_mode);
        SET v_order_id = LAST_INSERT_ID();

        INSERT INTO order_items (order_id, medicine_id, quantity, subtotal)
        VALUES (v_order_id, p_medicine_id, p_quantity, v_subtotal);

        COMMIT;
    END IF;
END $$
DELIMITER ;

-- 5.3 Revenue report grouped by payment mode
DROP PROCEDURE IF EXISTS sp_revenue_by_mode;
DELIMITER $$
CREATE PROCEDURE sp_revenue_by_mode()
BEGIN
    SELECT payment_mode,
           SUM(total_amount) AS total_revenue,
           COUNT(*)          AS order_count
    FROM orders
    GROUP BY payment_mode;
END $$
DELIMITER ;

-- 5.4 Restock a medicine by a given quantity (logged automatically by
--     trg_restock_log in PART 6)
DROP PROCEDURE IF EXISTS sp_restock_medicine;
DELIMITER $$
CREATE PROCEDURE sp_restock_medicine(
    IN p_medicine_id INT,
    IN p_add_qty     INT
)
BEGIN
    UPDATE medicines
    SET stock_quantity = stock_quantity + p_add_qty
    WHERE medicine_id = p_medicine_id;
END $$
DELIMITER ;

-- PART 6: TRIGGERS
-- =====================================================================

-- 6.0 Supporting audit table for stock changes
CREATE TABLE stock_log (
    log_id      INT AUTO_INCREMENT PRIMARY KEY,
    medicine_id INT,
    change_qty  INT,
    change_type VARCHAR(20),
    change_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

-- 6.1 Reduce stock automatically whenever an order_item is inserted
DROP TRIGGER IF EXISTS trg_reduce_stock;
DELIMITER $$
CREATE TRIGGER trg_reduce_stock
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE medicines
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE medicine_id = NEW.medicine_id;

    INSERT INTO stock_log (medicine_id, change_qty, change_type)
    VALUES (NEW.medicine_id, -NEW.quantity, 'SALE');
END $$
DELIMITER ;

-- 6.2 Block an order_item if it would oversell the available stock
DROP TRIGGER IF EXISTS trg_prevent_negative_stock;
DELIMITER $$
CREATE TRIGGER trg_prevent_negative_stock
BEFORE INSERT ON order_items
FOR EACH ROW
BEGIN
    DECLARE v_stock INT;
    SELECT stock_quantity INTO v_stock
    FROM medicines WHERE medicine_id = NEW.medicine_id;

    IF v_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Cannot place order: insufficient stock';
    END IF;
END $$
DELIMITER ;

-- 6.3 Log every manual restock (stock_quantity increased on medicines)
DROP TRIGGER IF EXISTS trg_restock_log;
DELIMITER $$
CREATE TRIGGER trg_restock_log
AFTER UPDATE ON medicines
FOR EACH ROW
BEGIN
    IF NEW.stock_quantity > OLD.stock_quantity THEN
        INSERT INTO stock_log (medicine_id, change_qty, change_type)
        VALUES (NEW.medicine_id, NEW.stock_quantity - OLD.stock_quantity, 'RESTOCK');
    END IF;
END $$
DELIMITER ;

-- 6.4 Prevent deleting a supplier that still has medicines linked to it
DROP TRIGGER IF EXISTS trg_block_supplier_delete;
DELIMITER $$
CREATE TRIGGER trg_block_supplier_delete
BEFORE DELETE ON suppliers
FOR EACH ROW
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*) INTO v_count FROM medicines WHERE supplier_id = OLD.supplier_id;
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Cannot delete supplier: medicines still reference it';
    END IF;
END $$
DELIMITER ;

show tables;

select name,city from customers;
-- Find the names of medicines that are syrup and injection.
select name from medicines where category in ('Syrup','Injection');

-- list all orders where total_amount is greater than 500
select * from orders where total_amount>500;

-- find the customers who r living in mumbai.
select name,phone from customers where city='Mumbai';

-- find the medicines whose expiry_date is before 01-01-2025.
select name,expiry_date from medicines where expiry_date<'2025-01-01';

-- total orders done by upi paymnet.
select count(*) as total_upi from orders where payment_mode='UPI';

-- count how many medicines are supplied by appolo pharmacy.
select count(*) as medicine_count from medicines m join suppliers s
on m.supplier_id=s.supplier_id where supplier_name='Apollo Distributors';

-- list the customer name, order date, total mount for every order.
select c.name,o.order_date,o.total_amount from customers c right join
orders o on c.customer_id=o.customer_id;

-- total money earned through each payment method.
select payment_mode,sum(total_amount) as revenue from orders group by payment_mode;

-- customers who didnt order even once.
select c.name from customers c left join orders o on
c.customer_id=o.customer_id where o.customer_id is null;

-- medicine name that has never ordered.
select m.name from medicines m left join order_items o on
m.medicine_id=o.medicine_id where o.medicine_id is null;

-- city based total revenue.
select c.city,sum(o.total_amount) as revenue from customers c left join
orders o on c.customer_id=o.customer_id group by c.city;

-- best selling medicine, which is sold most
select m.name,sum(o.quantity) as total_quantity from medicines m left join
order_items o on m.medicine_id=o.medicine_id group by m.medicine_id 
order by total_quantity desc limit 1;

-- spent more than 1000 by customer, name and how much he spent.
select c.name,sum(o.total_amount) as Total_spent from customers c
left join orders o on c.customer_id=o.customer_id group by c.name
having total_spent>1000 order by total_spent desc;

-- Inventory audit: medicine name, stock quantity, supplier name with less than 50 units left.
select m.name,m.stock_quantity,s.supplier_name from medicines m join
suppliers s on m.supplier_id=s.supplier_id where m.stock_quantity<50;


