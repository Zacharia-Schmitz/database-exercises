-- 1. Open MySQL Workbench and login to the database server
-- 2. Save your work in a file named db_tables_exercises.sql

-- 3. List all the databases
SHOW DATABASES;

-- 4. Write the SQL code necessary to use the albums_db database
USE albums_db;

-- 5. Show the currently selected database
SELECT DATABASE(); 

-- 6. List all tables in the database
SHOW TABLES;

-- 7. Write the SQL code to switch to the employees database
USE employees;

-- 8. Show the currently selected database
SELECT DATABASE();

-- 9. List all tables in the database
SHOW TABLES;

-- 10. Explore the employees table. What different data types are present in this table?
DESCRIBE employees;   -- If not within correct database, you can dot into it. ex: (database.table) employees.employees

-- 11. Which table(s) do you think contain a numeric type column? Used the above DESCRIBE call.
-- emp_no is a numeric type column

-- 12. Which table(s) do you think contain a string type column?
-- varchar is a string type column

-- 13. Which table(s) do you think contain a date type column?
-- birth_date, hire_date are date type columns

-- 14. What is the relationship between the employees and the departments tables?
-- Shared primary key
SELECT 
    TABLE_NAME,
    COLUMN_NAME as 'Primary Key'
FROM
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
    CONSTRAINT_NAME = 'PRIMARY'
    AND TABLE_SCHEMA = 'employees';

-- 15. Show the SQL code that created the dept_manager table
SHOW CREATE TABLE dept_manager;

/* This is a test
for a long form
comment line. The
asterisk goes on
the inside, and 
the forward slash
goes on the outside. */

 