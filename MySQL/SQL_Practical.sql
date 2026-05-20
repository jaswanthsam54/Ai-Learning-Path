-- Database
CREATE DATABASE company_db;
USE company_db;

-- Tables
CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100) NOT NULL,
    age INT CHECK(age >= 18),
    gender VARCHAR(10),
    city VARCHAR(50),
    salary DECIMAL(10,2),
    dept_id INT,
    manager_id INT,
    joining_date DATE,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(100) NOT NULL,
    budget DECIMAL(12,2)
);

CREATE TABLE employee_projects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    project_id INT,
    hours_worked INT DEFAULT 0,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

-- Insert Data
INSERT INTO departments (dept_name) VALUES
('HR'),
('IT'),
('Finance'),
('Marketing');

INSERT INTO employees
(emp_name, age, gender, city, salary, dept_id, manager_id, joining_date)
VALUES
('Rahul', 25, 'Male', 'Hyderabad', 50000, 2, NULL, '2024-01-10'),
('Sneha', 28, 'Female', 'Chennai', 60000, 1, 1, '2023-02-11'),
('Arjun', 30, 'Male', 'Bangalore', 75000, 2, 1, '2022-03-15'),
('Divya', 24, 'Female', 'Hyderabad', 45000, 3, 2, '2024-04-21'),
('Kiran', 35, 'Male', 'Mumbai', 90000, 4, 1, '2021-05-18'),
('Meena', 27, 'Female', 'Delhi', 52000, 2, 3, '2023-07-12');

INSERT INTO projects (project_name, budget) VALUES
('AI System', 500000),
('Banking App', 300000),
('Ecommerce Website', 200000);

INSERT INTO employee_projects (emp_id, project_id, hours_worked) VALUES
(1,1,120),
(2,2,100),
(3,1,150),
(4,3,80),
(5,2,110),
(6,1,90);

-- Select
SELECT * FROM employees;

SELECT emp_name, salary
FROM employees;

-- Where Clause
SELECT *
FROM employees
WHERE city = 'Hyderabad';

-- Operators
SELECT *
FROM employees
WHERE salary > 50000;

SELECT *
FROM employees
WHERE salary >= 50000 AND city = 'Hyderabad';

SELECT *
FROM employees
WHERE city = 'Delhi' OR city = 'Mumbai';

SELECT *
FROM employees
WHERE NOT city = 'Chennai';

SELECT *
FROM employees
WHERE age BETWEEN 24 AND 30;

SELECT *
FROM employees
WHERE city IN ('Hyderabad', 'Mumbai');

SELECT *
FROM employees
WHERE emp_name LIKE 'R%';

SELECT *
FROM employees
WHERE manager_id IS NULL;

-- Order By
SELECT *
FROM employees
ORDER BY salary ASC;

SELECT *
FROM employees
ORDER BY salary DESC;

-- Limit
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 3;

-- Aggregate Functions
SELECT COUNT(*) AS total_employees
FROM employees;

SELECT AVG(salary) AS average_salary
FROM employees;

SELECT MAX(salary) AS highest_salary
FROM employees;

SELECT MIN(salary) AS lowest_salary
FROM employees;

SELECT SUM(salary) AS total_salary
FROM employees;

-- Group By
SELECT city, COUNT(*) AS total_employees
FROM employees
GROUP BY city;

SELECT dept_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY dept_id;

-- Having
SELECT city, COUNT(*) AS total
FROM employees
GROUP BY city
HAVING COUNT(*) > 1;

-- General SQL Order
SELECT city, AVG(salary) AS avg_salary
FROM employees
WHERE salary > 40000
GROUP BY city
HAVING AVG(salary) > 50000
ORDER BY avg_salary DESC
LIMIT 5;

-- Update
UPDATE employees
SET salary = 65000
WHERE emp_id = 2;

-- Delete
DELETE FROM employees
WHERE emp_id = 4;

-- Alter Table
ALTER TABLE employees
ADD email VARCHAR(100);

ALTER TABLE employees
MODIFY email VARCHAR(150);

ALTER TABLE employees
RENAME COLUMN email TO employee_email;

-- Truncate
-- TRUNCATE TABLE employee_projects;

-- Inner Join
SELECT e.emp_name, d.dept_name
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id;

-- Left Join
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;

-- Right Join
SELECT e.emp_name, d.dept_name
FROM employees e
RIGHT JOIN departments d
ON e.dept_id = d.dept_id;

-- Full Outer Join
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id

UNION

SELECT e.emp_name, d.dept_name
FROM employees e
RIGHT JOIN departments d
ON e.dept_id = d.dept_id;

-- Cross Join
SELECT e.emp_name, p.project_name
FROM employees e
CROSS JOIN projects p;

-- Self Join
SELECT
e.emp_name AS employee,
m.emp_name AS manager
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.emp_id;

-- Subqueries
SELECT emp_name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

SELECT emp_name
FROM employees
WHERE dept_id = (
    SELECT dept_id
    FROM departments
    WHERE dept_name = 'IT'
);

-- Views
CREATE VIEW employee_department_view AS
SELECT e.emp_name, d.dept_name, e.salary
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id;

SELECT *
FROM employee_department_view;

-- Index
CREATE INDEX idx_city
ON employees(city);

SHOW INDEX FROM employees;

DROP INDEX idx_city ON employees;

-- Composite Index
CREATE INDEX idx_city_salary
ON employees(city, salary);

-- Transactions
START TRANSACTION;

UPDATE employees
SET salary = salary + 5000
WHERE emp_id = 1;

COMMIT;

-- Rollback
START TRANSACTION;

DELETE FROM employees
WHERE emp_id = 5;

ROLLBACK;

-- Savepoint
START TRANSACTION;

UPDATE employees
SET salary = salary + 1000
WHERE emp_id = 1;

SAVEPOINT sp1;

UPDATE employees
SET salary = salary + 2000
WHERE emp_id = 2;

ROLLBACK TO sp1;

COMMIT;

-- Stored Procedure
DELIMITER //

CREATE PROCEDURE GetEmployees()
BEGIN
    SELECT * FROM employees;
END //

DELIMITER ;

CALL GetEmployees();

DROP PROCEDURE GetEmployees;

-- Practice Queries
SELECT *
FROM employees
WHERE salary > 60000;

SELECT city, COUNT(*) AS total
FROM employees
GROUP BY city;

SELECT *
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
);

SELECT e.emp_name, d.dept_name
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id;

SELECT dept_id, AVG(salary)
FROM employees
GROUP BY dept_id;

SELECT *
FROM employees
WHERE emp_name LIKE 'M%';

SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 2;

SELECT e.emp_name
FROM employees e
JOIN employee_projects ep
ON e.emp_id = ep.emp_id
JOIN projects p
ON ep.project_id = p.project_id
WHERE p.project_name = 'AI System';

-- Cleanup
-- DROP VIEW employee_department_view;
-- DROP DATABASE company_db;