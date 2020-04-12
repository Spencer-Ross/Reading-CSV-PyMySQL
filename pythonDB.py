import pymysql
from prettytable import PrettyTable
import json
import csv
# import MySQLdb


#close the connection to the database.
# mydb.commit()
# cursor.close()
# print "Done"
def getCSV():
	pass

def JSON():
	pass

def putData():
	pass

def createRelation():
	pass

def insertData():
	getCSV()
	JSON()
	putData()


def main():
	conn = pymysql.connect(
		host = 'localhost', 
		port = 3306, 
		user = 'root', 
		passwd = 'Toast51!')
	cursor = conn.cursor()

	# csv_data = csv.reader(file('students.csv'))
	# for row in csv_data:
	#     cursor.execute('INSERT INTO testcsv(names, \
	#           classes, mark )' \
	#           'VALUES("%s", "%s", "%s")', 
	#           row)

	getCSV()

	# "drop database imdb"
	# sql = "CREATE DATABASE imdb"
	# cursor.execute(sql)
	sql = "USE imdb"
	cursor.execute(sql)


	cursor.close()
	conn.close()

if __name__ == '__main__':
	main()