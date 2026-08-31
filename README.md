Markdown
# End-to-End E-Commerce Data Warehouse & BI Dashboard

A full-stack data analytics and engineering project simulating a modern corporate data pipeline. This project ingests raw retail data, models a relational star schema in PostgreSQL, performs advanced RFM (Recency, Frequency, Monetary) customer segmentation via SQL, and delivers an interactive executive dashboard in Power BI.

## 🛠️ Tech Stack & Architecture
* **Python:** Data profiling, inspection, and initial data preparation.
* **PostgreSQL:** Data warehousing, relational table design, and advanced SQL querying (CTEs, window functions, and aggregations).
* **Power BI:** Direct-query/imported dashboard development featuring custom DAX measures, star schema relationship mapping, and cross-filtered geographic analytics.

[Raw Data / Python] ──> [PostgreSQL Star Schema] ──> [Advanced SQL / RFM] ──> [Power BI Dashboard]


## 📊 Database Architecture (Star Schema)
The data warehouse is built around a centralized fact table surrounded by optimized dimension tables:
* `fact_sales`: Transaction-level grain capturing quantities, dates, customer keys, and product keys.
* `dim_customer`: Customer demographic and geographic details.
* `dim_product`: Product catalog data, categories, and standardized USD unit pricing and costs.
* `dim_store`: Retail store network information.
* `dim_exchange_rate`: Historical currency conversion reference.

## 🔍 Key SQL Analyses: RFM Customer Segmentation
To identify high-value buyers and churn risks, an advanced RFM query was executed using Common Table Expressions (CTEs):
* **Recency:** Days elapsed since the customer's last order.
* **Frequency:** Total count of distinct orders placed.
* **Monetary:** Total lifetime spend calculated across purchases.

```sql
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
    (SELECT MAX("Order Date") FROM fact_sales) - cb.last_purchase_date AS recency_days,
    cb.total_orders AS frequency,
    ROUND(cb.total_spent, 2) AS monetary_value
FROM CustomerBase cb
JOIN dim_customer c ON cb."CustomerKey" = c."CustomerKey"
ORDER BY monetary_value DESC
LIMIT 10;
📈 Power BI Executive Dashboard Highlights
High-Level KPIs: Real-time tracking of Total Revenue ($55.7M+) and Gross Profit ($32.6M+) powered by custom DAX measures (SUMX combined with relational table lookups).

Top-Performing Products: Horizontal bar charts isolating high-ticket drivers like desktop computers.

Interactive Cross-Filtering: Regional slicing enabling dynamic drill-downs by country (United States, Germany, Canada, etc.) to immediately isolate local revenue trends.
