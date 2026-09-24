-- 1. DROP EXISTING TABLES TO START FRESH
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

-- 2. CREATE CUSTOMERS TABLE
CREATE TABLE Customers (
    Customer_ID VARCHAR(50) PRIMARY KEY,
    Customer_Name VARCHAR(50),
    Region VARCHAR(50),
    Segment VARCHAR(50)
);

-- 3. INSERT 10 ROWS INTO CUSTOMERS
INSERT INTO Customers (Customer_ID, Customer_Name, Region, Segment) VALUES
('C001', 'Alice Johnson', 'North', 'Corporate'),
('C002', 'Bob Smith', 'South', 'Consumer'),
('C003', 'Charlie Brown', 'West', 'Home Office'),
('C004', 'Kisan Sethy', 'East', 'Customer Support'),
('C005', 'Rudra Tripathy', 'West', 'Software Engineer'),
('C006', 'Nandini Mahapatra', 'East', 'SAP Analyst'),
('C007', 'Naresh Biswal', 'West', 'Software Developer'),
('C008', 'Chiku Tripathy', 'South', 'Doctor'),
('C009', 'Dibyanka Panda', 'East', 'Nurse'),
('C010', 'Ipsita Malli', 'North', 'Dancer');

-- 4. CREATE ORDERS TABLE
CREATE TABLE Orders (
    Order_ID VARCHAR(50) PRIMARY KEY,
    Order_Date DATE,
    Customer_ID VARCHAR(50),
    Product_Category VARCHAR(50),
    Sales DECIMAL(10,2),
    Quantity INT,
    Profit DECIMAL(10,2),
    Discount DECIMAL(4,2),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- 5. INSERT 10 ROWS INTO ORDERS
INSERT INTO Orders (Order_ID, Order_Date, Customer_ID, Product_Category, Sales, Quantity, Profit, Discount) VALUES
('O001', '2026-09-01', 'C001', 'Electronics', 1200.00, 3, 300.00, 0.05),
('O002', '2026-09-02', 'C002', 'Furniture', 850.50, 2, 120.00, 0.10),
('O003', '2026-09-02', 'C003', 'Office Supplies', 45.00, 1, 15.20, 0.00),
('O004', '2026-09-03', 'C004', 'Electronics', 600.00, 4, 80.00, 0.15),
('O005', '2026-09-04', 'C005', 'Office Supplies', 120.00, 2, 45.00, 0.00),
('O006', '2026-09-04', 'C006', 'Furniture', 450.00, 1, -25.00, 0.20),
('O007', '2026-09-05', 'C007', 'Electronics', 2100.00, 5, 500.00, 0.05),
('O008', '2026-09-05', 'C008', 'Office Supplies', 85.00, 3, 30.00, 0.00),
('O009', '2026-09-06', 'C009', 'Furniture', 320.00, 2, 65.00, 0.10),
('O010', '2026-09-06', 'C010', 'Electronics', 150.00, 1, 40.00, 0.00);

-- 6. VIEW BOTH TABLES TO CHECK DATA
SELECT * FROM Customers;
SELECT 
o.Order_ID,
o.Order_Date,
c.Customer_name,
c.Region,
c.Segment,
o.Product_Category,
o.Sales,
o.Profit
FROM Orders o
INNER JOIN Customers c
ON o.Customer_ID=c.Customer_ID;
SELECT * FROM Orders;
SELECT 
    Product_Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percentage
FROM Orders
GROUP BY Product_Category;
SELECT 
    DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Month,
    SUM(Sales) AS Total_Sales,
    COUNT(Order_ID) AS Total_Orders
FROM Orders
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY Order_Month;
SELECT 
    c.Customer_Name, 
    c.Region,
    SUM(o.Sales) AS Total_Revenue
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name, c.Region
ORDER BY Total_Revenue DESC
LIMIT 5;