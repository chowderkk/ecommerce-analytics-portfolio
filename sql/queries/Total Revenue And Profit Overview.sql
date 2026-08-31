--Total Revenue and Profit Overview
SELECT 
	COUNT(s."Order Number") AS total_transactions,
	SUM(s."Quantity") AS total_unit_sold,
	ROUND(SUM(s."Quantity" * p."Unit Price USD"), 2) AS total_revenue_usd,
	ROUND(SUM(s."Quantity" * (p."Unit Price USD" - p."Unit Cost USD")), 2) AS total_profit_usd

FROM fact_sales s
JOIN dim_product p ON s."ProductKey" = p."ProductKey";
