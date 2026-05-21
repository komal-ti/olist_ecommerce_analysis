USE olist_ecommerce;
SELECT 
    SUBSTRING(o.order_purchase_timestamp, 1, 7) AS Order_Month,
    COUNT(DISTINCT o.order_id) AS Total_Orders,
    ROUND(SUM(p.payment_value), 2) AS Monthly_Revenue
FROM order_payments p
JOIN orders o ON p.order_id = o.order_id
GROUP BY SUBSTRING(o.order_purchase_timestamp, 1, 7)
ORDER BY Order_Month ASC;

-- Top 5 Product Categories (in which month more income generted?)

DESC product_category_name_translation;

SELECT 
    t.product_category_name_english AS Category_Name,
    COUNT(oi.order_id) AS Total_Units_Sold,
    ROUND(SUM(oi.price), 2) AS Total_Revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN product_category_name_translation t ON p.product_category_name = t.`ï»¿product_category_name`
GROUP BY t.product_category_name_english
ORDER BY Total_Revenue DESC
LIMIT 5;
SELECT 
    order_status,
    COUNT(*) AS Total_Orders,
    ROUND(AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)), 1) AS Avg_Delivery_Days,
    COUNT(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 END) AS Delayed_Orders
FROM orders
WHERE order_status = 'delivered'
GROUP BY order_status;



