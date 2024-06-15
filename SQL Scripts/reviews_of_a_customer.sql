SELECT pr.review_id, pr.rating, pr.comment,
       c.name AS customer_name, c.email AS customer_email,
       p.name AS product_name
FROM ProductReview pr
JOIN Customer c ON pr.customer_id = c.customer_id
JOIN Product p ON pr.product_id = p.product_id
WHERE p.product_id = 1;

