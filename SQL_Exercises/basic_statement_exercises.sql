-- 1. Use the albums_db database.
USE albums_db; -- Use the albums_db database.

-- 2. What is the primary key for the albums table?
DESCRIBE albums; -- id is the primary key, can also use "DESCRIBE albums_db.albums;"

-- 3. What does the column named 'name' represent?
SELECT * FROM albums; -- name shows the name of the album     TIP: Use the red pin to reference back to this

-- 4. What do you think the sales column represents?
-- The sales column represents the number of sales in millions

-- 5. Find the name of all albums by Pink Floyd.
SELECT name
FROM albums
WHERE artist = 'Pink Floyd'; -- Dark Side of the Moon, The Wall

-- 6. What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
SELECT release_date
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band"; -- was released in 1967

-- OR

SELECT release_date
FROM albums
WHERE name like "%Pepper%";

-- 7. What is the genre for the album Nevermind?
SELECT genre
FROM albums
WHERE name = 'Nevermind'; 
-- The genre is Grunge, Alt rock

-- 8. Which albums were released in the 1990s?
SELECT name
FROM albums
WHERE release_date
BETWEEN 1990 AND 1999;
-- 1999 to not include 2000, this is all the 90s albums

-- 9. Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.
SELECT name as low_selling_albums
FROM albums
WHERE sales < 20;
-- These are the albums with < 20 million sales

/* This is a test for a long form comment.
It can go on multiple lines.
Put the asterisk on the inside of it,
and the forward slash on the outside. */

-- RANDOM: COMMAND + ARROW KEY to go to the beginning or end of a line
-- MORE RANDOM: 'Sgt. Pepper\'s Lonely Hearts Club Band' the \ is an excape key, ignore syntax for next thing

