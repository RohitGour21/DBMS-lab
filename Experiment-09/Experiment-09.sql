DROP TABLE IF EXISTS Railway_Booking;

CREATE TABLE Railway_Booking (
    booking_id INT PRIMARY KEY,
    passenger_name VARCHAR(50),
    train_no INT,
    source_station VARCHAR(50),
    destination_station VARCHAR(50),
    travel_date DATE,
    seat_no INT,
    fare DECIMAL(10,2)
);

INSERT INTO Railway_Booking
(booking_id, passenger_name, train_no, source_station,
 destination_station, travel_date, seat_no, fare)
SELECT
    n,
    CONCAT('Passenger_', n),
    100 + MOD(n, 20),
    CASE MOD(n, 5)
        WHEN 0 THEN 'Delhi'
        WHEN 1 THEN 'Mumbai'
        WHEN 2 THEN 'Pune'
        WHEN 3 THEN 'Chandigarh'
        ELSE 'Bhopal'
    END,
    CASE MOD(n, 5)
        WHEN 0 THEN 'Mumbai'
        WHEN 1 THEN 'Pune'
        WHEN 2 THEN 'Delhi'
        WHEN 3 THEN 'Bhopal'
        ELSE 'Chandigarh'
    END,
    DATE_ADD('2026-01-01', INTERVAL MOD(n, 180) DAY),
    MOD(n, 100) + 1,
    300 + MOD(n, 1000)
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
WHERE n <= 5000;

-- 1. Query Before Indexing
SELECT *
FROM Railway_Booking
WHERE train_no = 105;

-- 2. Execution Plan Before Indexing
EXPLAIN
SELECT *
FROM Railway_Booking
WHERE train_no = 105;

-- 3. Create Single Index
CREATE INDEX idx_train
ON Railway_Booking(train_no);

-- 4. Query After Single Index
SELECT *
FROM Railway_Booking
WHERE train_no = 105;

-- 5. Execution Plan After Single Index
EXPLAIN
SELECT *
FROM Railway_Booking
WHERE train_no = 105;

-- 6. Query for Composite Index
SELECT *
FROM Railway_Booking
WHERE train_no = 105
AND travel_date = '2026-03-01';

-- 7. Create Composite Index
CREATE INDEX idx_train_date
ON Railway_Booking(train_no, travel_date);

-- 8. Execution Plan After Composite Index
EXPLAIN
SELECT *
FROM Railway_Booking
WHERE train_no = 105
AND travel_date = '2026-03-01';

-- 9. Compare Indexes
SHOW INDEX FROM Railway_Booking;
