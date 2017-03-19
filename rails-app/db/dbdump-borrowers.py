import MySQLdb
import csv

def readCSV():
	with open("borrowers.csv") as csvfile:
		datareader = csv.reader(csvfile, delimiter=',')
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
		borrowerId = row[0]
		ssn = row[1]
		name = cleanup(row[2]+ " "+row[3])
		phone = row[8]
		address = cleanup(row[5]+", " + row[6]+", "+row[7])

		sq = "insert into borrower (card_id,ssn, bname, address,phone) values (" + str(borrowerId) + ",\'" + ssn + "\',\'" + name + "\',\'" + address + "\',\'" + phone + "\')"
		
		cur.execute(sq)

finally:
	cur.close()
	db.commit()
	db.close()