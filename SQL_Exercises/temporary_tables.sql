/* 1. Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read. */

USE robinson_2288;

CREATE TEMPORARY
TABLE
    employees_with_departments AS
SELECT
    e.first_name,
    e.last_name,
    d.dept_name
FROM employees.employees e
    JOIN employees.dept_emp de ON e.emp_no = de.emp_no  -- USING (emp_no)
    JOIN employees.departments d ON de.dept_no = d.dept_no -- USING (dept_no)
WHERE de.to_date = '9999-01-01';

SELECT * FROM employees_with_departments;

/* a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns. */

SELECT
    MAX(LENGTH(first_name)) + MAX(LENGTH(last_name)) AS longest_full_name
    FROM employees.employees;
ALTER TABLE
    employees_with_departments
ADD
    COLUMN full_name VARCHAR(40);

SELECT * FROM employees_with_departments;

/* b. Update the table so that the full_name column contains the correct data. */

UPDATE
    employees_with_departments
SET
    full_name = CONCAT(first_name, ' ', last_name);

SELECT * FROM employees_with_departments;

/* c. Remove the first_name and last_name columns from the table. */

ALTER TABLE
    employees_with_departments DROP COLUMN first_name,
    DROP COLUMN last_name;

SELECT * FROM employees_with_departments;

/* d. What is another way you could have ended up with this same table? */

DROP TABLE IF EXISTS employees_with_departments2; -- Reset table before running again

CREATE TEMPORARY
TABLE
    employees_with_departments2 AS
SELECT
    d.dept_name,
    CONCAT(e.first_name, ' ', e.last_name) full_name
FROM employees.employees e
    JOIN employees.dept_emp de ON e.emp_no = de.emp_no
    JOIN employees.departments d ON de.dept_no = d.dept_no
WHERE de.to_date = '9999-01-01';

SELECT * FROM employees_with_departments2; -- Check table

/* 2. Create a temporary table based on the payment table from the sakila database.
 Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199. */

SELECT * FROM sakila.payment; -- sakila formatting

DROP TABLE IF EXISTS sakila_temp; -- Reset button

CREATE TEMPORARY
TABLE sakila_temp AS
SELECT
    s.payment_id,
    s.customer_id,
    s.staff_id,
    s.rental_id,
    ROUND((s.amount * 100), 0) amount_in_cents,
    s.payment_date,
    s.last_update
FROM sakila.payment s;

ALTER TABLE sakila_temp
MODIFY amount INT UNSIGNED;

-- If imported all, then made the changes from decimal to integer:

ALTER TABLE sakila_temp
MODIFY amount INT UNSIGNED; -- Change from decimal to integer

UPDATE sakila_temp
SET amount * 100; -- Multiply by 100 to change into cents

SELECT * FROM sakila_temp; -- Check table

/* 3. Go back to the employees database. Find out how the current average pay in each department compares to the overall current pay for everyone at the company. For this comparison, you will calculate the z-score for each salary. In terms of salary, what is the best department right now to work for? The worst? */

USE employees;

USE robinson_2288;

DROP TABLE IF EXISTS zscore_by_dept;

CREATE TEMPORARY TABLE zscore_by_dept
SELECT
    d.dept_name AS department,
    AVG(s.salary) AS department_avg_pay, 
    (SELECT AVG(salary) FROM employees.salaries WHERE to_date > NOW()) AS company_avg_pay,
    (AVG(s.salary) - (SELECT AVG(salary) FROM employees.salaries WHERE to_date > NOW())) / STDDEV(s.salary) AS z_score
FROM employees.departments d
    JOIN employees.dept_emp de ON d.dept_no = de.dept_no AND de.to_date > NOW()
    JOIN employees.salaries s ON de.emp_no = s.emp_no AND s.to_date > NOW()
GROUP BY d.dept_name
ORDER BY z_score DESC;

SELECT * FROM zscore_by_dept;


SELECT
    d.dept_name AS department,
    AVG(s.salary) AS department_avg_pay, 
    (SELECT AVG(salary) FROM salaries WHERE to_date > NOW()) AS company_avg_pay,
    (AVG(s.salary) - (SELECT AVG(salary) FROM salaries WHERE to_date > NOW())) / (STDDEV(s.salary)) AS z_score
FROM departments d
    JOIN dept_emp de ON d.dept_no = de.dept_no AND de.to_date > NOW()
    JOIN salaries s ON de.emp_no = s.emp_no AND s.to_date > NOW()
GROUP BY d.dept_name
ORDER BY z_score DESC;

-- Best: Sales
-- Worst: HR

-- TEMP TABLE NOTES ---------------

USE robinson_2288;

CREATE TEMPORARY TABLE my_numbers( n INT UNSIGNED NOT NULL );

-- Creates table

INSERT INTO my_numbers(n) VALUES (1), (2), (3);

-- Adds data into table

SELECT * FROM my_numbers;

-- Views the table we just made

UPDATE my_numbers SET n = n + 1;

-- With no WHERE clause, this updated all rows in the table.

DELETE FROM my_numbers WHERE n % 2 = 0;

-- This deletes all even numbers from the table.

ALTER TABLE my_numbers ADD email VARCHAR(100);

-- This added an email column to the table

ALTER TABLE my_numbers DROP COLUMN email;

-- This drops the email column from the table

DROP TABLE IF EXISTS my_numbers;

-- Reversal of dot notation. (Creating temp table in a different databse than what you're in.)

CREATE TEMPORARY
TABLE
    robinson_2288.temp_table_name AS (
        SELECT *
        FROM employees
        LIMIT 5
    );

-- Select from another database

SELECT * FROM employees.departments;