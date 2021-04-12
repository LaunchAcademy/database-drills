-- ## Retrieval

-- - What titles were released in 2003?
SELECT title FROM movies WHERE year = 2003;
-- - What titles were released in 2004 and had a rating higher than 90?
SELECT title, rating FROM movies WHERE year = 2004 AND rating > 90;
-- - What actors have the last name of Wilson?
SELECT name FROM actors WHERE name like '%Wilson';
-- - What actors have the first name of Owen?
SELECT name FROM actors WHERE name LIKE 'Owen %';
-- - What studios start with "Fox"?
SELECT name FROM studios WHERE name LIKE 'Fox%';
-- - What studios involve Disney?
SELECT name FROM studios WHERE name LIKE '%Disney%';
-- - What were the top 5 rated movies in 2005?
SELECT title, rating FROM movies
WHERE year = 2005
ORDER BY rating DESC
NULLS LAST
LIMIT 5;
-- - What were the worst 10 movie titles and their ratings in 2000?
SELECT title, rating FROM movies
WHERE year = 2000
ORDER BY rating
LIMIT 10;

-- ## Advanced Retrieval

-- - What movie titles were produced by Walt Disney Pictures in 2010?
SELECT movies.title FROM movies 
JOIN studios ON movies.studio_id = studios.id
WHERE year = 2010 AND studios.name = 'Walt Disney Pictures';
-- - Who were the characters in "The Hunger Games"?
SELECT character
FROM cast_members
  JOIN movies ON movies.id = cast_members.movie_id
WHERE movies.title = 'The Hunger Games';
-- - Who acted in "The Hunger Games"?
-- Starting from actors table
-- SELECT actors.name, movies.title
-- FROM actors
--   JOIN cast_members ON cast_members.actor_id = actors.id
--   JOIN movies ON cast_members.movie_id = movies.id
-- WHERE movies.title = 'The Hunger Games' AND cast_members.character IS NOT NULL;

-- Starting from the join table
SELECT actors.name
FROM cast_members
  JOIN movies ON cast_members.movie_id = movies.id
  JOIN actors ON cast_members.actor_id = actors.id
WHERE movies.title = 'The Hunger Games';
-- - Who acted in a Star Wars movie? Be sure to include all movies.
-- - What were all of the character names for movies released in 2009?
-- - What are the character names in the "The Dark Knight Rises"?
-- - What actors and actresses have been hired by Buena Vista?

-- ## Updating

-- - Troll 2 was the best movie ever. Let's update it to have a rating of 500.
SELECT title, rating FROM movies WHERE title = 'Troll 2';
UPDATE movies
SET rating = 500
WHERE title = 'Troll 2'; 
-- - "Police Academy 4 - Citizens on Patrol" was underrated. Let's give it a 20.
-- - Matt Damon has updated his name to "The Artist Formerly Known as Matt Damon". Let's update the database to reflect this momentous change in the film industry.

-- ## Deletion
-- Delete Troll 2 forever
DELETE FROM movies
WHERE title = 'Troll 2';
-- - We want to forget Back to the Future Part III ever happened. Delete only that movie. Be sure to delete correlating `cast_member` entries first.
-- - Horror movies are too scary - delete every Horror movie. Don't forget about their correlating `cast_members` entries.
DELETE FROM cast_members
WHERE cast_members.movie_id IN (
  SELECT movies.id FROM movies
  JOIN genres ON movies.genre_id = genres.id
  WHERE genres.name = 'Horror'
);

DELETE FROM movies
WHERE movies.genre_id IN (
  SELECT genres.id FROM genres WHERE genres.name = 'Horror'
);
-- - Ben Affleck movies are also too scary - delete every movie he acted in. Wasn't that therapeutic?
-- - Fake news - we're revising history for 20th Century Fox. Delete any movie they produced that has a rating of less than 80.

-- ## Schema

-- - We're creating a reviews table so that we can store individual movie reviews. The table should have a description, score from 0-100, author name, and it should relate to a movie. Create the DDL necessary to create this table.

CREATE TABLE reviews (
  id SERIAL PRIMARY KEY,
  description VARCHAR(255) NOT NULL,
  score INTEGER,
  author_name VARCHAR(255),
  movie_id INTEGER REFERENCES movies(id)
);
-- - We're creating a crimes table for all crimes actors or actresses commit. It should include the year of offense, the title of the offense, and it should relate to the actor. Create the DDL necessary to create this table.