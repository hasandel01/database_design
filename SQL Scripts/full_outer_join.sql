SELECT Vendor.name AS vendor_name, Product.name AS product_name
FROM Vendor
LEFT JOIN VendorProduct ON Vendor.vendor_id = VendorProduct.vendor_id
LEFT JOIN Product ON VendorProduct.product_id = Product.product_id
UNION
SELECT Vendor.name AS vendor_name, Product.name AS product_name
FROM Product
LEFT JOIN VendorProduct ON Product.product_id = VendorProduct.product_id
LEFT JOIN Vendor ON VendorProduct.vendor_id = Vendor.vendor_id;
