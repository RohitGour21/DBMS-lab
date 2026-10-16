# Experiment 3: Employee–Department–Project Database & Basic SQL Queries

## Aim
To create an Employee–Department–Project database containing exactly 30 employees, 5 departments, and 8 projects, and to execute SQL queries demonstrating selection, projection, aggregate functions, GROUP BY, HAVING, CASE expressions, and ORDER BY.

## Theory
SQL provides commands for storing, retrieving, grouping, and analyzing relational data. 
* **Selection:** Retrieves records based on a specified condition (`WHERE`).
* **Projection:** Retrieves specific columns.
* **Aggregate Functions:** Perform calculations on multiple records (`COUNT`, `AVG`, `MIN`, `MAX`).
* **GROUP BY & HAVING:** Group rows sharing common attributes and filter those groups based on aggregate conditions.
* **CASE Expressions:** Provide conditional logic within queries.
* **ORDER BY:** Sort query results in ascending or descending order.

## Schema Overview
* **Department:** `dept_id` (PK), `dept_name`, `location`
* **Employee:** `emp_id` (PK), `emp_name`, `salary`, `job_title`, `dept_id` (FK)
* **Project:** `project_id` (PK), `project_name`, `budget`, `start_date`
* **Employee_Project:** `emp_id` (FK), `project_id` (FK), `role` (Composite PK)

## Usage / Execution Instructions
1. Open your MySQL client (e.g., MySQL Workbench).
2. Run the table creation and insertion scripts to populate the database with 30 employees, 5 departments, and 8 projects.
3. Execute the provided selection, aggregation, grouping, and sorting queries to verify the outputs.
