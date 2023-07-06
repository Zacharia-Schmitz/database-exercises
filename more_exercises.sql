-- SELECT STATEMENTS
USE sakila; SELECT * FROM actor; -- Goes into Sakila databse, then selects all columns from the actor table
SELECT last_name FROM actor; -- Last name column only
SELECT film_id, title, release_year FROM film; -- Those columns, from film table

-- DISTINCT OPERATOR
SELECT DISTINCT last_name FROM actor; 
SELECT DISTINCT postal_code FROM address;
