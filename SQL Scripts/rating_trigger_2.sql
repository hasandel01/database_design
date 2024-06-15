INSERT INTO ProductReview (rating, comment, customer_id, product_id)
VALUES (4, 'Great product!', 1, 1);

SELECT average_rating FROM Product
WHERE Product.product_id = 1