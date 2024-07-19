-- Add branch ID to cars:

-- Step 1: Add branch_id column
ALTER TABLE cars ADD COLUMN branch_id INT;

-- Step 2: Add foreign key constraint
ALTER TABLE cars ADD CONSTRAINT fk_branch FOREIGN KEY (branch_id) REFERENCES branch(branch_id);

-- Step 3: Update cars table to assign cars to branches
UPDATE cars SET branch_id = 1 WHERE car_id IN (1, 2);
UPDATE cars SET branch_id = 2 WHERE car_id IN (3, 4);
UPDATE cars SET branch_id = 3 WHERE car_id IN (5, 6);
UPDATE cars SET branch_id = 4 WHERE car_id IN (7, 8);
UPDATE cars SET branch_id = 5 WHERE car_id IN (9, 10);


-- Add car data
INSERT INTO cars (car_id, make, model, year, mileage, iselectric, ishybrid, isavailable, amount, amount_lease, amount_loan, color) VALUES
(1, 'Toyota', 'Camry', 2020, 15000, FALSE, FALSE, TRUE, 20000, 300, 250, 'White'),
(2, 'Honda', 'Civic', 2019, 20000, FALSE, FALSE, TRUE, 18000, 270, 230, 'Black'),
(3, 'Tesla', 'Model S', 2021, 10000, TRUE, FALSE, TRUE, 70000, 1000, 900, 'Red'),
(4, 'Ford', 'F-150', 2018, 30000, FALSE, FALSE, TRUE, 25000, 400, 350, 'Blue'),
(5, 'Chevrolet', 'Bolt', 2021, 5000, TRUE, FALSE, TRUE, 35000, 500, 450, 'Silver'),
(6, 'Nissan', 'Leaf', 2020, 12000, TRUE, FALSE, TRUE, 28000, 400, 360, 'Green'),
(7, 'BMW', 'i3', 2019, 18000, TRUE, TRUE, TRUE, 40000, 600, 550, 'Orange'),
(8, 'Audi', 'Q5', 2018, 25000, FALSE, TRUE, TRUE, 32000, 500, 450, 'Gray'),
(9, 'Hyundai', 'Ioniq', 2021, 8000, TRUE, TRUE, TRUE, 27000, 350, 320, 'Blue'),
(10, 'Kia', 'Niro', 2019, 22000, FALSE, TRUE, TRUE, 22000, 300, 280, 'White');


-- Add Branch Data
INSERT INTO branch (branch_id, branch_phonenumber, branch_name) VALUES
(1, '123-456-7890', 'Urban Customs - Downtown'),
(2, '234-567-8901', 'Urban Customs - Uptown'),
(3, '345-678-9012', 'Urban Customs - Suburban'),
(4, '456-789-0123', 'Urban Customs - Eastside'),
(5, '567-890-1234', 'Urban Customs - Westside');

