
-- ------------------------------------------- GROUP BY EXERCISES ------------------------------------------------------

/* 1. Create a new file named group_by_exercises.sql */
USE employees;

/* 2. In your script, use DISTINCT to find the unique titles in the titles table. 
How many unique titles have there ever been? Answer that in a comment in your SQL file. */

SELECT COUNT(DISTINCT title)
FROM titles;

/* 3. Write a query to find a list of all unique last names that start and end with 'E' using GROUP BY. */

SELECT last_name
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name;

/* 4. Write a query to to find all unique combinations of first and last 
names of all employees whose last names start and end with 'E'. */

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name, first_name;

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY full_name;

/* 5. Write a query to find the unique last names with a 'q' but
not 'qu'. Include those names in a comment in your sql code. */

SELECT last_name
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name; -- Chleq Lindqvist Qiwen

/* 6. Add a COUNT() to your results for exercise 5 to find the number of employees with the same last name. */

SELECT last_name, COUNT(last_name) AS occurences
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name; -- 189 190 168

/* 7. Find all employees with first names 'Irena', 'Vidya', or 'Maya'. 
Use COUNT(*) and GROUP BY to find the number of employees with those names for each gender. */

SELECT first_name, gender, COUNT(*) AS same_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender;

/* 8. Using your query that generates a username for all employees,
generate a count of employees with each unique username. */

SELECT 
    CONCAT(
        LOWER(SUBSTR(first_name, 1, 1)),
        LOWER(SUBSTR(last_name, 1, 4)),
        '_',
        SUBSTR(birth_date, 6, 2),
        SUBSTR(birth_date, 3, 2)
    ) AS username,
    COUNT(*) AS username_count
FROM employees
GROUP BY username;

/* 9. From your previous query, are there any duplicate usernames?
What is the highest number of times a username shows up? Bonus: How many duplicate usernames are there? */
-- QUERY 1 counts the total usernames that have more than 1 occurence (13251)
-- QUERY 2 adds up the username_count column, meaning if it was given out 6 times, it is 6 usernames (27403)

-- QUERY 1 															
WITH duplicates AS (                                       -- Generates a Common table expression (CTE) to create a temporary named result to be used again
SELECT
CONCAT(
	LOWER(SUBSTR(first_name, 1, 1)),
	LOWER(SUBSTR(last_name, 1, 4)),
    '_',
    SUBSTR(birth_date, 6, 2),
    SUBSTR(birth_date, 3, 2)) AS username,
COUNT(*) AS username_count
FROM employees
GROUP BY username
HAVING username_count > 1)
SELECT
username,
username_count,
(SELECT COUNT(*) FROM duplicates) AS total_duplicate_usernames
FROM duplicates
ORDER BY username_count DESC; 


-- QUERY 2
SELECT  
	CONCAT(                                             							-- Generates our username
		LOWER(SUBSTR(first_name, 1, 1)),
		LOWER(SUBSTR(last_name, 1, 4)),
        '_',
		SUBSTR(birth_date, 6, 2),
		SUBSTR(birth_date, 3, 2)) AS username,
	COUNT(*) AS username_count,             									-- Counts the unique occurences of each username 
	SUM(COUNT(*)) OVER () AS total_username_count								-- Sums the total count OVER the entire result set
FROM employees
GROUP BY username
HAVING username_count > 1           	                                        -- Only show duplicate usernames
ORDER BY username_count DESC;    												-- Puts the highest username occurence on top




