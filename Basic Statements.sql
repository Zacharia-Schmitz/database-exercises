-- SQL NOTES: 


-- Two dashes make a single line comment in SQL
/*
This is
a multi line comment */
-- Ask the server: What section am I in presently?
SELECT database ();
-- answer: NULL (you aren't anywhere yet)
-- SELECT => fetch me
-- database() ==> parens means this is a function call
-- The function checks which database is current
-- USE will guide me to the databse I want to see
USE fruits_db;

SELECT database ();

USE employees;

-- SELECT, what do?
-- Command + / will comment out where the cursor is
-- Command + Enter will run the current line

-- SELECT will present info back to the user

 SELECT 'hello robinson'; -- This will be a print function within SQL (Useless)
 
 DESCRIBE fruits; -- This will describe the fields within fruits table
 
 SELECT name FROM fruits; -- This will give you all of the rows within fruits
 
 SELECT * FROM fruits; -- This will show the entire table
 
 SHOW TABLES; -- Will show tables of current Schema you are in
 
 SELECT * FROM fruits_db.fruits; -- this format will pull up without having to be in that database
 
 DESCRIBE fruits; -- This will tell you the formats within the table
 
 SELECT DISTINCT item_name FROM orders; -- Will select all unique lines
 
 SELECT name AS these_are_terrible_fruits FROM fruits; -- rename a field in the output
 
 SELECT id, quantity, id + quantity AS added_column FROM fruits; -- rename a column that I made 
 
 SELECT * FROM fruits WHERE quantity < 5; -- Straightforward
 
 --    = (Equal to), > (Greater than), < (Less than), >= (Greater than or equal to), != (Not equal to)
 
 SELECT * FROM fruits WHERE name = 'cantelope'; -- Equivilancy name works for strings as well
 
 SELECT * FROM fruits WHERE name LIKE '%an%'; -- Selecting anything with an anywhere in the name, %an would be ending, an% would be beginning
 
 SELECT * FROM fruits WHERE quantity BETWEEN 2 AND 5; -- Self explanatory
 
 SELECT * FROM fruits WHERE quantity >= 2 AND quantity <=4; -- Same thing, little more complex
 
 Numerical Functions:

1. AVG: Calculates the mean of a numerical sequence.
   Example: SELECT AVG(sales) FROM orders;

2. MIN: Finds the minimum value in a numerical sequence.
   Example: SELECT MIN(price) FROM products;

3. MAX: Finds the maximum value in a numerical sequence.
   Example: SELECT MAX(quantity) FROM inventory;

String Functions:

1. CONCAT: Concatenates multiple strings or column values together.
   Example: SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM customers;

2. SUBSTR: Extracts a portion of a string based on the specified start index and length.
   Example: SELECT SUBSTR(description, 1, 10) FROM products;

3. UPPER: Converts a string to uppercase.
   Example: SELECT UPPER(name) FROM employees;

4. LOWER: Converts a string to lowercase.
   Example: SELECT LOWER(email) FROM users;

5. REPLACE: Replaces occurrences of a substring within a string with a specified replacement.
   Example: SELECT REPLACE(text, 'old', 'new') FROM messages;

Date and Time Functions:

1. NOW: Retrieves the current date and time.
   Example: SELECT NOW();

2. CURDATE: Retrieves the current date.
   Example: SELECT CURDATE();

3. CURTIME: Retrieves the current time.
   Example: SELECT CURTIME();

4. UNIX_TIMESTAMP: Converts a date or date-time value to a UNIX timestamp.
   Example: SELECT UNIX_TIMESTAMP('2023-07-06 10:30:00');

Casting:

Casting allows converting one data type to another.

Example: SELECT CAST(quantity AS VARCHAR) FROM inventory;
 