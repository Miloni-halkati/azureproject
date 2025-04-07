-- Ensure 'gold' schema exists
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'gold')
BEGIN
    EXEC('CREATE SCHEMA gold');
END;
GO

-- Drop existing views if they already exist
DROP VIEW IF EXISTS gold.calendar;
DROP VIEW IF EXISTS gold.customers;
DROP VIEW IF EXISTS gold.products;
DROP VIEW IF EXISTS gold.returns;
DROP VIEW IF EXISTS gold.sales;
DROP VIEW IF EXISTS gold.subcat;
DROP VIEW IF EXISTS gold.territories;
DROP VIEW IF EXISTS gold.procat;
GO

-- CREATE VIEW CALENDAR
CREATE VIEW gold.calendar AS
SELECT * 
FROM OPENROWSET(
    BULK 'https://awprjstoragedatalake.blob.core.windows.net/silver/AdventureWorks_Calendar',
    FORMAT = 'PARQUET'
) AS QUERY1;
GO

-- CREATE VIEW CUSTOMERS
CREATE VIEW gold.customers AS
SELECT * 
FROM OPENROWSET(
    BULK 'https://awprjstoragedatalake.blob.core.windows.net/silver/AdventureWorks_Customers',
    FORMAT = 'PARQUET'
) AS QUERY1;
GO

-- CREATE VIEW PRODUCTS
CREATE VIEW gold.products AS
SELECT * 
FROM OPENROWSET(
    BULK 'https://awprjstoragedatalake.blob.core.windows.net/silver/AdventureWorks_Products',
    FORMAT = 'PARQUET'
) AS QUERY1;
GO

-- CREATE VIEW RETURNS
CREATE VIEW gold.returns AS
SELECT * 
FROM OPENROWSET(
    BULK 'https://awprjstoragedatalake.blob.core.windows.net/silver/AdventureWorks_Returns',
    FORMAT = 'PARQUET'
) AS QUERY1;
GO

-- CREATE VIEW SALES
CREATE VIEW gold.sales AS
SELECT * 
FROM OPENROWSET(
    BULK 'https://awprjstoragedatalake.blob.core.windows.net/ silver / AdventureWorks_Sales*',
    FORMAT = 'PARQUET'
) WITH (
    SalesID INT,
    OrderID INT,
    ProductID INT,
    CustomerID INT,
    SaleDate DATE,
    Amount DECIMAL(18,2)
) AS QUERY1;
GO

-- CREATE VIEW SUBCATEGORIES
CREATE VIEW gold.subcat AS
SELECT * 
FROM OPENROWSET(
    BULK 'https://awprjstoragedatalake.blob.core.windows.net/silver/AdventureWorks_Product_Subcategories',
    FORMAT = 'PARQUET'
) AS QUERY1;
GO

-- CREATE VIEW TERRITORIES
CREATE VIEW gold.territories AS
SELECT * 
FROM OPENROWSET(
    BULK 'https://awprjstoragedatalake.blob.core.windows.net/silver/AdventureWorks_Territories.csv',
    FORMAT = 'PARQUET'
) AS QUERY1;
GO

-- CREATE VIEW PRODUCT CATEGORIES
CREATE VIEW gold.procat AS
SELECT * 
FROM OPENROWSET(
    BULK 'https://awprjstoragedatalake.blob.core.windows.net/silver/AdventureWorks_Product_Categories/*.parquet',
    FORMAT = 'PARQUET'
) WITH (
    CategoryID INT,
    CategoryName NVARCHAR(255)
) AS QUERY1;
GO