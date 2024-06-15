SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;

-- Update the delivery date of an order
UPDATE `Order`
SET delivery_date = '2024-06-25'
WHERE order_id = 1;

-- Insert an incident record for the change in delivery date
INSERT INTO Incident (status, report_date, description, order_id)
VALUES ('Change in Delivery Date', CURDATE(), 'The delivery date of the order has been updated to 2024-06-25.', 1);

-- Check if the update and insertion were successful
SELECT * FROM `Order` WHERE order_id = 1 AND delivery_date = '2024-06-25';
SELECT * FROM Incident WHERE order_id = 1;

COMMIT;
