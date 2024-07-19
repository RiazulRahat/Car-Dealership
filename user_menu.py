import psycopg2
from config import config

def connect():
    connection = None
    try:
        params = config()
        print('Connecting to postgreSQL database ...')
        connection = psycopg2.connect(**params)

        #create cursor
        crsr = connection.cursor()
        print('PostgreSQL database version: ')
        crsr.execute('SELECT version()')
        db_version = crsr.fetchone()
        print(db_version)
        crsr.close()
    except(Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if connection is not None:
            connection.close()
            print('Database connection terminated.')

def userLoginMenu():
    print("Welcome To The Car Dealership!")
    print("1. Login")
    print("2. Sign Up")

    num = int(input())

    if (num == 1):
        userLogin()
    elif (num == 2):
        userSignup()
    else:
        print("Wrong Entry!! Try Again!!")
        userLoginMenu()
    

def userMain_menu():
    print("MAIN MENU: ")
    print("1. View Available Cars")
    print("2. Contact Dealership")

    num = int(input())
    if (num == 1):
        pass # Data to show available cars
    elif (num == 2):
        pass # Data to contact Dealership
    else:
        print("Wrong Entry!! Try Again!!")
        userMain_menu()


def userLogin():
    username = input("Enter Your Username: ")
    password = input("Enter Your Password: ")

    #Authentication of Username
    #Authentication of Password
    connection = None
    try:
        params = config()
        connection = psycopg2.connect(**params)
        crsr = connection.cursor()
        
        crsr.execute("SELECT password FROM users WHERE username = %s", (username,))
        stored_password = crsr.fetchone()

        if stored_password and stored_password[0] == password:
            print("Login successful!")
            userMain_menu()
        else:
            print("Invalid username or password.")
        
        crsr.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if connection is not None:
            connection.close()



def userSignup():
    fName = input("Enter First Name: ")
    lName = input("Enter Last Name: ")
    username = input("Enter Your Username: ")
    password = input("Enter Password: ")
    # Add data to database
    connection = None
    try:
        params = config()
        connection = psycopg2.connect(**params)
        crsr = connection.cursor()
        
        crsr.execute("INSERT INTO users (username, password) VALUES (%s, %s)", (username, password))
        connection.commit()
        print("User registered successfully!")
        
        crsr.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if connection is not None:
            connection.close()



if __name__=="__main__":
    connect()
    userLoginMenu()