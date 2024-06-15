DELIMITER $$
CREATE TRIGGER update_order_total_price AFTER INSERT ON OrderItem
FOR EACH ROW
BEGIN
    UPDATE `Order` 
    SET total_price = (SELECT SUM(quantity * price) 
                       FROM OrderItem 
                       JOIN Product ON OrderItem.product_id = Product.product_id 
                       WHERE OrderItem.order_id = NEW.order_id)
    WHERE order_id = NEW.order_id;
END$$

CREATE TRIGGER update_product_avg_rating AFTER INSERT ON ProductReview
FOR EACH ROW
BEGIN
    UPDATE Product 
    SET average_rating = (SELECT AVG(rating) 
                          FROM ProductReview 
                          WHERE product_id = NEW.product_id)
    WHERE product_id = NEW.product_id;
END$$

CREATE TRIGGER notify_low_stock_products AFTER INSERT ON VendorProduct
FOR EACH ROW
BEGIN
    DECLARE product_stock INT;
    SET product_stock = (SELECT amount FROM VendorProduct WHERE product_id = NEW.product_id AND vendor_id = NEW.vendor_id);
    IF product_stock < 20 THEN
        INSERT INTO Notification (message, created_at)
        VALUES (CONCAT('Low stock alert for product: ', NEW.product_id), NOW());
    END IF;
END$$

CREATE TRIGGER delete_vendor_products
BEFORE DELETE ON Vendor
FOR EACH ROW
BEGIN
    -- Delete records from VendorProduct table referencing the deleted vendor
    DELETE FROM VendorProduct WHERE vendor_id = OLD.vendor_id;
END$$
 
CREATE TRIGGER update_product_price_on_promotion_assignment
BEFORE INSERT ON Product
FOR EACH ROW
BEGIN
    -- Update product price if a promotion is associated with the product
    IF NEW.promotion_id IS NOT NULL THEN
        SET NEW.price = NEW.price * (1 - (SELECT discount_rate FROM Promotion WHERE promotion_id = NEW.promotion_id) / 100);
    END IF;
END$$
