-- Create database
CREATE DATABASE EcommerceDB;
USE EcommerceDB;

-- Table: Branch
CREATE TABLE Branch (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address TEXT,
    phone VARCHAR(15)
);

-- Table: Employee
CREATE TABLE Employee (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

-- Table: DeliveryPersonnel
CREATE TABLE DeliveryPersonnel (
    personnel_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT UNIQUE,
    delivery_area VARCHAR(255),
    FOREIGN KEY (personnel_id) REFERENCES Employee(employee_id)
);

-- Table: CustomerServiceRepresentative
CREATE TABLE CustomerServiceRepresentative (
    csr_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

-- Table: Customer
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    address TEXT,
    phone_number VARCHAR(15)
);

-- Table: Category
CREATE TABLE Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Table: Promotion
CREATE TABLE Promotion (
    promotion_id INT AUTO_INCREMENT PRIMARY KEY,
    discount_rate DECIMAL(5, 2),
    start_date DATE,
    end_date DATE
);

-- Table: Product
CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2),
    description TEXT,
    category_id INT,
    promotion_id INT,
    average_rating DECIMAL(3,2),
    FOREIGN KEY (category_id) REFERENCES Category(category_id),
    FOREIGN KEY (promotion_id) REFERENCES Promotion(promotion_id)
);

-- Table: Vendor
CREATE TABLE Vendor (
    vendor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address TEXT,
    phone VARCHAR(15)
);

-- Associative Table: VendorProduct (for many-to-many relationship between Vendor and Product)
CREATE TABLE VendorProduct (
    vendor_id INT,
    product_id INT,
    amount DECIMAL(10, 2), -- New column for amount
    PRIMARY KEY (vendor_id, product_id),
    FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Table: Order
CREATE TABLE `Order` (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE NOT NULL,
    delivery_date DATE,
    status VARCHAR(50),
    total_price DECIMAL(10, 2),
    customer_id INT,
    branch_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

-- Table: Incident
CREATE TABLE Incident (
    incident_id INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(50),
    report_date DATE,
    resolved_date DATE,
    description TEXT,
    order_id INT,
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id)
);

-- Table: Order Item
CREATE TABLE OrderItem (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Table: Product Review
CREATE TABLE ProductReview (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    rating INT,
    comment TEXT,
    customer_id INT,
    product_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Notification (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);