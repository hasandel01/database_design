-- Start the transaction
START TRANSACTION;

-- Create the employee
INSERT INTO Employee (name, phone, branch_id) VALUES ('Arthur Solomon', '2312312', 1);
SET @employee_id := LAST_INSERT_ID();

-- Assign the employee as delivery personnel
INSERT INTO DeliveryPersonnel (employee_id, delivery_area) VALUES (@employee_id, 'Downtown');

-- Check for errors
-- If an error occurs, rollback the transaction
-- Otherwise, commit the transaction
COMMIT;
