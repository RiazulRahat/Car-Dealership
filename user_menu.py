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
    while True:
        print("Welcome To The Car Dealership!")
        print("1. Login")
        print("2. Sign Up")
        print("3. Exit")

        num = int(input())

        if (num == 1):
            userLogin()
        elif (num == 2):
            userSignup()
        elif (num == 3):
            print("Exiting program. ")
            break
        else:
            print("Wrong Entry!! Try Again!!")
    

def userMain_menu():
    while True:
        print("MAIN MENU: ")
        print("1. View Available Cars")
        print("2. Contact Dealership")
        print("3. Logout")

        num = int(input())
        if (num == 1):
            # Data to show available cars
            viewAvailableCars()

        elif (num == 2):
            pass # Data to contact Dealership
        elif (num == 3):
            print("Logging out.")
            break
        else:
            print("Wrong Entry!! Try Again!!")


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
    while True:
        fName = input("Enter First Name: ").strip()
        lName = input("Enter Last Name: ").strip()
        username = input("Enter Your Username: ").strip()
        password = input("Enter Password: ").strip()

        if not fName or not lName or not username or not password:
                print("All fields are required. Please try again.")
        else:
            break

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

def viewAvailableCars():
    connection = None
    try:
        params = config()
        connection = psycopg2.connect(**params)
        crsr = connection.cursor()
        
        crsr.execute("SELECT year, make, model, mileage, amount FROM cars")
        cars = crsr.fetchall()
        
        if cars:
            print("Available Cars:")
            print("[] - table column name")
            for idx, car in enumerate(cars, start=1):
                print(f"{idx}. {car[0]} {car[1]} {car[2]} - mileage: {car[3]} - Buy price: {car[4]}")
        else:
            print("No available cars.")
        
        crsr.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if connection is not None:
            connection.close()
        
    input("Press Enter to return to the main menu...")

if __name__=="__main__":
    connect()
    userLoginMenu()
