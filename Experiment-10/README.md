# Experiment 10: Advanced Query Optimization & Execution Plan Analysis

## Aim
To generate a dataset containing exactly 10,000 rows, identify five slow queries, analyze their execution plans using `EXPLAIN`, optimize them using indexing and query rewriting, and compare query execution before and after optimization.

## Theory
* **Query Optimization:** Minimizes data scanning overhead and improves response times through proper index selection and query restructuring.
* **Query Rewriting:** Avoids operations that invalidate indexes (such as arithmetic expressions applied directly on indexed table columns in `WHERE` clauses).
* **EXPLAIN Analysis:** Evaluates table access methods, possible keys, chosen keys, and row examination counts.

## Five Optimization Scenarios
1. **Customer Search:** Optimized via single-column index on `customer_id`.
2. **Region & Date Search:** Optimized via composite index on `(region, sale_date)`.
3. **Product Search:** Optimized via index on `product_id`.
4. **Date Range Search:** Optimized via index on `sale_date`.
5. **Query Rewriting:** Rewrote `quantity + 1 > 5` to `quantity > 4` to ensure index sargability.

## Usage / Execution Instructions
1. Run the dataset generation script to populate `Sales_Data` with 10,000 records.
2. Execute each slow query alongside `EXPLAIN` before applying optimizations.
3. Implement the corresponding indexes and query rewrites, then review the updated execution plans.
