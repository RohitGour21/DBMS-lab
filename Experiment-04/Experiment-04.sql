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

-- --- Experiment 4 Queries ---

-- 1. INNER JOIN
SELECT e.emp_name, d.dept_name
FROM Employee e
INNER JOIN Department d
ON e.dept_id = d.dept_id;

-- 2. LEFT JOIN
SELECT d.dept_name, e.emp_name
FROM Department d
LEFT JOIN Employee e
ON d.dept_id = e.dept_id;

-- 3. Self-Join
SELECT e1.emp_name AS employee1,
       e2.emp_name AS employee2,
       e1.dept_id
FROM Employee e1
JOIN Employee e2
ON e1.dept_id = e2.dept_id
AND e1.emp_id < e2.emp_id;

-- 4. Three-Way JOIN
SELECT e.emp_name, d.dept_name, ep.project_id
FROM Employee e
JOIN Department d
ON e.dept_id = d.dept_id
JOIN Employee_Project ep
ON e.emp_id = ep.emp_id;

-- 5. Correlated Subquery
SELECT emp_name, salary, dept_id
FROM Employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
    WHERE dept_id = e.dept_id
);

-- 6. EXISTS
SELECT dept_name
FROM Department d
WHERE EXISTS (
    SELECT 1
    FROM Employee e
    WHERE e.dept_id = d.dept_id
);

-- 7. Simulated INTERSECT
SELECT DISTINCT dept_id
FROM Employee
WHERE dept_id IN (
    SELECT DISTINCT e.dept_id
    FROM Employee e
    JOIN Employee_Project ep
    ON e.emp_id = ep.emp_id
);

-- 8. Simulated EXCEPT
SELECT dept_id
FROM Department
WHERE dept_id NOT IN (
    SELECT dept_id
    FROM Employee
    WHERE salary > 70000
);

-- 9. EXPLAIN
EXPLAIN
SELECT *
FROM Employee
WHERE dept_id = 1;

-- 10. EXPLAIN with JOIN
EXPLAIN
SELECT e.emp_name, d.dept_name
FROM Employee e
JOIN Department d
ON e.dept_id = d.dept_id;
