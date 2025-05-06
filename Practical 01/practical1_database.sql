--Name- Arya Jain
-- Create Product table
CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR2(100),
    Category VARCHAR2(100),
    Description VARCHAR2(500),
    Cost_Price DECIMAL(10,2),
    Selling_Price DECIMAL(10,2),
    Stock_Quantity INT,
    Reorder_Level INT
);

-- Create Supplier table
CREATE TABLE Supplier (
    Supplier_ID INT PRIMARY KEY,
    Supplier_Name VARCHAR2(100),
    Contact_Number VARCHAR2(20),
    Email VARCHAR2(100),
    Address VARCHAR2(200)
);

-- Create Customer table
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR2(100),
    Contact_Number VARCHAR2(20),
    Email VARCHAR2(100),
    Address VARCHAR2(200)
);

-- Create Warehouse table
CREATE TABLE Warehouse (
    Warehouse_ID INT PRIMARY KEY,
    Warehouse_Location VARCHAR2(100),
    Capacity INT
);

-- Create Purchase_Order table
CREATE TABLE Purchase_Order (
    PO_ID INT PRIMARY KEY,
    Supplier_ID INT,
    Product_ID INT,
    Order_Date DATE,
    Quantity_Ordered INT,
    Total_Cost DECIMAL(10,2),
    Status VARCHAR2(50),
    FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Supplier_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

-- Create Sales_Order table
CREATE TABLE Sales_Order (
    SO_ID INT PRIMARY KEY,
    Customer_ID INT,
    Product_ID INT,
    Order_Date DATE,
    Quantity_Sold INT,
    Total_Price DECIMAL(10,2),
    Status VARCHAR2(50),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

-- Create Inventory_Transaction table
CREATE TABLE Inventory_Transaction (
    Transaction_ID INT PRIMARY KEY,
    Product_ID INT,
    Warehouse_ID INT,
    Transaction_Type VARCHAR2(50),
    Quantity INT,
    Transaction_Date DATE,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Warehouse_ID) REFERENCES Warehouse(Warehouse_ID)
);

-- Create User table 
CREATE TABLE User_Table (
    User_ID INT PRIMARY KEY,
    User_Name VARCHAR2(100),
    Role VARCHAR2(50),
    Password VARCHAR2(100)
);

-- Create Reports table
CREATE TABLE Reports (
    Report_ID INT PRIMARY KEY,
    Generated_By INT,
    Report_Type VARCHAR2(50),
    Generated_Date DATE,
    FOREIGN KEY (Generated_By) REFERENCES User_Table(User_ID)
);

