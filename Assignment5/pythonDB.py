# Spencer Ross
# CS 351
# Assignment 5

import pymysql
from prettytable import PrettyTable
import json
import csv
import pandas as pd
import sys


def main():
	password = 'password' if len(sys.argv) < 2 else sys.argv[1]
	conn = pymysql.connect(
		host   = 'localhost', 
		port   = 3306, 
		user   = 'root', 
		passwd = password)
	cursor = conn.cursor()

	# create DB
	# cursor.execute("DROP DATABASE IF EXISTS imdb")
	cursor.execute("CREATE DATABASE IF NOT EXISTS imdb")
	cursor.execute("USE imdb")
	# create tables
	createTables(conn, cursor)
	# insert data from CSV file
	putData(conn, cursor)
	# do queries to answer homework questions
	queries(conn, cursor)
	cursor.close()
	conn.close()



def createTables(conn, cursor):
	tables = 	['Movie_Has_Genres',
				'Movie_Has_Keywords',
				'Movie_Has_Production_Companies',
				'Movie_Has_Production_Countries',
				'Movie_Has_Spoken_Languages',
				'Genres',
				'Keywords',
				'Production_Companies',
				'Production_Countries',
				'Spoken_Languages',
				'Movies']
	attributes = ['Genres',
				'Keywords',
				'Production_Companies',
				'Production_Countries',
				'Spoken_Languages']
	IDs = 		['id',
				'id',
				'id',
				'iso_3166_1',
				'iso_639_1']
	types = 	['INT',
				'INT',
				'INT',
				'VARCHAR(2)',
				'VARCHAR(2)']
	hasTables = ['Movie_Has_Genres',
				'Movie_Has_Keywords',
				'Movie_Has_Production_Companies',
				'Movie_Has_Production_Countries',
				'Movie_Has_Spoken_Languages']
	hasIDs = 	['genres_id',
				'keywords_id',
				'production_companies_id',
				'production_countries_iso_3166_1',
				'spoken_languages_iso_639_1']
	# drop all tables
	for name in tables:
		cursor.execute("DROP TABLE IF EXISTS %s" %(name))
	# create tables ---
	#movies table
	cursor.execute("CREATE TABLE IF NOT EXISTS Movies (\
	  id INT NOT NULL,\
	  budget BIGINT DEFAULT NULL,\
	  homepage VARCHAR(255) DEFAULT NULL,\
	  original_language CHAR(2) DEFAULT NULL,\
	  original_title VARCHAR(100) DEFAULT NULL,\
	  overview TEXT,\
	  popularity FLOAT(6) DEFAULT NULL,\
	  release_date DATE DEFAULT NULL,\
	  revenue BIGINT DEFAULT NULL,\
	  runtime FLOAT(0) DEFAULT NULL,\
	  status SET('Released','Rumored','Post Production') DEFAULT NULL,\
	  tagline TEXT,\
	  title VARCHAR(100) DEFAULT NULL,\
	  vote_average FLOAT(1) DEFAULT NULL,\
	  vote_count SMALLINT(5) DEFAULT NULL,\
	  PRIMARY KEY (id))")
	#genres,keywords,prod_company,prod_coutnry,languages tables
	for i in range(0,5):
		cursor.execute("CREATE TABLE IF NOT EXISTS %s (\
			  %s %s NOT NULL,\
			  name VARCHAR(255),\
			  PRIMARY KEY (%s))" % (attributes[i], IDs[i], types[i], IDs[i]))
	#join tables -- has_(Genres, Keywords, Prod_Companies, Prod_Countries, Languages)
	for i in range(0,5):
		cursor.execute("CREATE TABLE IF NOT EXISTS %s (\
			  movie_id INT NOT NULL,\
			  %s %s NOT NULL,\
			  PRIMARY KEY (movie_id, %s),\
			  FOREIGN KEY (movie_id) REFERENCES Movies(id),\
			  FOREIGN KEY (%s) REFERENCES %s(%s))" % (hasTables[i], 
			  													hasIDs[i], 
			  													types[i], 
			  													hasIDs[i], 
			  													hasIDs[i],
			  													attributes[i],
			  													IDs[i]))
	conn.commit()


