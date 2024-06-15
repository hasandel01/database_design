CREATE VIEW OrderDetails AS
SELECT `Order`.order_id, `Order`.order_date, `Order`.status, Customer.name AS customer_name, Customer.email
FROM `Order`
JOIN Customer ON `Order`.customer_id = Customer.customer_id;

CREATE VIEW ProductReviewsInfo AS
SELECT ProductReview.review_id, ProductReview.rating, ProductReview.comment, Product.name AS product_name
FROM ProductReview
JOIN Product ON ProductReview.product_id = Product.product_id;

CREATE VIEW OrdersByBranch AS
SELECT `Order`.order_id, `Order`.order_date, `Order`.status, Branch.name AS branch_name
FROM `Order`
JOIN Branch ON `Order`.branch_id = Branch.branch_id;

CREATE VIEW ProductsByCategory AS
SELECT Product.product_id, Product.name, Product.price, Category.name AS category_name
FROM Product
JOIN Category ON Product.category_id = Category.category_id;

CREATE VIEW TotalSalesByProduct AS
SELECT Product.product_id, Product.name, SUM(OrderItem.quantity * Product.price) AS total_sales
FROM Product
JOIN OrderItem ON Product.product_id = OrderItem.product_id
GROUP BY Product.product_id, Product.name;
