DROP DATABASE IF EXISTS mybusiness;
CREATE DATABASE mybusiness;
USE mybusiness;

DROP TABLE IF EXISTS salesman;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS orders;

CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    city VARCHAR(255),
    commission DECIMAL(10, 2)
);
insert  into salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5007, 'Paul Adam', 'Rome', 0.13),
(5003, 'Lauson Hen', 'San Jose', 0.12),
(5010, 'Ben Johnson', 'San Jose', 0.13),
(5011, 'Sam Lawson', 'Santiago', 0.11);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    cust_name VARCHAR(255),
    city VARCHAR(255),
    grade INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);
insert  into customer (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3008, 'Julian Green', 'London', 300, 5002),
(3004, 'Fabian Johnson', 'Paris', 300, 5006),
(3009, 'Geoff Cameron', 'Berlin', 100, 5003),
(3003, 'Jozy Altidor', 'Moscow', 200, 5007),
(3001, 'Brad Guzan', 'London', 300, 5005),
(3010, 'Marion Cameron', 'San Jose', 300, 5010);

CREATE TABLE orders (
    ord_no INT PRIMARY KEY NOT NULL,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);
insert  into orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001),
(70010, 1983.43, '2012-10-10', 3004, 5006),
(70003, 2480.4, '2012-10-10', 3009, 5003),
(70012, 250.45, '2012-06-27', 3008, 5002),
(70011, 75.29, '2012-08-17', 3003, 5007),
(70013, 3045.6, '2012-04-25', 3002, 5001),
(70014, 1786.4, '2012-06-25', 3004, 5006);

# Task 1
UPDATE salesman
SET name = 'Paul White', city = 'London'
WHERE salesman_id = 5007;

# Task 2
UPDATE customer
SET grade = 300
WHERE customer_id = 3005;

# Task 3.1
ALTER TABLE customer DROP FOREIGN KEY customer_ibfk_1;
ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_2;

UPDATE salesman
SET salesman_id = 5009
WHERE salesman_id = 5007;

ALTER TABLE customer ADD CONSTRAINT customer_ibfk_1 FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id);
ALTER TABLE orders ADD CONSTRAINT orders_ibfk_2 FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id);

# Task 3.2
INSERT INTO salesman (salesman_id, name, city, commission)
SELECT 5009, name, city, commission
FROM salesman
WHERE salesman_id = 5007;

UPDATE customer
SET salesman_id = 5009
WHERE salesman_id = 5007;

UPDATE orders
SET salesman_id = 5009
WHERE salesman_id = 5007;

DELETE FROM salesman WHERE salesman_id = 5007;

# Task 4
DELETE FROM orders
WHERE ord_no = 70014;

# Task 5
DELETE FROM customer
WHERE salesman_id = 5010;
DELETE FROM salesman
WHERE salesman_id = 5010;

