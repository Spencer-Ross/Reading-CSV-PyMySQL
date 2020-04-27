import pymysql
from prettytable import PrettyTable 

def query1(cur):
    sql = "SELECT * FROM animals"
    cur.execute(sql)
    result = cur.fetchall()

    pt = PrettyTable(['ID', 'Name', 'Type', 'Age', 'Sound'])
    for att in pt.align:
        pt.align[att] = "l"
    # pt.align['Name'] = "l"
    # pt.align['Type'] = "l"
    # pt.align['Sound'] = "l"
    # pt.align['Age'] = "r"
    for row in result:
        pt.add_row(row)

    print(pt)

def insertData(conn, cur):
    ids = [0, 1, 2, 3, 4, 5]
    name = ['Finnegan', 'Rajah', 'Horsie', 'Tiny Jones', 'Bart', 'Dedu']
    types = ['Dog', 'Tiger', 'Horse', 'Frog', 'Bat', 'Orc']
    age = [9, 4, 12, 1, 2, 92]
    sound = ['Groans', 'Growl', 'Neigh', 'Ribbit', 'Eek', 'WAAAGH']

    #This is a generator, different from a sequence
    #The executemany can be used with sequence of sequences,
    #but a generator seems to work fine
    #I believe this is because all it is doing is calling .next()
    #and not indexing directly into the sequence
    data = ((ids[i], name[i], types[i], age[i], sound[i]) for i in range(len(ids)))

    sql = "INSERT INTO animals(id, name, type, age, sound) VALUES (%s, %s, %s, %s, %s)"

    cur.executemany(sql, data)
    conn.commit()

    #Alternatively, you can insert individually like so:
    # for i, j in enumerate(ids):
    #     cur.execute(sql, (j, name[i], types[i], age[i], sound[i]))
    #     conn.commit()

def createTables(conn, cur):
    sql = "DROP TABLE IF EXISTS animals"
    cur.execute(sql)

    sql = """CREATE TABLE animals(
            id int not null,
            name varchar(50),
            type varchar(50),
            age int,
            sound varchar(50),
            primary key(id))
            """
    cur.execute(sql)
    conn.commit()


def main():
    conn = pymysql.connect(host='localhost', port=3306, user='root', passwd='password')
    cur = conn.cursor()

    # "drop database demo"
    # sql = "CREATE DATABASE demo"
    # cur.execute(sql)

    sql = "USE demo"
    cur.execute(sql)

    #create some tables
    createTables(conn, cur)
    #insert some data
    insertData(conn, cur)
    #issue some queries
    query1(cur)


    cur.close()
    conn.close()


if __name__ == '__main__':
    main()