def putData(conn, cursor):
	csvData = pd.read_csv("tmdb_5000_movies.csv", na_filter=False, dtype=str)	
	# print(csvData['id'].iloc[5])
	for row in csvData.itertuples():
		#get movie stuff
		iD 					= row.id 
		budget 				= row.budget
		homepage 			= row.homepage
		original_language 	= row.original_language
		original_title 		= row.original_title
		overview 			= row.overview
		popularity 			= row.popularity 
		release_date 		= row.release_date 
		revenue 			= row.revenue 
		runtime 			= row.revenue 
		status 				= row.status
		tagline 			= row.tagline 
		title 				= row.title
		vote_average 		= row.vote_average
		vote_count 			= row.vote_count
		movieData = format_movie(iD,
								budget,
								homepage,
								original_language,
								original_title,
								overview,
								popularity,
								release_date,
								revenue,
								runtime,
								status,
								tagline,
								title,
								vote_average,
								vote_count)
		cursor.execute("INSERT INTO Movies(id, budget, homepage, original_language, \
			original_title, overview, popularity, release_date, revenue, runtime, status, \
			tagline, title, vote_average, vote_count)\
		VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", movieData)
		conn.commit()
	# #do select for genres
	parse_json_data(conn, cursor, csvData.genres, csvData['id'], 'Genres')
	# #do select for keywords
	parse_json_data(conn, cursor, csvData.keywords, csvData['id'], 'Keywords')
	# #do select for prod_companies
	parse_json_data(conn, cursor, csvData.production_companies, csvData['id'], 'Production_Companies')
	# #do select for prod_countries
	parse_json_data(conn, cursor, csvData.production_countries, csvData['id'], 'Production_Countries')
	# #do select for languages
	parse_json_data(conn, cursor, csvData.spoken_languages, csvData['id'], 'Spoken_Languages')
	return


def parse_json_data(conn, cursor, column, movies, table):
	checklist = []
	temp = ()
	a = ''
	if table == 'Spoken_Languages':
		a = 'iso_639_1'
	else:
		a = 'iso_3166_1' if table == 'Production_Countries' else 'id'
	for i, row in enumerate(column):
		attributes = json.loads(row)
		for attribute in attributes:
			if attribute not in checklist:
				checklist.append(attribute)
				temp = (attribute.get(a), attribute.get('name'))
				insert_data(conn, cursor, table, temp)
		for attribute in attributes:
			temp = (int(movies[i]), attribute.get(a))
			insert_data(conn, cursor, 'Has_'+table, temp)
	return

def insert_data(conn, cursor, opt, data):
	if opt == 'Genres':
		cursor.execute("INSERT INTO Genres(id, name) VALUES (%s, %s)", data)
		conn.commit()
	elif opt == 'Has_Genres':
		cursor.execute("INSERT INTO Movie_Has_Genres(movie_id, genres_id) VALUES (%s, %s)", data)
		conn.commit()
	elif opt == 'Keywords':
		cursor.execute("INSERT INTO Keywords(id, name) VALUES (%s, %s)", data)
		conn.commit()
	elif opt == 'Has_Keywords':
		cursor.execute("INSERT INTO Movie_Has_Keywords(movie_id, keywords_id) VALUES (%s, %s)", data)
		conn.commit()
	elif opt == 'Production_Companies':
		cursor.execute("INSERT INTO Production_Companies(id, name) VALUES (%s, %s)", data)
		conn.commit()
	elif opt == 'Has_Production_Companies':
		cursor.execute("INSERT INTO Movie_Has_Production_Companies(movie_id, production_companies_id) \
			VALUES (%s, %s)", data)
		conn.commit()
	elif opt == 'Production_Countries':
		cursor.execute("INSERT INTO Production_Countries(iso_3166_1, name) VALUES (%s, %s)", data)
		conn.commit()
	elif opt == 'Has_Production_Countries':
		cursor.execute("INSERT INTO Movie_Has_Production_Countries(movie_id, production_countries_iso_3166_1) \
			VALUES (%s, %s)", data)
		conn.commit()
	elif opt == 'Spoken_Languages':
		cursor.execute("INSERT INTO Spoken_Languages(iso_639_1, name) VALUES (%s, %s)", data)
		conn.commit()
	elif opt == 'Has_Spoken_Languages':
		cursor.execute("INSERT INTO Movie_Has_Spoken_Languages(movie_id, spoken_languages_iso_639_1) \
			VALUES (%s, %s)", data)
		conn.commit()
	return


