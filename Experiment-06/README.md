# Experiment 6: Stored Procedures, Triggers & Error Handling

## Aim
To create a stored procedure `transfer_employee(emp_id, new_dept_id)` with validation and error handling, implement triggers for salary validation and audit logging, and test different edge cases.

## Theory
* **Stored Procedures:** Reusable blocks of SQL statements supporting parameters, control-flow logic, and exception handling (`SIGNAL SQLSTATE`).
* **Triggers:** Automated event-driven procedures that execute `BEFORE` or `AFTER` `INSERT`, `UPDATE`, or `DELETE` operations to enforce business rules and maintain audit trails.

## Features Included
* **Salary Validation Trigger:** Prevents insertion or updating of employee salaries less than or equal to zero.
* **Salary Audit Trigger:** Automatically logs salary modifications into a `salary_audit` tracking table upon updates.
* **Transfer Stored Procedure:** Validates the existence of both employee and target department IDs before performing a department reassignment.

## Usage / Execution Instructions
1. Create the `salary_audit` tracking table.
2. Define the triggers using the appropriate `DELIMITER` blocks.
3. Create the `transfer_employee` stored procedure.
4. Call the procedure with valid and invalid IDs to test error handling and audit logging.
