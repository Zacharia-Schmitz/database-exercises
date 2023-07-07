/* 1. Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson. */
USE employees;
SELECT *
FROM employees;

/* 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your 
results returned by first name. What was the first and last name in the first row of 
the results? What was the first and last name of the last person in the table? */
SELECT first_name, last_name
FROM employees
WHERE first_name 
IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name; -- Irena Acton, Vidya Zweizig

/* 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order
your results returned by first name and then last name. In your comments, answer: What
was the first and last name in the first row of the results? What was the first and
last name of the last person in the table? */
SELECT first_name, last_name, emp_no
FROM employees
WHERE first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya'
ORDER BY first_name, last_name; -- Irena Acton, Vidya Zweizig

/* 4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your
results returned by last name and then first name. In your comments, answer: What was 
the first and last name in the first row of the results? What was the first and last
name of the last person in the table? */
SELECT last_name, first_name, emp_no, gender
FROM employees
WHERE (first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya')
AND gender = 'M'
ORDER BY last_name, first_name; -- Irena Acton, Maya Zyda

/* 5. Write a query to find all employees whose last name starts and ends with 'E'. 
Sort the results by their employee number. Enter a comment with the number of employees 
returned, the first employee number and their first and last name, and the last employee 
number with their first and last name.  */
SELECT DISTINCT first_name, last_name, emp_no
FROM employees
WHERE last_name LIKE 'E%E'
ORDER BY emp_no; -- 899 total, First: 10021 Ramzi Erde, Last: 499648 Tadahiro Erde 

/* 6. Write a query to find all employees whose last name starts and ends with 'E'. 
Sort the results by their hire date, so that the newest employees are listed first. 
Enter a comment with the number of employees returned, the name of the newest employee,
and the name of the oldest employee.  */
SELECT DISTINCT first_name, last_name, hire_date
FROM employees
WHERE last_name LIKE 'E%E'
ORDER BY hire_date DESC; -- 899 total, Newest: Teiji Eldridge, Oldest: Sergi Erde

/* 7. Find all employees hired in the 90s and born on Christmas. 
Sort the results so that the oldest employee who was hired last is the first result. 
Enter a comment with the number of employees returned, the name of the oldest employee 
who was hired last, and the name of the youngest employee who was hired first.  */
SELECT *
FROM employees
-- WHERE birth_date LIKE '%-12-25' AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
WHERE birth_Date LIKE '%-12-25' AND hire_date LIKE '199%'
ORDER BY birth_date, hire_date DESC; -- 362 total, First: Khun Bernini, Last: Douadi Pettis