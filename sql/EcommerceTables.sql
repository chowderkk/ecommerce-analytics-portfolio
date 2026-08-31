-- creating tables
Create TABLE dim_customers (
	"CustomerKey" INT PRIMARY KEY,
	"Gender" VARCHAR(50),
	"Name" VARCHAR(250),
	"City" VARCHAR(100),
	"State Code" VARCHAR(50),
	"State" VARCHAR(100),
	"Zip Code" VARCHAR(50),
	"Country" VARCHAR(100),
	"Continent" VARCHAR(100),
	"Birthday" DATE
);
Create TABLE dim_product (
	"ProductKey" INT PRIMARY KEY,
	"Product Name" VARCHAR(255),
	"Brand" VARCHAR(100),
	"Color" VARCHAR(50),
	"Unit Cost USD" NUMERIC,
    "Unit Price USD" NUMERIC,
    "SubcategoryKey" INT,
    "Subcategory" VARCHAR(100),
    "CategoryKey" INT,
    "Category" VARCHAR(100)
);
CREATE TABLE dim_store (
    "StoreKey" INT PRIMARY KEY,
    "Country" VARCHAR(100),
    "State" VARCHAR(100),
    "Square Meters" NUMERIC,
    "Open Date" DATE
);
CREATE TABLE dim_exchange_rate (
    "Date" DATE,
    "Currency" VARCHAR(10),
    "Exchange" NUMERIC
);

-- Create Fact Table
CREATE TABLE fact_sales (
    "Order Number" INT,
    "Line Item" INT,
    "Order Date" DATE,
    "Delivery Date" DATE,
    "CustomerKey" INT,
    "StoreKey" INT,
    "ProductKey" INT,
    "Quantity" INT,
    "Currency Code" VARCHAR(10)
);