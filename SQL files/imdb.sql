CREATE DATABASE IF NOT EXISTS imdb DEFAULT CHARACTER SET utf8 ;
USE imdb ;

DROP TABLE IF EXISTS Movie_Has_Genres;
DROP TABLE IF EXISTS Movie_Has_Production_Companies;
DROP TABLE IF EXISTS Movie_Has_Production_Countries;
DROP TABLE IF EXISTS Movie_Has_Keywords;
DROP TABLE IF EXISTS Movie_Has_Spoken_Languages;
DROP TABLE IF EXISTS Genres;
DROP TABLE IF EXISTS Keywords;
DROP TABLE IF EXISTS Production_Companies;
DROP TABLE IF EXISTS Production_Countries;
DROP TABLE IF EXISTS Spoken_Languages;
DROP TABLE IF EXISTS Movies;





CREATE TABLE IF NOT EXISTS Movies (
  id INT NOT NULL,
  budget BIGINT DEFAULT NULL,
  homepage VARCHAR(255) DEFAULT NULL,
  original_language CHAR(2) DEFAULT NULL,
  original_title VARCHAR(100) DEFAULT NULL,
  overview TEXT,
  popularity FLOAT(6) DEFAULT NULL,
  release_date DATE DEFAULT NULL,
  revenue BIGINT DEFAULT NULL,
  runtime FLOAT(0) DEFAULT NULL,
  status SET('Released','Rumored','Post Production') DEFAULT NULL,
  tagline TEXT,
  title VARCHAR(100) DEFAULT NULL,
  vote_average FLOAT(1) DEFAULT NULL,
  vote_count SMALLINT(5) DEFAULT NULL,
  PRIMARY KEY (id));



CREATE TABLE IF NOT EXISTS Genres (
  id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS Keywords (
  id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS Production_Companies (
  id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS Production_Countries (
  iso_3166_1 CHAR(2) NOT NULL,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (iso_3166_1));

CREATE TABLE IF NOT EXISTS Spoken_Languages(
  iso_639_1 VARCHAR(2) NOT NULL,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (iso_639_1));



CREATE TABLE IF NOT EXISTS Movie_Has_Genres (
  movie_id INT NOT NULL,
  genres_id INT NOT NULL,
  PRIMARY KEY (movie_id, genres_id),
  FOREIGN KEY (movie_id) REFERENCES Movies(id),
  FOREIGN KEY (genres_id) REFERENCES Genres(id));

CREATE TABLE IF NOT EXISTS Movie_Has_Keywords (
  movie_id INT NOT NULL,
  keywords_id INT NOT NULL,
  PRIMARY KEY (movie_id, keywords_id),
  FOREIGN KEY (movie_id) REFERENCES Movies(id),
  FOREIGN KEY (keywords_id) REFERENCES Keywords(id));

CREATE TABLE IF NOT EXISTS Movie_Has_Production_Companies (
  movie_id INT NOT NULL,
  production_companies_id INT NOT NULL,
  PRIMARY KEY (movie_id, production_companies_id),
  FOREIGN KEY (movie_id) REFERENCES Movies(id),
  FOREIGN KEY (production_companies_id) REFERENCES Production_Companies(id));

CREATE TABLE IF NOT EXISTS Movie_Has_Production_Countries (
  movie_id INT NOT NULL,
  production_countries_iso_3166_1 VARCHAR(2) NOT NULL,
  PRIMARY KEY (movie_id, production_countries_iso_3166_1),
  FOREIGN KEY (movie_id) REFERENCES Movies(id),
  FOREIGN KEY (production_countries_iso_3166_1) REFERENCES Production_Countries (iso_3166_1));

CREATE TABLE IF NOT EXISTS Movie_Has_Spoken_Languages (
  movie_id INT NOT NULL,
  spoken_languages_iso_639_1 VARCHAR(2) NOT NULL,
  PRIMARY KEY (movie_id, spoken_languages_iso_639_1),
  FOREIGN KEY (movie_id) REFERENCES Movies(id),
  FOREIGN KEY (spoken_languages_iso_639_1) REFERENCES Spoken_Languages(iso_639_1));


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO Movies(id, title, original_title, vote_count, vote_average, tagline, status, runtime, revenue, budget, release_date, original_language, popularity)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)