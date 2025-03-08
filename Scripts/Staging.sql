CREATE TABLE IF NOT EXISTS Staging1 (
    Address_ID UUID,
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    Postal_Code VARCHAR(10),
    Region VARCHAR(50),
    Market_ID UUID,
    Market_Name VARCHAR(50),
    Customer_ID VARCHAR(10),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Product_ID VARCHAR(20),
    Product_Name VARCHAR(255),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Order_ID VARCHAR(15),
    Order_Date DATE,
    Order_Priority VARCHAR(20),
    Row_ID INT,
    Quantity INT,
    Shipment_ID UUID,
    Shipping_Cost DECIMAL(10, 2),
    Ship_Mode VARCHAR(20),
    Ship_Date DATE,
    Sales_ID UUID,
    Sales DECIMAL(10, 2),
	Discount DECIMAL(10, 2),
    Profit DECIMAL(10, 2)
);

SET datestyle = 'ISO, DMY';

COPY Staging1 (Row_ID, Order_ID, Order_Date, Ship_Date, Ship_Mode, Customer_ID, Customer_Name, Segment, City, State, Country, Postal_Code, Market_Name, Region, Product_ID, Category, Sub_Category, Product_Name, Sales, Quantity, Discount, Profit, Shipping_Cost, Order_Priority, Sales_ID, Address_ID, Market_ID, Shipment_ID) 
FROM 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PostgreSQL 16\Documentation\Global_Superstore_updated_sample.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM Staging1 LIMIT 5;

drop table Staging1;