def format_movie(iD, 
				budget, 
				homepage, 
				original_language, 
				original_title, 
				overview, 
				popularity, 
				release_date, 
				revenue, 
				runtime, 
				status, 
				tagline, 
				title, 
				vote_average, 
				vote_count):
	if len(iD) == 0:
		return
	tempID 		= int(iD)
	tempBudge 	= int(budget) if len(budget) != 0 else None
	tempHP 		= homepage if len(homepage) != 0 else None
	tempOL 		= original_language if len(original_language) != 0 else None
	tempOT 		= original_title if len(original_title) != 0 else None
	tempOver 	= overview if len(overview) != 0 else None
	tempPop 	= float(popularity) if len(popularity) != 0 else None
	tempRD 		= release_date if len(release_date) != 0 else None
	tempRev 	= int(revenue) if len(revenue) != 0 else None
	tempRun 	= float(runtime) if len(runtime) != 0 else None
	tempStat 	= status if len(status) != 0 else None
	tempTag 	= tagline if len(tagline) != 0 else None
	tempTitl 	= title if len(title) != 0 else None
	tempVA 		= float(vote_average) if len(vote_average) != 0 else None
	tempVC 		= int(vote_count) if len(vote_count) != 0 else None
	return (tempID,
			tempBudge,
			tempHP,
			tempOL,
			tempOT,
			tempOver,
			tempPop,
			tempRD,
			tempRev,
			tempRun,
			tempStat,
			tempTag,
			tempTitl,
			tempVA,
			tempVC)


def queries(conn, cursor):
	number = input("Enter question number: ")
	if number == '1': 
		cursor.execute("SELECT AVG(budget) FROM Movies")
		conn.commit()
		result = cursor.fetchall()
		pt = PrettyTable(['budget'])
		for att in pt.align:
			pt.align[att] = "l"
		for row in result:
			pt.add_row(row)
	elif number == '2':
		cursor.execute("SELECT distinct Movies.title, Production_Companies.name \
			FROM Production_Companies \
			JOIN Movie_Has_Production_Companies ON Production_Companies.id = Movie_Has_Production_Companies.production_companies_id \
			JOIN Movie_Has_Production_Countries ON Movie_Has_Production_Companies.movie_id = Movie_Has_Production_Countries.movie_id \
			JOIN Movies ON Movie_Has_Production_Companies.movie_id = Movies.id \
			WHERE Movie_Has_Production_Countries.production_countries_iso_3166_1 LIKE '%us%' \
			LIMIT 5")
		conn.commit()
		result = cursor.fetchall()
		pt = PrettyTable(['Movies_title', 'Production_Companies_name'])
		for att in pt.align:
			pt.align[att] = "l"
		for row in result:
			pt.add_row(row)
	elif number == '3':
		cursor.execute("SELECT title, revenue \
			FROM Movies \
			ORDER BY Movies.revenue DESC LIMIT 5")
		conn.commit()
		result = cursor.fetchall()
		pt = PrettyTable(['title',
						'revenue'])
		for att in pt.align:
			pt.align[att] = "l"
		for row in result:
			pt.add_row(row)
	elif number == '4': 
		cursor.execute("SELECT Movies.title, Genres.name \
			FROM Movies \
			JOIN Movie_Has_Genres ON Movie_Has_Genres.movie_id = Movies.id \
			JOIN Genres ON Movie_Has_Genres.genres_id = Genres.id \
			WHERE Movies.id IN ( \
				SELECT Movie_Has_Genres.movie_id  \
				FROM Genres  \
				JOIN Movie_Has_Genres ON Movie_Has_Genres.genres_id = Genres.id \
				WHERE Genres.name like '%Sci%') \
			AND Movies.id IN (\
				SELECT Movie_Has_Genres.movie_id \
				FROM Genres \
				JOIN Movie_Has_Genres \
				ON Movie_Has_Genres.genres_id = Genres.id \
				WHERE Genres.name like '%Mys%') \
			ORDER BY Movies.title \
			LIMIT 5")
		conn.commit()
		result = cursor.fetchall()
		pt = PrettyTable(['Movies_title',
						'Genres_name'])
		for att in pt.align:
			pt.align[att] = "l"
		for row in result:
			pt.add_row(row)
	elif number == '5': 
		cursor.execute("SELECT title, ROUND(popularity, 2) \
			FROM Movies \
			WHERE popularity > (\
				SELECT AVG(popularity)\
				FROM Movies)\
				ORDER BY popularity \
				LIMIT 5")
		conn.commit()
		result = cursor.fetchall()
		pt = PrettyTable(['title',
						'popularity'])
		for att in pt.align:
			pt.align[att] = "l"
		for row in result:
			pt.add_row(row)

	print(pt)



if __name__ == '__main__':
	main()