USE olist_ecommerce;

SELECT 
    COUNT(DISTINCT order_id) AS Total_Orders,
    ROUND(SUM(payment_value), 2) AS Total_Revenue,
    ROUND(AVG(payment_value), 2) AS Average_Order_Value
FROM order_payments;

SELECT 
    c.customer_state AS State,
    COUNT(o.order_id) AS Total_Orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY Total_Orders DESC
LIMIT 5;

SELECT 
    payment_type AS Payment_Method,
    COUNT(order_id) AS Number_of_Transactions,
    ROUND(SUM(payment_value), 2) AS Total_Amount_Paid
FROM order_payments
GROUP BY payment_type
ORDER BY Total_Amount_Paid DESC;

USE olist_ecommerce;



