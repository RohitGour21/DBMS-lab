# Experiment 5: SQL Views, Updatability & Recursive CTEs

## Aim
To create SQL views for department salary summaries and employee hierarchy, test the updatability of views, and implement a recursive CTE to display employee reporting chains.

## Theory
* **Views:** Virtual tables based on SQL queries that simplify complex schemas and secure data access. Aggregate views are generally not directly updatable, whereas simple single-table views may be updatable under specific conditions.
* **Recursive Common Table Expressions (CTEs):** Execute repeatedly to navigate hierarchical graph structures such as employee-to-manager reporting lines.

## Implementation Details
* **Manager Association:** Added `manager_id` column to the `Employee` table.
* **Views Created:**
  * `department_salary_summary`: Aggregates employee count, average, minimum, and maximum salary per department.
  * `employee_hierarchy`: Joins employees with managers to display direct reporting relationships.
* **Recursive CTE (`reporting_chain`):** Traverses the organizational tree starting from top-level managers (`manager_id IS NULL`) down to subordinate levels.

## Usage / Execution Instructions
1. Execute the `ALTER TABLE` and update statements to assign managers to employees.
2. Create the summary and hierarchy views.
3. Run the recursive CTE query to output the complete corporate reporting hierarchy ordered by level.
