/* Cleaning Data in SQL Queries */

SELECT * FROM PortfolioProject.retail_store_inventory;

-- Identify Missing Values

SELECT * FROM PortfolioProject.retail_store_inventory
WHERE Inventory_Level IS NULL OR
Units_Sold IS NULL OR
Price IS NULL;

UPDATE PortfolioProject.retail_store_inventory r
JOIN (
    SELECT Product_id, AVG(Price) AS Avg_Price
    FROM PortfolioProject.retail_store_inventory
    WHERE Price IS NOT NULL
    GROUP BY Product_id
) AS avg_prices
ON r.Product_id = avg_prices.Product_id
SET r.Price = avg_prices.Avg_Price
WHERE r.Price IS NULL;

-- Removing Duplicates

SELECT Date, Store_id, Product_id, COUNT(*)
FROM PortfolioProject.retail_store_inventory
GROUP BY Date, Store_id, Product_id
HAVING COUNT(*) > 1;

DELETE FROM PortfolioProject.retail_store_inventory
 WHERE id NOT IN (
  SELECT MIN(id) FROM PortfolioProject.retail_store_inventory GROUP BY Date, Store_id, Product_id);

-- Standardizing Data Formats

UPDATE PortfolioProject.retail_store_inventory
SET Date = STR_TO_DATE(Date, '%m/%d/%Y'); 

UPDATE PortfolioProject.retail_store_inventory
SET Region = 'Northeast' 
WHERE Region IN ('north-east', 'North-East', 'north east');

-- Fixing Inconsistent Pricing

SELECT Product_id, MIN(Price) AS Min_Price, MAX(Price) AS Max_Price 
FROM PortfolioProject.retail_store_inventory 
GROUP BY Product_id 
HAVING MAX(Price) > MIN(Price) * 2;

-- Correcting Weather Conditions

UPDATE PortfolioProject.retail_store_inventory 
SET Weather_Condition = 'Rainy' 
WHERE Weather_Condition IN ('rain', 'raining', 'Rainy');

-- Handling Inventory Issues

SELECT * FROM PortfolioProject.retail_store_inventory WHERE Inventory_Level < 0;

UPDATE PortfolioProject.retail_store_inventory 
SET Inventory_Level = 0 
WHERE Inventory_Level < 0;

-- Fixing Demand Forecast Anomalies

SELECT Product_id, AVG(Demand_Forecast) AS Forecasted, AVG(Units_Sold) AS Actual_Sales 
FROM PortfolioProject.retail_store_inventory
GROUP BY Product_id 
HAVING ABS(AVG(Demand_Forecast) - AVG(Units_Sold)) > 50;



















