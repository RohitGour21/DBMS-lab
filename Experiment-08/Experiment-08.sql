DROP TABLE IF EXISTS Bank_Account;

CREATE TABLE Bank_Account (
    account_id INT PRIMARY KEY,
    account_holder VARCHAR(50),
    balance DECIMAL(10,2)
);

INSERT INTO Bank_Account VALUES
(1, 'Rohit', 50000),
(2, 'Aman', 30000),
(3, 'Neha', 40000);

-- 1. BEGIN and COMMIT
START TRANSACTION;
UPDATE Bank_Account
SET balance = balance - 5000
WHERE account_id = 1;
UPDATE Bank_Account
SET balance = balance + 5000
WHERE account_id = 2;
COMMIT;

-- 2. ROLLBACK
START TRANSACTION;
UPDATE Bank_Account
SET balance = balance - 10000
WHERE account_id = 1;
ROLLBACK;

-- 3. SAVEPOINT
START TRANSACTION;
UPDATE Bank_Account
SET balance = balance - 5000
WHERE account_id = 1;
SAVEPOINT transfer_point;
UPDATE Bank_Account
SET balance = balance + 5000
WHERE account_id = 2;
ROLLBACK TO transfer_point;
COMMIT;

-- 4. Simulate Partial Failure
START TRANSACTION;
UPDATE Bank_Account
SET balance = balance - 5000
WHERE account_id = 1;
SAVEPOINT before_second_update;
UPDATE Bank_Account
SET balance = balance + 5000
WHERE account_id = 2;
ROLLBACK TO before_second_update;
COMMIT;

-- 5. Set Isolation Level
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- 6. Check Isolation Level
SELECT @@transaction_isolation;
