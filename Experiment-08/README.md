# Experiment 8: Transactions, Concurrency Control & Isolation Levels

## Aim
To implement banking-style transactions using `BEGIN`, `COMMIT`, `ROLLBACK`, and `SAVEPOINT`, simulate partial failures, and demonstrate isolation levels and concurrency anomalies using two database sessions.

## Theory
* **ACID Transactions:** Group multiple operations into an atomic unit. `COMMIT` persists changes, while `ROLLBACK` undoes uncommitted modifications.
* **SAVEPOINT:** Allows partial rollbacks within a transaction block.
* **Isolation Levels:** Control visibility of uncommitted changes between concurrent database transactions to prevent anomalies like non-repeatable reads and dirty reads.

## Operations Covered
* Basic fund transfer between bank accounts using `START TRANSACTION` and `COMMIT`.
* Canceling failed operations using `ROLLBACK` and `ROLLBACK TO SAVEPOINT`.
* Configuring session isolation levels (e.g., `READ COMMITTED`) across multiple concurrent workbench sessions.

## Usage / Execution Instructions
1. Create the `Bank_Account` table and populate sample account balances.
2. Execute transaction blocks with savepoints to test partial rollbacks.
3. Open two separate connection sessions to test concurrent updates and isolation behavior.
