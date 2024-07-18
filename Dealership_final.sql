"""CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    PhoneNumber VARCHAR(20),
    Email VARCHAR(100),
    F_Name VARCHAR(50),
    L_Name VARCHAR(50),
    DOB DATE
);

CREATE TABLE Address (
    addr_id SERIAL PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(50),
    zip VARCHAR(20)
);
CREATE TABLE CustomerAddress (
    addr_id INT,
    customer_id INT,
    PRIMARY KEY (addr_id, customer_id),
    FOREIGN KEY (addr_id) REFERENCES Address(addr_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(CustomerID)
);
CREATE TABLE Branch (
    branch_id SERIAL PRIMARY KEY,
    branch_phoneNumber VARCHAR(20),
    branch_name VARCHAR(100),
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES Address(addr_id)
);
CREATE TABLE BranchAddress (
    branch_id INT,
    addr_id INT,
    PRIMARY KEY (branch_id, addr_id),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id),
    FOREIGN KEY (addr_id) REFERENCES Address(addr_id)
);
CREATE TABLE Cars (
    car_id SERIAL PRIMARY KEY,
    make VARCHAR(50),
    model VARCHAR(50),
    year INT,
    mileage INT,
    is_electric BOOLEAN,
    is_hybrid BOOLEAN,
    is_available BOOLEAN DEFAULT TRUE,
    amount DECIMAL(10, 2),
    amount_lease DECIMAL(10, 2),
    amount_loan DECIMAL(10, 2),
    color VARCHAR(30)
);

CREATE TABLE HasCar (
    branch_id INT,
    car_id INT,
    PRIMARY KEY (branch_id, car_id),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id),
    FOREIGN KEY (car_id) REFERENCES Cars(car_id)
);

CREATE TABLE Employees (
    employeeID SERIAL PRIMARY KEY,
    F_Name VARCHAR(50),
    L_Name VARCHAR(50),
    email VARCHAR(100),
    phoneNumber VARCHAR(20),
    branchID INT,
    FOREIGN KEY (branchID) REFERENCES Branch(branch_id)
);
CREATE TABLE Payments (
    payment_id SERIAL PRIMARY KEY,
    cust_id INT,
    car_id INT,
    employeeID INT,
    date_signing DATE,
    FOREIGN KEY (cust_id) REFERENCES Customers(CustomerID),
    FOREIGN KEY (car_id) REFERENCES Cars(car_id),
    FOREIGN KEY (employeeID) REFERENCES Employees(employeeID)
);
CREATE TABLE Lease (
    payment_id INT PRIMARY KEY,
    lease_time INT, -- Lease time in months
    FOREIGN KEY (payment_id) REFERENCES Payments(payment_id)
);
CREATE TABLE Loan (
    payment_id INT PRIMARY KEY,
    loan_time INT, -- Loan time in months
    FOREIGN KEY (payment_id) REFERENCES Payments(payment_id)
);
CREATE TABLE Buy (
    payment_id INT PRIMARY KEY,
    FOREIGN KEY (payment_id) REFERENCES Payments(payment_id)
);

CREATE OR REPLACE FUNCTION set_car_unavailable() RETURNS TRIGGER AS $$
BEGIN
    -- Update the Cars table to set is_available to FALSE for the car in the new payment
    UPDATE Cars SET is_available = FALSE WHERE car_id = NEW.car_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_payment
BEFORE INSERT ON Payments
FOR EACH ROW
EXECUTE FUNCTION set_car_unavailable();"""


-- Create the Address table
CREATE TABLE Address (
    addr_id SERIAL PRIMARY KEY,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip VARCHAR(20) NOT NULL
);

-- Create the Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    PhoneNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    F_Name VARCHAR(50) NOT NULL,
    L_Name VARCHAR(50) NOT NULL,
    DOB DATE NOT NULL
);

-- Create the CustomerAddress table
CREATE TABLE CustomerAddress (
    addr_id INT NOT NULL,
    customer_id INT NOT NULL,
    PRIMARY KEY (addr_id, customer_id),
    FOREIGN KEY (addr_id) REFERENCES Address(addr_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(CustomerID)
);

-- Create the Branch table
CREATE TABLE Branch (
    branch_id SERIAL PRIMARY KEY,
    branch_phoneNumber VARCHAR(20) NOT NULL,
    branch_name VARCHAR(100) NOT NULL
);

-- Create the BranchAddress table
CREATE TABLE BranchAddress (
    branch_id INT NOT NULL,
    addr_id INT NOT NULL,
    PRIMARY KEY (branch_id, addr_id),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id),
    FOREIGN KEY (addr_id) REFERENCES Address(addr_id)
);

-- Create the Cars table
CREATE TABLE Cars (
    car_id SERIAL PRIMARY KEY,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    year INT NOT NULL,
    mileage INT NOT NULL,
    is_electric BOOLEAN NOT NULL,
    is_hybrid BOOLEAN NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    amount DECIMAL(10, 2) NOT NULL,
    amount_lease DECIMAL(10, 2),
    amount_loan DECIMAL(10, 2),
    color VARCHAR(30) NOT NULL
);

-- Create the HasCar table
CREATE TABLE HasCar (
    branch_id INT NOT NULL,
    car_id INT NOT NULL,
    PRIMARY KEY (branch_id, car_id),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id),
    FOREIGN KEY (car_id) REFERENCES Cars(car_id)
);

-- Create the Employees table
CREATE TABLE Employees (
    employeeID SERIAL PRIMARY KEY,
    F_Name VARCHAR(50) NOT NULL,
    L_Name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phoneNumber VARCHAR(20) NOT NULL,
    branchID INT NOT NULL,
    FOREIGN KEY (branchID) REFERENCES Branch(branch_id)
);

-- Create the Payments table
CREATE TABLE Payments (
    payment_id SERIAL PRIMARY KEY,
    cust_id INT NOT NULL,
    car_id INT NOT NULL,
    employeeID INT NOT NULL,
    date_signing DATE NOT NULL,
    FOREIGN KEY (cust_id) REFERENCES Customers(CustomerID),
    FOREIGN KEY (car_id) REFERENCES Cars(car_id),
    FOREIGN KEY (employeeID) REFERENCES Employees(employeeID)
);

-- Create the Lease table
CREATE TABLE Lease (
    payment_id INT PRIMARY KEY,
    lease_time INT NOT NULL, -- Lease time in months
    FOREIGN KEY (payment_id) REFERENCES Payments(payment_id)
);

-- Create the Loan table
CREATE TABLE Loan (
    payment_id INT PRIMARY KEY,
    loan_time INT NOT NULL, -- Loan time in months
    FOREIGN KEY (payment_id) REFERENCES Payments(payment_id)
);

-- Create the Buy table
CREATE TABLE Buy (
    payment_id INT PRIMARY KEY,
    FOREIGN KEY (payment_id) REFERENCES Payments(payment_id)
);

-- Create the function to set is_available to FALSE
CREATE OR REPLACE FUNCTION set_car_unavailable() RETURNS TRIGGER AS $$
BEGIN
    -- Update the Cars table to set is_available to FALSE for the car in the new payment
    UPDATE Cars SET is_available = FALSE WHERE car_id = NEW.car_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger for before insert on Payments table
CREATE TRIGGER before_insert_payment
BEFORE INSERT ON Payments
FOR EACH ROW
EXECUTE FUNCTION set_car_unavailable();
