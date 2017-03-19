import MySQLdb
import csv

def readCSV():
	with open("books.csv") as csvfile:
		datareader = csv.reader(csvfile, delimiter='\t')
		dataAsList = map(tuple, datareader)
		return dataAsList

def cleanup(givenName):
	safeString = givenName.replace("'","''");
	return safeString

def getListOfAuthours(authors):
	listofAuthors = authors.split(',')
	return listofAuthors

try:
	db = MySQLdb.connect(host="localhost", user="root", passwd="root", db="library")

	cur = db.cursor()
	data = readCSV()

	for row in data[1:]:
		isbn = str(row[0])
		cover = row[4]
		publisher = cleanup(row[5])
		pages = row[6]
		sq = "update book set cover=\'" + cover + "\', publisher = \'" + publisher + "\', pages = "+ pages + " where isbn=\'" + isbn + "\'" 
		# authorNames = getListOfAuthours(cleanup(str(row[3])))
		# for name in authorNames:
		# 	sq = "insert into authors (name) values (\'" + name + "\');"
		# 	try:
		# 		cur.execute(sq)
		# 	except :
		# 		pass
		# authIds = []
		# for auth in authorNames:
		# 	sq = "select author_id from authors where name = \'" + auth + "\';" 
		# 	cur.execute(sq)
		# 	for row in cur.fetchall():
		# 		authIds.append(int(row[0]))

		# if len(authorNames) == 1:
		# 	sq = "insert into book_authors (isbn,author_id) values (\'" + isbn + "\',\'" + str(authIds[0]) + "\');"
		# elif len(authorNames) == 2:
		# 	sq = "insert into book_authors (isbn, author_id, author_id2) values (\'" + isbn + "\',\'" + str(authIds[0]) + "\',\'" + str(authIds[1]) + "\');"
		# elif len(authorNames) == 3:
		# 	sq = "insert into book_authors (isbn, author_id, author_id2, author_id3) values (\'" + isbn + "\',\'" + str(authIds[0]) + "\',\'" + str(authIds[1]) + "\',\'" + str(authIds[2]) + "\');"
		
		cur.execute(sq)

finally:
	cur.close()
	db.commit()
	db.close()