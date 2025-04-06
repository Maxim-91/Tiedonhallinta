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

DROP USER 'matt'@'localhost';
# Task 1
CREATE USER 'matt'@'localhost' IDENTIFIED BY 'test';

# Task 2
GRANT SELECT ON salesman TO 'matt'@'localhost';
SELECT * FROM salesman;
SELECT cust_name FROM customer; 
#As matt try to query all customer names from customer table. What happens and why?:
#As matt, when trying to query all customer names from the customer table, the query succeeds. This happens because matt has the SELECT privilege on the customer table, which allows retrieving data from it.
#Matt-käyttäjänä, kun yritetään hakea kaikkien asiakkaiden nimiä customer-taulusta, kysely onnistuu. Tämä johtuu siitä, että Mattilla on SELECT-oikeus customer-tauluun, mikä mahdollistaa tietojen hakemisen siitä.

# Task 3
GRANT SELECT ON customer TO 'matt'@'localhost';
GRANT DELETE ON customer TO 'matt'@'localhost';
--
GRANT SELECT ON orders TO 'matt'@'localhost';
GRANT DELETE ON orders TO 'matt'@'localhost';
--
GRANT UPDATE ON orders TO 'matt'@'localhost';

# Task 4
SELECT * FROM customer;
UPDATE orders SET purch_amt = 5800 WHERE ord_no = 70008;

# Task 5
CREATE USER 'lisa'@'localhost' IDENTIFIED BY 'test';

# Task 6
CREATE ROLE 'staff';
GRANT 'staff' TO 'lisa'@'localhost';
GRANT 'staff' TO 'matt'@'localhost';
--
GRANT SELECT ON salesman TO 'staff';
GRANT UPDATE ON salesman TO 'staff';
GRANT INSERT ON salesman TO 'staff';
--
GRANT SELECT ON customer TO 'staff';
GRANT UPDATE ON customer TO 'staff';
GRANT INSERT ON customer TO 'staff';
--
GRANT SELECT ON orders TO 'staff';
GRANT UPDATE ON orders TO 'staff';
GRANT INSERT ON orders TO 'staff';

# Task 7
SELECT * FROM salesman;
INSERT INTO salesman (name, city, commission) VALUES ('John', 'Helsinki', 0.10);
UPDATE salesman SET commission = 0.12 WHERE name = 'John';
DELETE FROM salesman WHERE name = 'John';
#Try to delete the row you inserted before. What happens?
#The row is successfully deleted because the user has DELETE privilege on the salesman table.
#Rivi poistetaan onnistuneesti, koska käyttäjällä on DELETE-oikeus salesman-tauluun.

# Task 8
SELECT * FROM customer;
INSERT INTO customer (cust_name, city, grade, salesman_id) VALUES ('Test Customer', 'Helsinki', 100, 5001);
UPDATE customer SET cust_name = 'Updated Customer' WHERE cust_name = 'Test Customer';
DELETE FROM customer WHERE cust_name = 'Updated Customer';
#Try to delete the row you inserted before. What happens?
#The row is successfully deleted because the cust_name matches the inserted value.
#Rivi poistetaan onnistuneesti, koska cust_name vastaa lisättyä arvoa.

# Task 9
REVOKE DELETE ON customer FROM 'matt'@'localhost';
REVOKE DELETE ON orders FROM 'matt'@'localhost';
#Try out that Matt cannot delete rows anymore from these tables
DELETE FROM customer WHERE cust_name = 'Nick Rimando';
DELETE FROM orders WHERE ord_no = 70001;

# Task 10
DROP USER 'lisa'@'localhost';

