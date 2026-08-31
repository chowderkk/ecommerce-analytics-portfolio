--Top 5 Products by Revenue
SELECT 
	p."Product Name",
	p."Category",
	SUM(s."Quantity") AS total_unit_sold,
	ROUND(SUM(s."Quantity" * p."Unit Price USD"), 2) AS total_revenue_usd
FROM fact_sales s
JOIN dim_product p ON s."ProductKey" = p."ProductKey"
GROUP BY p."Product Name", p."Category"
ORDER BY total_revenue_usd DESC
LIMIT 5;