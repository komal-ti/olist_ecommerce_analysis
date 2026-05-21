create database olist_ecommerce;
use olist_ecommerce;
SELECT * FROM `olist_sellers_dataset - Copy` LIMIT 10;

USE olist_ecommerce;

-- 1. Check if total rows are 3095
SELECT COUNT(*) FROM `olist_sellers_dataset - Copy`;

-- 2. Check for NULL values in important columns
SELECT 
    SUM(CASE WHEN seller_id IS NULL THEN 1 ELSE 0 END) AS missing_id,
    SUM(CASE WHEN seller_city IS NULL THEN 1 ELSE 0 END) AS missing_city,
    SUM(CASE WHEN seller_state IS NULL THEN 1 ELSE 0 END) AS missing_state
FROM `olist_sellers_dataset - Copy`;
USE olist_ecommerce;

-- Check total rows (लगभग 99,441 records होने चाहिए)
SELECT COUNT(*) FROM customers;

-- Preview the data
SELECT * FROM customers LIMIT 10;
USE olist_ecommerce;

SELECT COUNT(*) AS total_customers FROM customers;
USE olist_ecommerce;


SHOW TABLES;
USE olist_ecommerce;


SELECT * FROM `product_category_name_translation` LIMIT 10;

USE olist_ecommerce;
SHOW TABLES;
SELECT * FROM `product_category_name_translation - Copy` LIMIT 10;
USE olist_ecommerce;

SELECT * FROM product_category_name_translation LIMIT 10;
SELECT COUNT(*) AS total_records FROM product_category_name_translation;
USE olist_ecommerce;

RENAME TABLE `product_category_name_translation - Copy` TO category_translation;
USE olist_ecommerce;

SELECT * FROM geolocation LIMIT 10;
SELECT COUNT(*) AS total_rows FROM geolocation;
USE olist_ecommerce;

SHOW TABLES;
USE olist_ecommerce;

SELECT COUNT(*) AS total_rows FROM geolocation;
USE olist_ecommerce;

SELECT COUNT(*) AS total_order_items FROM order_items;
SELECT * FROM order_items LIMIT 5;
USE olist_ecommerce;

SELECT order_id, order_item_id, COUNT(*) AS duplicate_count
FROM order_items
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1;

USE olist_ecommerce;

SELECT seller_id, COUNT(*) AS duplicate_count
FROM `olist_sellers_dataset - Copy`
GROUP BY seller_id
HAVING COUNT(*) > 1;

SELECT 
    COUNT(CASE WHEN seller_id IS NULL THEN 1 END) AS null_seller_id,
    COUNT(CASE WHEN seller_zip_code_prefix IS NULL THEN 1 END) AS null_zip,
    COUNT(CASE WHEN seller_city IS NULL THEN 1 END) AS null_city,
    COUNT(CASE WHEN seller_state IS NULL THEN 1 END) AS null_state
FROM `olist_sellers_dataset - Copy`;

SELECT customer_id, COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

USE olist_ecommerce;

DESCRIBE customers;
USE olist_ecommerce;

SELECT customer_id, COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;
SELECT 
    COUNT(CASE WHEN customer_id IS NULL THEN 1 END) AS null_customer_id,
    COUNT(CASE WHEN customer_unique_id IS NULL THEN 1 END) AS null_unique_id,
    COUNT(CASE WHEN customer_zip_code_prefix IS NULL THEN 1 END) AS null_zip,
    COUNT(CASE WHEN customer_city IS NULL THEN 1 END) AS null_city,
    COUNT(CASE WHEN customer_state IS NULL THEN 1 END) AS null_state
FROM customers;
show tables;
USE olist_ecommerce;


DROP TABLE IF EXISTS olist_geolocation_dataset;
USE olist_ecommerce;


USE olist_ecommerce;


SET SQL_SAFE_UPDATES = 0;


DROP TABLE IF EXISTS olist_geolocation_dataset;


ALTER TABLE order_items 
MODIFY COLUMN shipping_limit_date DATETIME;


UPDATE customers 
SET customer_city = TRIM(customer_city),
    customer_state = TRIM(customer_state);

UPDATE geolocation 
SET geolocation_city = TRIM(geolocation_city),
    geolocation_state = TRIM(geolocation_state);


SET SQL_SAFE_UPDATES = 1;

show tables;
USE olist_ecommerce;

RENAME TABLE `olist_sellers_dataset - copy` TO sellers;

USE olist_ecommerce;


ALTER TABLE orders 
MODIFY COLUMN order_purchase_timestamp DATETIME,
MODIFY COLUMN order_approved_at DATETIME,
MODIFY COLUMN order_delivered_carrier_date DATETIME,
MODIFY COLUMN order_delivered_customer_date DATETIME,
MODIFY COLUMN order_estimated_delivery_date DATETIME;

SELECT 
    order_status, 
    COUNT(*) AS total_orders,
    COUNT(CASE WHEN order_delivered_customer_date IS NULL THEN 1 END) AS missing_deliveries
FROM orders
GROUP BY order_status;

show tables;
USE olist_ecommerce;


SELECT 'orders' AS table_name, COUNT(*) AS total_rows,
       COUNT(CASE WHEN order_id IS NULL THEN 1 END) AS null_order_id,
       COUNT(CASE WHEN customer_id IS NULL THEN 1 END) AS null_customer_id
FROM orders

UNION ALL


SELECT 'order_payments', COUNT(*),
       COUNT(CASE WHEN order_id IS NULL THEN 1 END),
       COUNT(CASE WHEN payment_value IS NULL THEN 1 END)
FROM order_payments

UNION ALL


SELECT 'order_reviews', COUNT(*),
       COUNT(CASE WHEN review_id IS NULL THEN 1 END),
       COUNT(CASE WHEN order_id IS NULL THEN 1 END)
FROM order_reviews;

SELECT order_id, COUNT(*) 
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

USE olist_ecommerce;


SELECT COUNT(*) FROM products;
USE olist_ecommerce;

SELECT customer_id, COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;
SELECT 
    COUNT(CASE WHEN customer_id IS NULL THEN 1 END) AS null_customer_id,
    COUNT(CASE WHEN customer_unique_id IS NULL THEN 1 END) AS null_unique_id,
    COUNT(CASE WHEN customer_zip_code_prefix IS NULL THEN 1 END) AS null_zip,
    COUNT(CASE WHEN customer_city IS NULL THEN 1 END) AS null_city,
    COUNT(CASE WHEN customer_state IS NULL THEN 1 END) AS null_state
FROM customers;

SELECT product_id, COUNT(*) AS duplicate_count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT 
    COUNT(CASE WHEN product_id IS NULL THEN 1 END) AS null_product_id,
    COUNT(CASE WHEN product_category_name IS NULL THEN 1 END) AS null_category,
    COUNT(CASE WHEN product_weight_g IS NULL THEN 1 END) AS null_weight
FROM products;


SET SQL_SAFE_UPDATES = 0;


UPDATE products
SET product_category_name = 'Unknown'
WHERE product_category_name IS NULL;


SET SQL_SAFE_UPDATES = 1;
show tables;