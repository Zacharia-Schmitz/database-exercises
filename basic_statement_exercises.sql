USE albums_db; -- Use the albums_db database.
DESCRIBE albums; -- id is the primary key
SELECT * FROM albums; -- name shows the name of the album     TIP: Use the red pin to reference back to this
-- The sales column represents the number of sales in millions
SELECT name FROM albums WHERE artist = 'Pink Floyd'; -- Dark Side of the Moon, The Wall
SELECT release_date FROM albums WHERE name = "Sgt. Pepper's Lonely Hearts Club Band"; -- was released in 1967
SELECT genre FROM albums WHERE name = 'Nevermind'; -- The genre is Grunge, Alt rock
SELECT name FROM albums WHERE release_date BETWEEN 1990 AND 1999; -- 1999 to not include 2000, this is all the 90s albums
SELECT name as low_selling_albums FROM albums WHERE sales < 20; -- These are the albums with < 20 million sales