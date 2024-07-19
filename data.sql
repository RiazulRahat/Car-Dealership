-- Add car data
INSERT INTO cars (car_id, make, model, year, mileage, is_electric, is_hybrid, is_available, amount, amount_loan, color, branch_id) VALUES
(1, 'Toyota', 'Camry', 2020, 15000, FALSE, FALSE, TRUE, 20000, 250, 'White', 1),
(2, 'Honda', 'Civic', 2019, 20000, FALSE, FALSE, TRUE, 18000, 230, 'Black', 1),
(3, 'Tesla', 'Model S', 2021, 10000, TRUE, FALSE, TRUE, 70000, 900, 'Red', 2),
(4, 'Ford', 'F-150', 2018, 30000, FALSE, FALSE, TRUE, 25000, 350, 'Blue', 2),
(5, 'Chevrolet', 'Bolt', 2021, 5000, TRUE, FALSE, TRUE, 35000, 450, 'Silver', 3),
(6, 'Nissan', 'Leaf', 2020, 12000, TRUE, FALSE, TRUE, 28000, 360, 'Green', 3),
(7, 'BMW', 'i3', 2019, 18000, TRUE, TRUE, TRUE, 40000, 550, 'Orange', 4),
(8, 'Audi', 'Q5', 2018, 25000, FALSE, TRUE, TRUE, 32000, 450, 'Gray', 4),
(9, 'Hyundai', 'Ioniq', 2021, 8000, TRUE, TRUE, TRUE, 27000, 320, 'Blue', 5),
(10, 'Kia', 'Niro', 2019, 22000, FALSE, TRUE, TRUE, 22000, 280, 'White', 5);


-- Add Branch Data
INSERT INTO branch (branch_id, branch_phonenumber, branch_name) VALUES
(1, '123-456-7890', 'Urban Customs - Downtown'),
(2, '234-567-8901', 'Urban Customs - Uptown'),
(3, '345-678-9012', 'Urban Customs - Suburban'),
(4, '456-789-0123', 'Urban Customs - Eastside'),
(5, '567-890-1234', 'Urban Customs - Westside');

-- Tables for username and password

-- customer
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL
);

-- employee
CREATE TABLE empUsers (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL
);

-- Insert data into users table
INSERT INTO users (username, password) VALUES
('ABC', 'ABC'),
('RiazC', 'RiazC'),
('ArnobC', 'ArnobC'),
('JohnC', 'JohnC'),
('JaneC', 'JaneC');

-- Insert data into empUsers table
INSERT INTO empUsers (username, password) VALUES
('Riaz', 'Riaz'),
('AB', 'AB'),
('Arnob', 'Arnob'),
('JohnDoe', 'JohnDoe'),
('JaneSmith', 'JaneSmith');
