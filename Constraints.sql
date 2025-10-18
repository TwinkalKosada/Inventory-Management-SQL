USE adventureworks_db

-- create default contraints for product table

ALTER TABLE Product MODIFY COLUMN Makeflag Tinyint DEFAULT 1;
ALTER TABLE Product MODIFY COLUMN FinishedGoodsFlag Tinyint DEFAULT 1;
ALTER TABLE Product MODIFY COLUMN SafetyStockLevel Int DEFAULT 0;
ALTER TABLE Product MODIFY COLUMN ReorderPoint Int DEFAULT 0;
ALTER TABLE Product MODIFY COLUMN StandardCost Decimal(10, 2) DEFAULT 0.00;
ALTER TABLE Product MODIFY COLUMN ListPrice Decimal(10, 2)  DEFAULT 0.00;
ALTER TABLE Product MODIFY COLUMN Weight Decimal(10, 2)   DEFAULT 0.00;
ALTER TABLE Product MODIFY COLUMN DaysToManufacture Int DEFAULT 0;
ALTER TABLE Product MODIFY COLUMN ProductLine Char(2) DEFAULT Null;
ALTER TABLE Product MODIFY COLUMN Class Char(1) DEFAULT Null;
ALTER TABLE Product MODIFY COLUMN SellEndDate Date DEFAULT Null;
ALTER TABLE Product MODIFY COLUMN rowguid Char(50) DEFAULT (UUID());
ALTER TABLE Product MODIFY COLUMN ModifiedDate Datetime DEFAULT Current_timestamp;

-- create default contraints for location table

ALTER TABLE location MODIFY COLUMN CostRate Decimal(10, 2) Default 0.00;
ALTER TABLE location MODIFY COLUMN Availability Decimal(10, 2) Default 0.00;
ALTER TABLE location MODIFY COLUMN ModifiedDate Datetime Default Current_timestamp; 

-- create default contraints for ProductCategory table

ALTER TABLE ProductCategory MODIFY COLUMN rowguid Char(50) DEFAULT (UUID());
ALTER TABLE ProductCategory MODIFY COLUMN ModifiedDate Datetime DEFAULT Current_timestamp; 

-- create default contraints for ProductCategory table

ALTER TABLE ProductSubCategory MODIFY COLUMN rowguid Char(50) DEFAULT (UUID());
ALTER TABLE ProductSubCategory MODIFY COLUMN ModifiedDate Datetime DEFAULT Current_timestamp;

-- create default contraints for ProductInventory table

ALTER TABLE Productinventory MODIFY COLUMN Bin Int DEFAULT 0;
ALTER TABLE Productinventory MODIFY COLUMN Quantity Int DEFAULT 0;
ALTER TABLE ProductInventory MODIFY COLUMN rowguid Char(50) DEFAULT (UUID());
ALTER TABLE ProductInventory MODIFY COLUMN ModifiedDate Datetime DEFAULT Current_timestamp;

-- create default contraints for SalesOrderDetail table

ALTER TABLE SalesOrderDetail  MODIFY COLUMN UnitPriceDiscount Decimal (10, 2) DEFAULT 0.00;
ALTER TABLE SalesOrderDetail  MODIFY COLUMN rowguid Char(50) DEFAULT (UUID());
ALTER TABLE SalesOrderDetail  MODIFY COLUMN ModifiedDate Datetime DEFAULT Current_timestamp;

-- create default contraints for SalesOrderHeader table

ALTER TABLE SalesOrderHeader  MODIFY COLUMN RevisionNumber INT DEFAULT 0;
ALTER TABLE SalesOrderHeader  MODIFY COLUMN OrderDate Datetime DEFAULT Current_timestamp;
ALTER TABLE SalesOrderHeader  MODIFY COLUMN Status Tinyint DEFAULT 1;
ALTER TABLE SalesOrderHeader  MODIFY COLUMN OnlineOrderFlag TinyInt DEFAULT 1;
ALTER TABLE SalesOrderHeader  MODIFY COLUMN SubTotal Decimal(10 ,2) DEFAULT 0.00;
ALTER TABLE SalesOrderHeader  MODIFY COLUMN TaxAmt Decimal(10 ,2) DEFAULT 0.00;
ALTER TABLE SalesOrderHeader  MODIFY COLUMN Freight Decimal(10 ,2) DEFAULT 0.00;
ALTER TABLE SalesOrderHeader  MODIFY COLUMN rowguid Char(50) DEFAULT (UUID());
ALTER TABLE SalesOrderHeader  MODIFY COLUMN ModifiedDate Datetime DEFAULT Current_timestamp;


-- Add check contraints for Location Table

ALTER TABLE Location ADD CONSTRAINT CK_Location_CostRate CHECK (CostRate >= 0.00);
ALTER TABLE Location ADD CONSTRAINT CK_Location_Availability CHECK (Availability >= 0.00);

-- Add check contraints ProductInventory Table

ALTER TABLE ProductInventory ADD CONSTRAINT CK_ProductInventory_Bin CHECK (Bin >= 0 AND Bin <= 100);
ALTER TABLE ProductInventory ADD CONSTRAINT CK_ProductInventory_Shelf CHECK (Shelf REGEXP '^[A-Za-z]*$' OR Shelf = 'N/A');

-- Add check contraints SalesOrderHeader Table

ALTER TABLE SalesOrderHeader  ADD CONSTRAINT CK_SalesOrderHeader_DueDate CHECK (DueDate >= OrderDate);
ALTER TABLE SalesOrderHeader  ADD CONSTRAINT CK_SalesOrderHeader_ShipDate CHECK (ShipDate >= OrderDate);
ALTER TABLE SalesOrderHeader  ADD CONSTRAINT CK_SalesOrderHeader_Status CHECK (Status >= 0.00);
ALTER TABLE SalesOrderHeader  ADD CONSTRAINT CK_SalesOrderHeader_SubTotal CHECK (SubTotal >= 0 AND Status <= 8);
ALTER TABLE SalesOrderHeader  ADD CONSTRAINT CK_SalesOrderHeader_TaxAmt CHECK (TaxAmt >= 0.00);
ALTER TABLE SalesOrderHeader  ADD CONSTRAINT CK_SalesOrderHeader_Freight CHECK (Freight >= 0.00);