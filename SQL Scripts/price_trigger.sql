INSERT INTO OrderItem (order_id, product_id, quantity) VALUES (1, 2, 1);
SELECT total_price FROM `Order` WHERE order_id = 1;
