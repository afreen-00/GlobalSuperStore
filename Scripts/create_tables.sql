CREATE TABLE IF NOT EXISTS Mega (
    Address_ID UUID,
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    Postal_Code VARCHAR(10),
    Region VARCHAR(50),
    Market_ID UUID,
    Market_Name VARCHAR(50),
	Status VARCHAR(10),
    Customer_ID VARCHAR(10),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Product_ID VARCHAR(20),
    Product_Name VARCHAR(255),
	Category_ID UUID,
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

CREATE TABLE IF NOT EXISTS Address (
    Address_ID UUID PRIMARY KEY, 
    City VARCHAR(50), 
    State VARCHAR(50), 
    Country VARCHAR(50), 
    Postal_Code VARCHAR(10), 
    Region VARCHAR(50) 
);

CREATE TABLE IF NOT EXISTS Market (
    Market_ID UUID PRIMARY KEY, 
    Market_Name VARCHAR(50) NOT NULL, 
    Region VARCHAR(50), 
    Status VARCHAR(10) DEFAULT 'Active' CHECK (Status IN ('Active', 'Inactive'))
);

CREATE TABLE IF NOT EXISTS Customers (
    Customer_ID VARCHAR(20) PRIMARY KEY, 
    Customer_Name VARCHAR(100) NOT NULL, 
    Segment VARCHAR(50) DEFAULT 'Consumer', 
    Address_ID UUID, 
    Market_ID UUID, 
    FOREIGN KEY (Address_ID) REFERENCES Address(Address_ID) ON DELETE CASCADE, 
    FOREIGN KEY (Market_ID) REFERENCES Market(Market_ID) ON DELETE NO ACTION 
);


CREATE TABLE IF NOT EXISTS Categories (
    Category_ID UUID PRIMARY KEY,
    Category VARCHAR(50), 
    Sub_Category VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Products (
    Product_ID VARCHAR(20) PRIMARY KEY, 
    Product_Name VARCHAR(255) NOT NULL, 
    Category_ID UUID NOT NULL,
	FOREIGN KEY (Category_ID) REFERENCES Categories(Category_ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Orders (
    Order_ID VARCHAR(15) PRIMARY KEY, 
    Order_Date DATE DEFAULT NULL, 
    Customer_ID VARCHAR(10) NOT NULL, 
    Order_Priority VARCHAR(20) DEFAULT 'Low',
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID) ON DELETE CASCADE 
);

CREATE TABLE IF NOT EXISTS Order_Details (
    Row_ID INT PRIMARY KEY, 
    Order_ID VARCHAR(15) NOT NULL, 
    Product_ID VARCHAR(20) NOT NULL, 
    Quantity INT NOT NULL DEFAULT 1 CHECK (Quantity > 0), 
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID) ON DELETE CASCADE, 
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID) ON DELETE CASCADE 
);

CREATE TABLE IF NOT EXISTS Shipping (
    Shipment_ID UUID PRIMARY KEY, 
    Shipping_Cost DECIMAL(10, 2), 
    Ship_Mode VARCHAR(20) DEFAULT 'Standard Class', 
    Ship_Date DATE DEFAULT NULL, 
    Order_ID VARCHAR(15) NOT NULL, 
    Address_ID UUID, 
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID) ON DELETE CASCADE,
    FOREIGN KEY (Address_ID) REFERENCES Address(Address_ID)
);

CREATE TABLE IF NOT EXISTS Sales (
    Sales_ID UUID PRIMARY KEY, 
    Order_ID VARCHAR(15) NOT NULL, 
    Product_ID VARCHAR(20) NOT NULL, 
    Sales DECIMAL(10, 2), 
    Profit DECIMAL(10, 2), 
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID) ON DELETE CASCADE,
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID) ON DELETE CASCADE 
);
