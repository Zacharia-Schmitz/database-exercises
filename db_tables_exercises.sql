SHOW DATABASES;
USE albums_db;
SELECT DATABASE();
SHOW TABLES;
USE employees;
SELECT DATABASE();
SHOW TABLES;
DESCRIBE employees; 
-- emp_no is numeric, 
-- varchar is a string type (enum can store string values, is it in this case?)
-- birth_date, hire_date
SHOW CREATE TABLE employees;
SHOW CREATE TABLE departments;
-- No defined foreign key, no direct relationship?
SHOW CREATE TABLE dept_manager;