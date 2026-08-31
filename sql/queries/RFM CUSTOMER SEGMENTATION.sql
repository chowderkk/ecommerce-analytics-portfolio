--RFM CUSTOMER SEGMENTATION

WITH CustomerBase AS (
    SELECT 
        s."CustomerKey",
        MAX(s."Order Date") AS last_purchase_date,
        COUNT(DISTINCT s."Order Number") AS total_orders,
        SUM(s."Quantity" * p."Unit Price USD") AS total_spent
    FROM fact_sales s
    JOIN dim_product p ON s."ProductKey" = p."ProductKey"
    GROUP BY s."CustomerKey"
)
SELECT 
    c."CustomerKey",
    c."Name",
    c."Country",
    cb.last_purchase_date,
    -- We calculate Recency by finding the difference between the max date in the whole dataset and this customer's last purchase
    (SELECT MAX("Order Date") FROM fact_sales) - cb.last_purchase_date AS recency_days,
    cb.total_orders AS frequency,
    ROUND(cb.total_spent, 2) AS monetary_value
FROM CustomerBase cb
JOIN dim_customers c ON cb."CustomerKey" = c."CustomerKey"
ORDER BY monetary_value DESC
LIMIT 10;