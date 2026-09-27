SET SQL_SAFE_UPDATES = 0;

UPDATE blinkit SET Item_Fat_Content = 'Low Fat'
WHERE Item_Fat_Content IN ('LF', 'low fat');

UPDATE blinkit SET Item_Fat_Content = 'Regular'
WHERE Item_Fat_Content = 'reg';

SELECT DISTINCT Item_Fat_Content FROM blinkit;

-- KPI 1: Total Sales Revenue
SELECT ROUND(SUM(Item_Outlet_Sales), 2) AS total_sales
FROM blinkit;

-- KPI 2: Average Sales per item
SELECT ROUND(AVG(Item_Outlet_Sales), 2) AS avg_sales
FROM blinkit;

-- KPI 3: Total number of items
SELECT COUNT(*) AS total_items FROM blinkit;

-- Q1: Sales by Fat Content
SELECT Item_Fat_Content,
       ROUND(SUM(Item_Outlet_Sales), 2) AS total_sales,
       COUNT(*) AS item_count
FROM blinkit
GROUP BY Item_Fat_Content;

-- Q2: Which item types generate the most revenue?
SELECT Item_Type,
       ROUND(SUM(Item_Outlet_Sales), 2) AS total_sales,
       COUNT(*) AS item_count
FROM blinkit
GROUP BY Item_Type
ORDER BY total_sales DESC;

-- Q3: Sales performance by outlet size
SELECT Outlet_Size,
       ROUND(SUM(Item_Outlet_Sales), 2) AS total_sales,
       COUNT(*) AS outlet_count,
       ROUND(AVG(Item_Outlet_Sales), 2) AS avg_sales_per_item
FROM blinkit
GROUP BY Outlet_Size
ORDER BY total_sales DESC;

-- Q4: Which location tier performs best?
SELECT Outlet_Location_Type,
       ROUND(SUM(Item_Outlet_Sales), 2) AS total_sales
FROM blinkit
GROUP BY Outlet_Location_Type
ORDER BY total_sales DESC;

-- Q5: Sales by outlet type
SELECT Outlet_Type,
       ROUND(SUM(Item_Outlet_Sales), 2) AS total_sales,
       COUNT(*) AS item_count,
       ROUND(AVG(Item_Outlet_Sales), 2) AS avg_sales
FROM blinkit
GROUP BY Outlet_Type
ORDER BY total_sales DESC;

-- Q6: Top selling items by MRP price range
SELECT
  CASE
    WHEN Item_MRP < 50 THEN 'Budget (Under 50)'
    WHEN Item_MRP BETWEEN 50 AND 100 THEN 'Mid (50-100)'
    WHEN Item_MRP BETWEEN 100 AND 200 THEN 'Premium (100-200)'
    ELSE 'Luxury (200+)'
  END AS price_range,
  COUNT(*) AS item_count,
  ROUND(SUM(Item_Outlet_Sales), 2) AS total_sales
FROM blinkit
GROUP BY price_range
ORDER BY total_sales DESC;

-- Q7: Best performing outlet type + location combo
SELECT Outlet_Type, Outlet_Location_Type,
       ROUND(SUM(Item_Outlet_Sales), 2) AS total_sales
FROM blinkit
GROUP BY Outlet_Type, Outlet_Location_Type
ORDER BY total_sales DESC
LIMIT 10;

-- Total revenue
SELECT ROUND(SUM(Item_Outlet_Sales), 2) AS total_sales FROM blinkit;

-- Low Fat vs Regular
SELECT Item_Fat_Content, ROUND(SUM(Item_Outlet_Sales), 2) AS total_sales
FROM blinkit GROUP BY Item_Fat_Content;

-- Best outlet size
SELECT Outlet_Size, ROUND(SUM(Item_Outlet_Sales), 2) AS total_sales
FROM blinkit GROUP BY Outlet_Size ORDER BY total_sales DESC;

-- Best location tier
SELECT Outlet_Location_Type, ROUND(SUM(Item_Outlet_Sales), 2) AS total_sales
FROM blinkit GROUP BY Outlet_Location_Type ORDER BY total_sales DESC;
