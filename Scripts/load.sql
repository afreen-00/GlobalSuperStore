

SET datestyle = 'ISO, DMY';

COPY Mega (Row_ID, Order_ID, Order_Date, Ship_Date, Ship_Mode, Customer_ID, Customer_Name, Segment, City, State, Country, Postal_Code, Market_Name, Region, Product_ID, Category, Sub_Category, Product_Name, Sales, Quantity, Discount, Profit, Shipping_Cost, Order_Priority, Category_ID, Sales_ID, Address_ID, Market_ID, Shipment_ID, Status) 
FROM 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PostgreSQL 16\Documentation\Global_Superstore_data_updated_new.csv'
DELIMITER ','
CSV HEADER;

-- SELECT * FROM Mega LIMIT 5;

-- Insert into Address
INSERT INTO Address (Address_ID, City, State, Country, Postal_Code, Region)
SELECT DISTINCT Address_ID, City, State, Country, Postal_Code, Region
FROM Mega
ON CONFLICT (Address_ID) DO NOTHING;

-- Insert into Market
INSERT INTO Market (Market_ID, Market_Name, Region)
SELECT DISTINCT Market_ID, Market_Name, Region
FROM Mega
ON CONFLICT (Market_ID) DO NOTHING;

-- Insert into Customers
INSERT INTO Customers (Customer_ID, Customer_Name, Segment, Address_ID, Market_ID)
SELECT DISTINCT Customer_ID, Customer_Name, Segment, Address_ID, Market_ID
FROM Mega
ON CONFLICT (Customer_ID) DO NOTHING;

-- Insert into Categories
INSERT INTO Categories (Category_ID, Category, Sub_Category)
SELECT DISTINCT Category_ID, Category, Sub_Category
FROM Mega
ON CONFLICT (Category_ID) DO NOTHING;

-- Insert into Products
INSERT INTO Products (Product_ID, Product_Name, Category_ID)
SELECT DISTINCT Product_ID, Product_Name, Category_ID
FROM Mega
ON CONFLICT (Product_ID) DO NOTHING;

-- Insert into Orders
INSERT INTO Orders (Order_ID, Order_Date, Customer_ID, Order_Priority)
SELECT DISTINCT Order_ID, Order_Date, Customer_ID, Order_Priority
FROM Mega
ON CONFLICT (Order_ID) DO NOTHING;

-- Insert into Order_Details
INSERT INTO Order_Details (Row_ID, Order_ID, Product_ID, Quantity)
SELECT DISTINCT Row_ID, Order_ID, Product_ID, Quantity
FROM Mega
ON CONFLICT (Row_ID) DO NOTHING;

-- Insert into Shipping
INSERT INTO Shipping (Shipment_ID, Shipping_Cost, Ship_Mode, Ship_Date, Order_ID, Address_ID)
SELECT DISTINCT Shipment_ID, Shipping_Cost, Ship_Mode, Ship_Date, Order_ID, Address_ID
FROM Mega
ON CONFLICT (Shipment_ID) DO NOTHING;

-- Insert into Sales
INSERT INTO Sales (Sales_ID, Order_ID, Product_ID, Sales, Profit)
SELECT DISTINCT Sales_ID, Order_ID, Product_ID, Sales, Profit
FROM Mega
ON CONFLICT (Sales_ID) DO NOTHING;

drop table Mega;
