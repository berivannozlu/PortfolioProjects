/* Retail Store Inventory Data Exploration

Skills used: 

*/

-- 1. General Dataset Overview

SELECT 
    COUNT(*) AS Total_Records,
    COUNT(DISTINCT Store_id) AS Unique_Stores,
    COUNT(DISTINCT Product_id) AS Unique_Products,
    COUNT(DISTINCT Category) AS Unique_Categories
FROM PortfolioProject.retail_store_inventory;

-- 2. Sales Performance Analysis

-- Top & Bottom Selling Products

SELECT Product_id, SUM(Units_Sold) AS Total_Sales
FROM PortfolioProject.retail_store_inventory
GROUP BY Product_id
ORDER BY Total_Sales DESC
LIMIT 10; 

-- Top Revenue-Generating Products

SELECT Product_id, SUM(Units_Sold * Price) AS Total_Revenue
FROM PortfolioProject.retail_store_inventory
GROUP BY Product_id
ORDER BY Total_Revenue DESC
LIMIT 10;

-- 3. Store-Level Analysis

-- Best-Performing Stores by Sales

SELECT Store_id, Region, SUM(Units_Sold) AS Total_Units_Sold
FROM PortfolioProject.retail_store_inventory
GROUP BY Store_id, Region
ORDER BY Total_Units_Sold DESC
LIMIT 10;

-- Store-Wise Revenue & Performance

SELECT Store_id, Region, SUM(Units_Sold * Price) AS Revenue
FROM PortfolioProject.retail_store_inventory
GROUP BY Store_id, Region
ORDER BY Revenue DESC
LIMIT 10;

-- 4. Time-Based Analysis

-- Monthly Sales Trends

SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS Month, 
    SUM(Units_Sold) AS Total_Units_Sold
FROM PortfolioProject.retail_store_inventory
GROUP BY Month
ORDER BY Month;

-- Impact of Holidays/Promotions on Sales

SELECT 
    Promotion, 
    SUM(Units_Sold) AS Total_Units_Sold
FROM PortfolioProject.retail_store_inventory
GROUP BY Promotion
ORDER BY Total_Units_Sold DESC;

-- 5. Inventory & Demand Analysis

-- Stock Availability vs. Demand

SELECT 
    Product_id, 
    SUM(Inventory_Level) AS Total_Stock, 
    SUM(Demand_Forecast) AS Total_Demand
FROM PortfolioProject.retail_store_inventory
GROUP BY Product_id
ORDER BY Total_Demand DESC;

-- Out-of-Stock Rate per Store

SELECT 
    Store_id, 
    COUNT(*) AS Total_Products, 
    SUM(CASE WHEN Inventory_Level = 0 THEN 1 ELSE 0 END) AS Out_of_Stock_Count,
    (SUM(CASE WHEN Inventory_Level = 0 THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS Out_of_Stock_Percentage
FROM PortfolioProject.retail_store_inventory
GROUP BY Store_id
ORDER BY Out_of_Stock_Percentage DESC;

-- 6. Pricing & Discounts Analysis

-- Average Discount by Category

SELECT 
    Category, 
    AVG(Discount) AS Avg_Discount
FROM PortfolioProject.retail_store_inventory
GROUP BY Category
ORDER BY Avg_Discount DESC;

-- Effect of Discounts on Sales

SELECT 
    Discount, 
    SUM(Units_Sold) AS Total_Sales
FROM PortfolioProject.retail_store_inventory
GROUP BY Discount
ORDER BY Discount DESC;

-- 7. External Factors Impacting Sales

-- Weather Conditions & Sales

SELECT 
    Weather_Condition, 
    SUM(Units_Sold) AS Total_Sales
FROM PortfolioProject.retail_store_inventory
GROUP BY Weather_Condition
ORDER BY Total_Sales DESC;

-- Competitor Pricing vs. Sales

SELECT 
    Competitor_Pricing, 
    AVG(Price) AS Avg_Price, 
    SUM(Units_Sold) AS Total_Sales
FROM PortfolioProject.retail_store_inventory
GROUP BY Competitor_Pricing
ORDER BY Competitor_Pricing;













