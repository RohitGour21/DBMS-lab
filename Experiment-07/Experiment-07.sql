DROP TABLE IF EXISTS Order_Details;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Salespersons;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Order_Details_2NF;
DROP TABLE IF EXISTS Orders_2NF;
DROP TABLE IF EXISTS Products_2NF;
DROP TABLE IF EXISTS Sales_1NF;
DROP TABLE IF EXISTS Sales_UNF;

-- 1. Create UNF Sales Table
CREATE TABLE Sales_UNF (
    order_id INT,
    order_date DATE,
    customer_id INT,
    customer_name VARCHAR(50),
    customer_city VARCHAR(50),
    product_id INT,
    product_name VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    salesperson_id INT,
    salesperson_name VARCHAR(50)
);

-- 2. Insert Sample Data
INSERT INTO Sales_UNF VALUES
(1, '2026-09-01', 101, 'Rohit', 'Delhi', 201, 'Laptop', 1, 60000, 501, 'Amit'),
(1, '2026-09-01', 101, 'Rohit', 'Delhi', 202, 'Mouse', 2, 800, 501, 'Amit'),
(2, '2026-09-02', 102, 'Neha', 'Mumbai', 201, 'Laptop', 1, 60000, 502, 'Priya'),
(3, '2026-09-03', 103, 'Aman', 'Pune', 203, 'Keyboard', 1, 1500, 501, 'Amit');

-- 3. Convert UNF to 1NF
CREATE TABLE Sales_1NF (
    order_id INT,
    order_date DATE,
    customer_id INT,
    customer_name VARCHAR(50),
    customer_city VARCHAR(50),
    product_id INT,
    product_name VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    salesperson_id INT,
    salesperson_name VARCHAR(50),
    PRIMARY KEY (order_id, product_id)
);

-- 4. Convert 1NF to 2NF
CREATE TABLE Orders_2NF (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    customer_name VARCHAR(50),
    customer_city VARCHAR(50),
    salesperson_id INT,
    salesperson_name VARCHAR(50)
);

CREATE TABLE Products_2NF (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE Order_Details_2NF (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id)
);

-- 5. Convert 2NF to 3NF
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    customer_city VARCHAR(50)
);

CREATE TABLE Salespersons (
    salesperson_id INT PRIMARY KEY,
    salesperson_name VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    salesperson_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (salesperson_id) REFERENCES Salespersons(salesperson_id)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE Order_Details (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- SQL Queries
SELECT customer_id, COUNT(DISTINCT customer_name) AS names
FROM Customers
GROUP BY customer_id;

SELECT product_id, COUNT(DISTINCT price) AS prices
FROM Products
GROUP BY product_id;

SELECT o.order_id, c.customer_name, p.product_name, od.quantity
FROM Orders o
JOIN Customers c
ON o.customer_id = c.customer_id
JOIN Order_Details od
ON o.order_id = od.order_id
JOIN Products p
ON od.product_id = p.product_id;

SELECT o.order_id, o.customer_id, c.customer_name
FROM Orders o
JOIN Customers c
ON o.customer_id = c.customer_id;
