# Experiment 9: Indexing & Performance Analysis

## Aim
To create a Railway Booking table containing exactly 5,000 records, analyze query performance before and after creating single and composite indexes, and compare execution plans using EXPLAIN.

## Theory
* **Indexing:** A database optimization structure that accelerates data retrieval at the cost of additional storage and overhead during insert/update operations.
* **Single-Column Index:** Created on an individual attribute.
* **Composite Index:** Built on multiple columns to optimize queries filtering on multiple conditions simultaneously.
* **EXPLAIN:** Inspects whether queries perform full table scans (`ALL`) or utilize index lookups (`ref`, `range`).

## Implementation Steps
* Generated exactly 5,000 records using a recursive number generator combined with conditional station mapping and date functions.
* Analyzed execution plans before indexing (`type = ALL`).
* Created single (`idx_train`) and composite (`idx_train_date`) indexes and evaluated execution plan improvements.

## Usage / Execution Instructions
1. Run the bulk insert script to populate the `Railway_Booking` table with 5,000 rows.
2. Execute search queries with `EXPLAIN` prior to indexing.
3. Create the single and composite indexes, then re-run `EXPLAIN` to observe performance optimization.
