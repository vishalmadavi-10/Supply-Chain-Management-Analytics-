create database supply_chain_management;
use supply_chain_management;
-- 1. Order & Sales KPIs
-- Total Orders
SELECT CONCAT(ROUND(COUNT(Order_ID)/1000,1),'K') AS Total_Orders
FROM Fact_Orders;
--
-- Total Sales Revenue
SELECT
CONCAT('₹', FORMAT(SUM(Revenue)/1000000,2), 'M') AS Total_Sales_Revenue
FROM Fact_Orders;
-- Average Order Value (AOV)
SELECT ROUND(SUM(Revenue) / COUNT(Order_ID), 2) AS Average_Order_Value
FROM Fact_Orders;
-- Orders by Region
SELECT Region, COUNT(Order_ID) AS Total_Orders
FROM Fact_Orders
GROUP BY Region
ORDER BY Total_Orders DESC;

-- 2.Inventory & Stock KPIs
-- Stock on Hand
SELECT
CONCAT('₹', FORMAT(SUM(Stock_On_Hand)/1000000,2), 'M') AS Stock_On_Hand
FROM Fact_Inventory;
-- Reorder Status
SELECT
COUNT(*) AS Products_To_Reorder
FROM Fact_Inventory
WHERE Stock_On_Hand < Reorder_Level;
-- Average Days of Supply
SELECT ROUND(AVG(Days_Of_Supply),2) AS Avg_Days_Of_Supply
FROM Fact_Inventory;
-- Inventory Turnover Ratio
SELECT
ROUND(SUM(COGS)/SUM(`Inventory_Value`),2) AS Inventory_Turnover
FROM Fact_Inventory;
-- 3. Procurement & Cost KPIs
SELECT
CONCAT('₹', FORMAT(SUM(Procurement_Cost)/1000000, 2), 'M') AS Procurement_Cost
FROM Fact_Orders;
SELECT
CONCAT('₹', FORMAT(SUM(Shipping_Cost)/1000000, 2), 'M') AS Transportation_Cost
FROM Fact_Orders;
SELECT
CONCAT('₹', FORMAT(SUM(Total_Cost)/1000000, 2), 'M') AS Total_Supply_Chain_Cost
FROM Fact_Orders;
SELECT
CONCAT('₹', FORMAT(SUM(Total_Cost)/SUM(Order_Quantity),2)) AS Cost_Per_Unit
FROM Fact_Orders;

-- 4. Logistics & Delivery KPIs
-- On-Time Delivery %
SELECT
ROUND(
100 * SUM(CASE WHEN Delivery_Status='On-Time' THEN 1 ELSE 0 END)
/COUNT(*),2
) AS On_Time_Delivery_Percentage
FROM Fact_Orders;
-- Average Delay
SELECT ROUND(AVG(Delay_Days),2) AS Average_Delay
FROM Fact_Orders;
-- Orders by Ship Mode
SELECT Ship_Mode,
COUNT(Order_ID) AS Orders
FROM Fact_Orders
GROUP BY Ship_Mode;
-- Carrier Utilization
SELECT Carrier,
COUNT(Order_ID) AS Total_Orders
FROM Fact_Orders
GROUP BY Carrier
ORDER BY Total_Orders DESC;
-- 5. Demand & Fulfillment KPIs
-- Average Fill Rate
SELECT ROUND(AVG(Fill_Rate),2) AS Average_Fill_Rate
FROM Fact_Orders;
-- Average Backorder Rate
SELECT ROUND(AVG(`Backorder_Rate`),2) AS Backorder_Rate
FROM Fact_Orders;
-- Order Accuracy Rate
SELECT ROUND(AVG(`Order_Accuracy_Rate`),2) AS Order_Accuracy
FROM Fact_Orders;
-- Average Customer Fulfillment Cycle
SELECT ROUND(AVG(`Customer_0rder_Fulfillment_Cycle`),2)
AS Customer_Fulfillment_Cycle
FROM Fact_Orders;