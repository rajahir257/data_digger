CREATE DATABASE datadigger;
USE datadigger;

CREATE TABLE customers(
	cust_id INT PRIMARY KEY,
    cust_name VARCHAR(30),
    cust_email VARCHAR(100),
    cust_address VARCHAR(200)
);

INSERT INTO customers VALUES
( 1,'alice', 'alice111@gmail.com', 'rajkot'),
(2, 'sita', 'sita112@gmail.com', 'ahmedabad'),
(3,'ravan', 'ravan254@gmail.com', 'surat'),
(4,'hanuman', 'hanuman132@gmail.com', 'vadodara'),
(5,'laxman', 'laxman89@gmail.com', 'jamnagar');

SELECT * FROM customers;

UPDATE customers SET cust_address = 'morbi' WHERE customer_id = 1;

DELETE FROM customers WHERE cust_id = 5;

SELECT * FROM customers WHERE cust_name = 'alice';

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    cust_id INT,
    total_amount INT ,

    FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
);

INSERT INTO orders VALUES
(101, 1, 2500),
(102, 2, 3500),
(103, 3, 1800),
(104, 4, 4200),
(105, 1, 1200);

SELECT * FROM orders;

SELECT * FROM orders WHERE cust_id = 1;

UPDATE orders SET total_amount = 3000 WHERE order_id = 101;

DELETE FROM orders WHERE order_id = 105;

SELECT MAX(total_amount) FROM orders  ;

SELECT MIN(total_amount) FROM orders  ;

SELECT AVG(total_amount) FROM orders  ;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price INT ,
    stock INT
);

INSERT INTO products VALUES
(1, 'laptop', 55000, 10),
(2, 'airbuds', 1299, 25),
(3, 'charger', 899, 15),
(4, 'mobile', 41499, 30),
(5, 'smart watch', 2000, 0);

SELECT * FROM products;

SELECT * FROM products ORDER BY price DESC;

UPDATE products SET price = 899 WHERE product_id = 2;

DELETE FROM products WHERE stock = 0;

SELECT * FROM products WHERE price >= 500 AND price <=2000;

SELECT MAX(price) FROM products;

SELECT MIN(price) FROM products;

CREATE TABLE orderdetails (
    orderdetail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    sub_total INT,

    FOREIGN KEY (order_id) REFERENCES orders(order_id),

    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO orderdetails VALUES
(1001, 101, 1, 1, 45000),
(1002, 101, 2, 2, 1598),
(1003, 102, 3, 2, 2598),
(1004, 103, 4, 3, 1797),
(1005, 104, 2, 1, 799);

SELECT * FROM orderdetails;

SELECT * FROM orderdetails WHERE order_id = 101;

SELECT sub_total, SUM(sub_total) AS total_revenue FROM orderdetails; 

SELECT pd.product_name AS product_name,od.product_id AS product_id , pd.product_id AS product_id, od.quantity AS quantity,  SUM(od.qantity) AS total_quantity 
	FROM orderdetails
	INNER JOIN products ON od.product_id = pd.product_id GROUP BY pd.product_id, pd.product_name 
    ORDER BY total_quantity DESC LIMIT 3;

SELECT COUNT(*) FROM orderdetails WHERE product_id = 4;