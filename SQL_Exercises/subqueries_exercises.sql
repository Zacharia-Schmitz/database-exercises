-- SUBQUERIES EXERCISE:

/* 1. Find all the current employees with the same hire date as employee 101010 using a subquery. */

-- Total 55

SELECT *
FROM employees
WHERE hire_date = (
        SELECT hire_date
        FROM employees
        WHERE
            emp_no = 101010
    )
    AND emp_no IN (
        SELECT emp_no
        FROM dept_emp
        WHERE to_date > NOW()
    );

/* 2. Find all the titles ever held by all current employees with the first name Aamod. */

-- 251 non unique, 6 unique

SELECT title, COUNT(*)
FROM titles
WHERE emp_no IN (
        SELECT emp_no
        FROM employees
        WHERE
            first_name = 'Aamod'
    )
    AND emp_no IN (
        SELECT emp_no
        FROM dept_emp
        WHERE to_date > NOW()
    )
GROUP BY title;

/* 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code. */

-- 59,900 people are no longer working for the company

SELECT COUNT(*)
FROM employees
WHERE emp_no NOT IN (
        SELECT emp_no
        FROM dept_emp
        WHERE to_date > NOW()
    );

/* 4. Find all the current department managers that are female. List their names in a comment in your code. */

-- Isamu Legleitner

-- Karsten Sigstam

-- Leon DasSarma

-- Hilary Kambil

SELECT
    e.first_name,
    e.last_name,
    e.gender
FROM (
        SELECT
            emp_no,
            first_name,
            last_name,
            gender
        FROM employees
    ) e
WHERE
    e.gender = 'F'
    AND e.emp_no IN (
        SELECT emp_no
        FROM dept_manager
        WHERE
            to_date > NOW()
            AND dept_no IN (
                SELECT
                    dept_no
                FROM
                    departments
            )
    );

/* 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary. */

-- 154,543 employees currently make over $63,810.75 (historical average)

SELECT
    e.first_name,
    e.last_name, (
        SELECT s.salary
        FROM salaries s
        WHERE
            s.emp_no = e.emp_no
            AND s.to_date = '9999-01-01'
    ) AS Current_Salary, (
        SELECT AVG(se.salary)
        FROM
            salaries se
    ) AS Historical_Average
FROM employees e
WHERE e.emp_no IN (
        SELECT s.emp_no
        FROM salaries s
        WHERE
            s.to_date > NOW()
            AND s.salary > (
                SELECT
                    AVG(salary)
                FROM
                    salaries
            )
    )
ORDER BY Current_Salary;

/* 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function
 to calculate the standard deviation.) What percentage of all salaries is this? */

/* Hint You will likely use multiple subqueries in a variety of ways
 Hint It's a good practice to write out all of the small queries that you can.
 Add a comment above the query showing the number of rows returned. 
 You will use this number (or the query that produced it) in other, larger queries. */

-- 83, 0.0346%

SELECT
    COUNT(*) AS num_salaries,
    COUNT(*) / (
        SELECT COUNT(*)
        FROM salaries
        WHERE
            to_date = '9999-01-01'
    ) * 100 AS percent_total_salaries
FROM salaries
WHERE
    to_date = '9999-01-01'
    AND salary BETWEEN (
        SELECT
            MAX(salary) - STDDEV(salary)
        FROM salaries
        WHERE
            to_date = '9999-01-01'
    )
    AND (
        SELECT
            MAX(salary) + STDDEV(salary)
        FROM salaries
        WHERE
            to_date = '9999-01-01'
    );

-- BONUS --

-- Find all the department names that currently have female managers.

-- Finance, Human Resources, Development, & Research

SELECT d.dept_name
FROM departments d
WHERE d.dept_no IN (
        SELECT dept_no
        FROM dept_manager
        WHERE
            to_date LIKE '9%'
            AND emp_no IN (
                SELECT emp_no
                FROM
                    employees
                WHERE
                    gender = 'F'
            )
    );

-- Find the first and last name of the employee with the highest salary.

-- Tokuyasu Pesch

SELECT
    e.first_name,
    e.last_name,
FROM employees e
WHERE e.emp_no = (
        SELECT s.emp_no
        FROM salaries s
        WHERE s.to_date > NOW()
        ORDER BY s.salary DESC
        LIMIT 1
    );

-- Find the department name that the employee with the highest salary works in.

-- Sales

SELECT d.dept_name
FROM departments d
WHERE d.dept_no = (
        SELECT dept_no
        FROM dept_emp
        WHERE emp_no = (
                SELECT emp_no
                FROM salaries
                WHERE
                    to_date = '9999-01-01'
                ORDER BY
                    salary DESC
                LIMIT 1
            )
    );

-- Who is the highest paid employee within each department.

/* Created max salaries CTE common table expression by joining dept_emp and salaries on the emp_no column,
 then using MAX to find the maximum current employee. */

USE employees;

WITH max_salaries AS (
        SELECT
            de.dept_no,
            MAX(s.salary) AS max_salary
        FROM dept_emp de
            JOIN salaries s ON de.emp_no = s.emp_no
        WHERE
            s.to_date = '9999-01-01'
        GROUP BY de.dept_no
    )
SELECT
    d.dept_name,
    e.first_name,
    e.last_name,
    s.salary AS max_salary
FROM max_salaries ms
    JOIN dept_emp de ON ms.dept_no = de.dept_no
    JOIN employees e ON de.emp_no = e.emp_no
    JOIN salaries s ON e.emp_no = s.emp_no AND s.salary = ms.max_salary
    JOIN departments d ON de.dept_no = d.dept_no;