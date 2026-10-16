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

CREATE TABLE IF NOT EXISTS Project (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    budget DECIMAL(12,2),
    start_date DATE
);

INSERT IGNORE INTO Project VALUES
(201, 'AI Analytics Platform', 1500000, '2026-01-10'),
(202, 'Employee Management System', 800000, '2026-02-15'),
(203, 'Banking Security System', 1800000, '2026-03-01'),
(204, 'E-Commerce Platform', 1200000, '2026-03-20'),
(205, 'Marketing Automation', 700000, '2026-04-05'),
(206, 'Data Research Portal', 1100000, '2026-04-18'),
(207, 'Cloud Migration', 2000000, '2026-05-01'),
(208, 'Cybersecurity Dashboard', 1700000, '2026-05-15');

CREATE TABLE IF NOT EXISTS Employee_Project (
    emp_id INT,
    project_id INT,
    role VARCHAR(50),
    PRIMARY KEY (emp_id, project_id),
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id),
    FOREIGN KEY (project_id) REFERENCES Project(project_id)
);

INSERT IGNORE INTO Employee_Project VALUES
(101, 201, 'Developer'),
(102, 201, 'Data Analyst'),
(103, 202, 'Developer'),
(104, 207, 'Team Lead'),
(105, 208, 'System Analyst'),
(106, 203, 'Database Engineer'),
(107, 202, 'HR Coordinator'),
(108, 202, 'HR Manager'),
(109, 205, 'Recruiter'),
(110, 205, 'HR Analyst'),
(111, 206, 'Training Coordinator'),
(112, 207, 'HR Manager'),
(113, 203, 'Financial Analyst'),
(114, 203, 'Accountant'),
(115, 203, 'Finance Manager'),
(116, 204, 'Accountant'),
(117, 206, 'Financial Analyst'),
(118, 207, 'Senior Accountant'),
(119, 205, 'Marketing Executive'),
(120, 205, 'Marketing Analyst'),
(121, 204, 'Content Manager'),
(122, 204, 'Marketing Manager'),
(123, 205, 'SEO Executive'),
(124, 207, 'Brand Manager'),
(125, 206, 'Research Analyst'),
(126, 206, 'Research Associate'),
(127, 201, 'Research Scientist'),
(128, 208, 'Research Associate'),
(129, 201, 'Data Scientist'),
(130, 208, 'Research Scientist');

-- --- Experiment 5 Implementation ---

-- 1. Add Manager Information
-- (Using procedures/checks to prevent duplicate column addition errors on reruns)
SET @col_exists = (
    SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'Employee' AND COLUMN_NAME = 'manager_id'
);
SET @alter_sql = IF(@col_exists = 0, 'ALTER TABLE Employee ADD manager_id INT;', 'SELECT "manager_id already exists"');
PREPARE stmt FROM @alter_sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

UPDATE Employee SET manager_id = NULL;
UPDATE Employee SET manager_id = 104 WHERE emp_id IN (101, 102, 103);
UPDATE Employee SET manager_id = 108 WHERE emp_id IN (107, 109, 110, 111);
UPDATE Employee SET manager_id = 115 WHERE emp_id IN (113, 114, 116, 117);
UPDATE Employee SET manager_id = 122 WHERE emp_id IN (119, 120, 121, 123);
UPDATE Employee SET manager_id = 127 WHERE emp_id IN (125, 126, 128, 129);

-- 2. Department Salary Summary View
DROP VIEW IF EXISTS department_salary_summary;
CREATE VIEW department_salary_summary AS
SELECT dept_id,
       COUNT(*) AS employee_count,
       AVG(salary) AS average_salary,
       MIN(salary) AS minimum_salary,
       MAX(salary) AS maximum_salary
FROM Employee
GROUP BY dept_id;

-- 3. Employee Hierarchy View
DROP VIEW IF EXISTS employee_hierarchy;
CREATE VIEW employee_hierarchy AS
SELECT e.emp_id,
       e.emp_name,
       e.manager_id,
       m.emp_name AS manager_name
FROM Employee e
LEFT JOIN Employee m
ON e.manager_id = m.emp_id;

-- SQL Queries & Tests
SELECT * FROM department_salary_summary;

SELECT * FROM employee_hierarchy;

DROP VIEW IF EXISTS employee_basic;
CREATE VIEW employee_basic AS
SELECT emp_id, emp_name, salary
FROM Employee;

UPDATE employee_basic
SET salary = 56000
WHERE emp_id = 101;

SELECT * FROM employee_basic WHERE emp_id = 101;

-- 4. Recursive CTE for Reporting Chain
WITH RECURSIVE reporting_chain AS (
    SELECT emp_id, emp_name, manager_id, 0 AS level
    FROM Employee
    WHERE manager_id IS NULL
    UNION ALL
    SELECT e.emp_id, e.emp_name, e.manager_id, r.level + 1
    FROM Employee e
    JOIN reporting_chain r
    ON e.manager_id = r.emp_id
)
SELECT *
FROM reporting_chain
ORDER BY level, emp_id;
