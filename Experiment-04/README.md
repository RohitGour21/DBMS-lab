# Experiment 4: Advanced SQL Queries, Joins & Execution Plans

## Aim
To execute SQL queries using INNER JOIN, LEFT JOIN, self-join, three-way join, correlated subqueries, EXISTS, simulated INTERSECT, and simulated EXCEPT, and to compare query execution plans using EXPLAIN.

## Theory
* **Joins:** Combine related records across multiple tables (`INNER JOIN`, `LEFT JOIN`, self-joins, and multi-table joins).
* **Subqueries & EXISTS:** Allow nested query execution and conditional existence checks.
* **Set Operations Simulation:** Since traditional MySQL versions lack direct `INTERSECT` and `EXCEPT` operators, `IN` and `NOT IN` (or `NOT EXISTS`) are used to simulate set intersections and differences.
* **EXPLAIN:** Displays the execution plan detailing how MySQL accesses tables and utilizes indexes.

## Key Concepts Demonstrated
* Listing employees and their corresponding departments using `INNER JOIN`.
* Finding department-employee relationships with `LEFT JOIN`.
* Identifying peer employees within the same department via self-joins.
* Processing correlated subqueries for department salary comparisons.
* Inspecting execution efficiency using the `EXPLAIN` keyword.

## Usage / Execution Instructions
1. Ensure the database tables from Experiment 3 are present.
2. Run the join queries and subqueries sequentially.
3. Prefix queries with `EXPLAIN` to analyze query execution paths and table scan characteristics.
