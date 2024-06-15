START TRANSACTION;
-- Insert into Order table
INSERT INTO `Order` (order_date, delivery_date, status, total_price, customer_id, branch_id)
VALUES ('2024-06-12', '2024-06-20', 'Pending', NULL, 1, 1);
-- Insert into OrderItem table
INSERT INTO OrderItem (order_id, product_id, quantity)
VALUES (LAST_INSERT_ID(), 1, 2),
       (LAST_INSERT_ID(), 2, 1);
COMMIT;



