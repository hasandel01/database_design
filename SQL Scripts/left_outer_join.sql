SELECT Customer.name AS customer_name, Customer.email, Customer.phone_number, `Order`.order_id, `Order`.status, `Order`.total_price
FROM Customer
LEFT OUTER JOIN `Order` ON Customer.customer_id = `Order`.customer_id;