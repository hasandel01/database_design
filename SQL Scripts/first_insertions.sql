USE EcommerceDB;

-- Insert into Branch
INSERT INTO Branch (name, address, phone) VALUES
('Central Branch', '123 Main St', '555-1234'),
('North Branch', '456 North St', '555-5678');

-- Insert into Employee table
INSERT INTO Employee (name, phone, branch_id) VALUES
('Alice Johnson', '555-1234', 1),
('Bob Smith', '555-5678', 2),
('Clark Kent', '555-1537', 1), 
('Bob Dylan', '555-1628', 2); 

########## Insertions to show join operations 
-- Insert an employee without a branch
INSERT INTO Employee (name, phone, branch_id) VALUES
('John Doe', '555-9999', NULL);

-- Insert a customer without any associated orders
INSERT INTO Customer (name, email, address, phone_number) VALUES
('John Smith', 'john@example.com', '123 Elm St', '555-1234');
########## 

-- Insert into DeliveryPersonnel table
INSERT INTO DeliveryPersonnel (employee_id, delivery_area) VALUES
(1, 'Area A'),
(2, 'Area B');

-- Insert into CustomerServiceRepresentative table
INSERT INTO CustomerServiceRepresentative (employee_id) VALUES
(3), -- Assuming employee_id 3 corresponds to a customer service representative
(4); -- Assuming employee_id 4 corresponds to another customer service representative


-- Insert into Customer
INSERT INTO Customer (name, email, address, phone_number) VALUES
('Alice Johnson', 'alice@example.com', '789 West St', '555-7890'),
('Bob Brown', 'bob@example.com', '101 East St', '555-1011');

-- Insert into Category
INSERT INTO Category (name) VALUES
('Electronics'),
('Clothing');

-- Insert into Promotion
INSERT INTO Promotion (discount_rate, start_date, end_date) VALUES
(10.00, '2024-01-01', '2024-06-30'),
(20.00, '2024-07-01', '2024-12-31');

-- Insert into Product
INSERT INTO Product (name, price, description, category_id, promotion_id, average_rating) VALUES
('Smartphone', 699.99, 'Latest model smartphone', 1, 1, NULL),
('Laptop', 999.99, 'High performance laptop', 1, 2, NULL),
('T-shirt', 19.99, 'Comfortable cotton t-shirt', 2, NULL,NULL);

-- Insert into Vendor
INSERT INTO Vendor (name, address, phone) VALUES
('Tech Supplies Inc.', '200 Tech Park', '555-2000'),
('Clothing Co.', '300 Fashion Ave', '555-3000');

-- Insert into VendorProduct
INSERT INTO VendorProduct (vendor_id, product_id, amount) VALUES
(1, 1, 30),
(1, 2, 20),
(2, 3, 10);

-- Insert into Order
INSERT INTO `Order` (order_date, delivery_date, status, total_price, customer_id, branch_id) VALUES
('2024-05-01', '2024-05-05', 'Delivered', 719.98, 1, 1),
('2024-06-01', '2024-06-05', 'Pending', 1019.98, 2, 2);

-- Insert into Incident
INSERT INTO Incident (status, report_date, resolved_date, description, order_id) VALUES
('Resolved', '2024-05-10', '2024-05-12', 'Late delivery', 1),
('Open', '2024-06-02', NULL, 'Damaged product', 2);

-- Insert into OrderItem
INSERT INTO OrderItem (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 3, 1),
(2, 2, 1);

-- Insert into ProductReview
INSERT INTO ProductReview (rating, comment, customer_id, product_id) VALUES
(5, 'Excellent product!', 1, 1),
(3, 'Average quality', 1, 3),
(4, 'Good performance', 2, 2);
