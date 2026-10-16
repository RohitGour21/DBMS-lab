CREATE DATABASE IF NOT EXISTS employee_management;
USE employee_management;

-- 1. Base Setup (From Experiment 3)
CREATE TABLE IF NOT EXISTS Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL,
    location VARCHAR(50)
);

INSERT IGNORE INTO Department VALUES
(1, 'Computer Science', 'Chandigarh'),
(2, 'Human Resources', 'Delhi'),
(3, 'Finance', 'Mumbai'),
(4, 'Marketing', 'Bangalore'),
(5, 'Research', 'Pune');

CREATE TABLE IF NOT EXISTS Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2),
    job_title VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

INSERT IGNORE INTO Employee VALUES
(101, 'Aarav Sharma', 55000, 'Software Engineer', 1),
(102, 'Rohit Verma', 62000, 'Data Analyst', 1),
(103, 'Aditya Singh', 48000, 'Web Developer', 1),
(104, 'Karan Mehta', 70000, 'Senior Developer', 1),
(105, 'Vivek Kumar', 52000, 'System Analyst', 1),
(106, 'Arjun Patel', 65000, 'Database Engineer', 1),
(107, 'Neha Sharma', 45000, 'HR Executive', 2),
(108, 'Priya Singh', 58000, 'HR Manager', 2),
(109, 'Anjali Verma', 42000, 'Recruiter', 2),
(110, 'Sneha Kapoor', 60000, 'HR Analyst', 2),
(111, 'Pooja Mehta', 50000, 'Training Officer', 2),
(112, 'Riya Gupta', 72000, 'HR Manager', 2),
(113, 'Rahul Jain', 68000, 'Financial Analyst', 3),
(114, 'Aman Gupta', 52000, 'Accountant', 3),
(115, 'Nikhil Sharma', 75000, 'Finance Manager', 3),
(116, 'Varun Singh', 47000, 'Accountant', 3),
(117, 'Mohit Kumar', 59000, 'Financial Analyst', 3),
(118, 'Yash Patel', 81000, 'Senior Accountant', 3),
(119, 'Simran Kaur', 54000, 'Marketing Executive', 4),
(120, 'Isha Sharma', 61000, 'Marketing Analyst', 4),
(121, 'Tanya Verma', 49000, 'Content Manager', 4),
(122, 'Manish Gupta', 67000, 'Marketing Manager', 4),
(123, 'Akash Jain', 46000, 'SEO Executive', 4),
(124, 'Varun Mehta', 73000, 'Brand Manager', 4),
(125, 'Sahil Kumar', 65000, 'Research Analyst', 5),
(126, 'Dev Sharma', 58000, 'Research Associate', 5),
(127, 'Harsh Singh', 76000, 'Research Scientist', 5),
(128, 'Ayush Verma', 51000, 'Research Associate', 5),
(129, 'Manav Gupta', 69000, 'Data Scientist', 5),
(130, 'Kabir Jain', 85000, 'Research Scientist', 5);

-- --- Experiment 6 Implementation ---

-- 1. Create Salary Audit Table
CREATE TABLE IF NOT EXISTS salary_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Salary Validation Triggers
DROP TRIGGER IF EXISTS validate_salary_insert;
DELIMITER //
CREATE TRIGGER validate_salary_insert
BEFORE INSERT ON Employee
FOR EACH ROW
BEGIN
    IF NEW.salary <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary must be greater than zero';
    END IF;
END//
DELIMITER ;

DROP TRIGGER IF EXISTS validate_salary_update;
DELIMITER //
CREATE TRIGGER validate_salary_update
BEFORE UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF NEW.salary <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary must be greater than zero';
    END IF;
END//
DELIMITER ;

-- 3. Salary Audit Trigger
DROP TRIGGER IF EXISTS salary_audit_trigger;
DELIMITER //
CREATE TRIGGER salary_audit_trigger
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_audit
        (emp_id, old_salary, new_salary)
        VALUES
        (OLD.emp_id, OLD.salary, NEW.salary);
    END IF;
END//
DELIMITER ;

-- 4. Stored Procedure
DROP PROCEDURE IF EXISTS transfer_employee;
DELIMITER //
CREATE PROCEDURE transfer_employee(
    IN p_emp_id INT,
    IN p_new_dept_id INT
)
BEGIN
    DECLARE emp_exists INT DEFAULT 0;
    DECLARE dept_exists INT DEFAULT 0;
    SELECT COUNT(*)
    INTO emp_exists
    FROM Employee
    WHERE emp_id = p_emp_id;
    SELECT COUNT(*)
    INTO dept_exists
    FROM Department
    WHERE dept_id = p_new_dept_id;
    IF emp_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee does not exist';
    ELSEIF dept_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Department does not exist';
    ELSE
        UPDATE Employee
        SET dept_id = p_new_dept_id
        WHERE emp_id = p_emp_id;
    END IF;
END//
DELIMITER ;

-- SQL Queries / Tests
CALL transfer_employee(101, 2);
-- CALL transfer_employee(999, 2); -- Uncomment to test invalid employee error
-- CALL transfer_employee(101, 99); -- Uncomment to test invalid department error

UPDATE Employee
SET salary = 60000
WHERE emp_id = 102;

SELECT * FROM salary_audit;

SELECT emp_id, emp_name, dept_id
FROM Employee
WHERE emp_id = 101;
