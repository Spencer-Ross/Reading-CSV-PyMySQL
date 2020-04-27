-- 1. 10% What is the average budget of all movies? Your output should include just the average budget value.

SELECT avg(budget) FROM Movies;

-- 2. 10% Show only the movies that were produced in the United States. Your output must include the movie title and
-- the production company name.

SELECT distinct Movies.title, Production_Companies.name
FROM Production_Companies
JOIN Movie_Has_Production_Companies ON Production_Companies.id = Movie_Has_Production_Companies.production_companies_id
JOIN Movie_Has_Production_Countries ON Movie_Has_Production_Companies.movie_id = Movie_Has_Production_Countries.movie_id
JOIN Movies ON Movie_Has_Production_Companies.movie_id = Movies.id
WHERE Movie_Has_Production_Countries.production_countries_iso_3166_1 LIKE '%us%'; 

-- 3. 10% Show the top 5 movies that made the most revenue. Your output must include the movie title and how much revenue it brought in.

SELECT title, revenue
FROM Movies
ORDER BY Movies.revenue DESC LIMIT 5


-- 4. 10% What movies have both the genre Science Fiction and Mystery. Your output must include the movie title and all genres associated with that genre.

SELECT Movies.title, Genres.name 
FROM Movies
JOIN Movie_Has_Genres ON Movie_Has_Genres.movie_id = Movies.id
JOIN Genres ON Movie_Has_Genres.genres_id = Genres.id
WHERE Movies.id IN (
	SELECT Movie_Has_Genres.movie_id 
	FROM Genres 
	JOIN Movie_Has_Genres ON Movie_Has_Genres.genres_id = Genres.id 
	WHERE Genres.name like '%Sci%')
AND Movies.id IN (
	SELECT Movie_Has_Genres.movie_id 
	FROM Genres 
	JOIN Movie_Has_Genres 
	ON Movie_Has_Genres.genres_id = Genres.id 
	WHERE Genres.name like '%Mys%')
ORDER BY Movies.title;


-- 5. 10% Find the movies that have a popularity greater than the average popularity. Your output must include the movie title and their popularity.

SELECT title, ROUND(popularity, 2)
FROM Movies
WHERE popularity > (
	SELECT AVG(popularity)
	FROM Movies)
ORDER BY popularity;

