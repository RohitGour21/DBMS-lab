DROP TABLE IF EXISTS Sales_Data;

CREATE TABLE Sales_Data (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    region VARCHAR(30),
    quantity INT,
    amount DECIMAL(10,2),
    sale_date DATE
);

INSERT INTO Sales_Data
(sale_id, customer_id, product_id, region, quantity, amount, sale_date)
SELECT
    n,
    MOD(n, 1000) + 1,
    MOD(n, 100) + 1,
    CASE MOD(n, 4)
        WHEN 0 THEN 'North'
        WHEN 1 THEN 'South'
        WHEN 2 THEN 'East'
        ELSE 'West'
    END,
    MOD(n, 10) + 1,
    (MOD(n, 10) + 1) * 500,
    DATE_ADD('2026-01-01', INTERVAL MOD(n, 365) DAY)
FROM (
    SELECT a.n + b.n * 10 + c.n * 100 + d.n * 1000 + 1 AS n
    FROM
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL
         SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL
         SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a,
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL
         SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL
         SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b,
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL
         SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL
         SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) c,
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL
         SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL
         SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) d
) numbers
WHERE n <= 10000;

-- Slow Query 1 – Customer Search
SELECT *
FROM Sales_Data
WHERE customer_id = 500;

EXPLAIN
SELECT *
FROM Sales_Data
WHERE customer_id = 500;

CREATE INDEX idx_customer
ON Sales_Data(customer_id);

EXPLAIN
SELECT *
FROM Sales_Data
WHERE customer_id = 500;

-- Slow Query 2 – Region and Date Search
SELECT *
FROM Sales_Data
WHERE region = 'North'
AND sale_date = '2026-03-01';

EXPLAIN
SELECT *
FROM Sales_Data
WHERE region = 'North'
AND sale_date = '2026-03-01';

CREATE INDEX idx_region_date
ON Sales_Data(region, sale_date);

EXPLAIN
SELECT *
FROM Sales_Data
WHERE region = 'North'
AND sale_date = '2026-03-01';

-- Slow Query 3 – Product Search
SELECT *
FROM Sales_Data
WHERE product_id = 50;

EXPLAIN
SELECT *
FROM Sales_Data
WHERE product_id = 50;

CREATE INDEX idx_product
ON Sales_Data(product_id);

EXPLAIN
SELECT *
FROM Sales_Data
WHERE product_id = 50;

-- Slow Query 4 – Date Range Search
SELECT *
FROM Sales_Data
WHERE sale_date BETWEEN '2026-01-01' AND '2026-06-30';

EXPLAIN
SELECT *
FROM Sales_Data
WHERE sale_date BETWEEN '2026-01-01' AND '2026-06-30';

CREATE INDEX idx_sale_date
ON Sales_Data(sale_date);

EXPLAIN
SELECT *
FROM Sales_Data
WHERE sale_date BETWEEN '2026-01-01' AND '2026-06-30';

-- Slow Query 5 – Query Rewriting
SELECT *
FROM Sales_Data
WHERE quantity + 1 > 5;

EXPLAIN
SELECT *
FROM Sales_Data
WHERE quantity + 1 > 5;

-- Optimized Query
SELECT *
FROM Sales_Data
WHERE quantity > 4;

EXPLAIN
SELECT *
FROM Sales_Data
WHERE quantity > 4;
