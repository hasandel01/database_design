-- Delete the vendor
DELETE FROM Vendor WHERE vendor_id = 1;

-- Check the product table to ensure the products linked to the vendor are deleted
SELECT * FROM VendorProduct