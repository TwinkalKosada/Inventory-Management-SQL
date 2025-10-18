DROP DATABASE IF EXISTS Adventureworks_db;

Create Database Adventureworks_db

Use Adventureworks_db;

-- Create Table: Product
Create Table Product (
ProductID int Primary Key,
Name Varchar(40) Not Null,
ProductNumber Varchar(20) Not Null,	
MakeFlag Boolean Not Null, 
FinishedGoodsFlag Boolean Not Null,
Color Varchar(15),
SafetyStockLevel Smallint Not Null,	
ReorderPoint Smallint Not Null,
StandardCost Decimal(15, 4) Not Null,	
ListPrice Decimal(15, 4) Not Null,
Size Varchar(5),
SizeUnitMeasureCode	Char(3),
WeightUnitMeasureCode Char(3),
Weight	Decimal (10, 2),
DaysToManufacture	Int Not Null,
ProductLine	Char(2),
Class Char(2),
Style Char(2),
ProductSubcategoryID Int,   -- FK
ProductModelID	Int,
SellStartDate Datetime Not Null,
SellEndDate	Datetime,
DiscontinuedDate Datetime,
rowguid	Varchar(50) Not Null,
ModifiedDate Datetime Not Null
);


-- Create Table: ProductCategory
Create Table ProductCategory (
ProductCategoryID Int Auto_increment Primary Key,
Name Varchar(25) Not Null,
rowguid	Varchar(50) Not Null,
ModifiedDate Datetime Not Null
);

-- Create Table: Location
Create Table Location (
LocationID	Smallint Auto_increment Primary Key,
Name Varchar(40) Not Null,
CostRate Decimal(15, 4) Not Null,
Availability decimal(15, 4) Not Null,	
ModifiedDate Datetime Not Null
);


-- Create Table: ProductInventory
Create Table ProductInventory (
ProductID	Int Not Null,  -- FK
LocationID	Smallint Not Null,   -- FK
Shelf Varchar(10) Not Null,
Bin	Tinyint Not Null,
Quantity Smallint Not Null,	
rowguid	Varchar(50) Not Null,
ModifiedDate Datetime Not Null
);

-- Create Table: SalesOrderHeader
Create Table SalesOrderHeader (
SalesOrderID Int Auto_increment Primary Key,
RevisionNumber	Tinyint Not Null,
OrderDate Datetime Not Null,	
DueDate	Datetime Not Null,
ShipDate Datetime Not Null,	
Status	Tinyint Not Null,
OnlineOrderFlag	Boolean Not Null,
SalesOrderNumber Varchar(20),	
PurchaseOrderNumber	Varchar(25),
AccountNumber Varchar(15),
CustomerID	Int Not Null,
SalesPersonID Int,
TerritoryID Int,	
BillToAddressID	Int Not Null,
ShipToAddressID	Int Not Null,
ShipMethodID Int Not Null,	
CreditCardID Int,	
CreditCardApprovalCode	Varchar(15),
CurrencyRateID	Int,
SubTotal Decimal(15, 4) Not Null,
TaxAmt	Decimal(15, 4) Not Null,
Freight	Decimal(15, 4) Not Null,
TotalDue Decimal(15,4) Not Null,	
Comment	Varchar (100),
rowguid Varchar(50) Not Null,
ModifiedDate Datetime Not Null
);

-- Create Table: SalesOrderDetail
Create Table SalesOrderDetail (
SalesOrderID  Int Not Null,   -- FK
SalesOrderDetailID	Int Auto_increment Primary Key,
CarrierTrackingNumber Varchar(20),	
OrderQty Tinyint Not Null,	
ProductID Int Not Null,  -- FK
SpecialOfferID Int Not Null,	
UnitPrice Decimal(15,4) Not Null,
UnitPriceDiscount Decimal(15,4) Not Null,
LineTotal Decimal(15,4) Not Null,	
rowguid	Varchar(50) Not Null, 
ModifiedDate Datetime Not Null
);

-- Create Table: ProductSubcategory
Create Table ProductSubcategory (
ProductSubcategoryID Int Auto_increment Primary Key,	
ProductCategoryID Int Not Null,     -- FK
Name Varchar(25) Not Null,
rowguid	Varchar(50) Not Null,
ModifiedDate Datetime Not Null
);

-- Foreign key
Alter Table ProductInventory
Add Constraint fk_productid
Foreign Key (ProductID)
References Product(ProductID);

Alter Table ProductInventory
Add Constraint fk_locationid
Foreign Key (LocationID)
References Location(LocationID);

Alter Table SalesOrderDetail
Add Constraint fk_salesorderid
Foreign Key (SalesOrderID)
References SalesOrderHeader(SalesOrderID);

Alter Table ProductSubcategory
Add Constraint fk_productcategoryid
Foreign Key (ProductCategoryID)
References ProductCategory(ProductCategoryID);

Alter Table Product
Add Constraint fk_productsubcategoryid
Foreign Key (ProductSubcategoryID)
References ProductSubcategory(ProductSubcategoryID);

Alter Table SalesOrderDetail
Add Constraint fk_product_id
Foreign Key (ProductID)
References Product(ProductID);

select * from product;
select * from productcategory;
select * from productsubcategory;
select * from productinventory;
select * from location;
select * from salesorderdetail;
select * from salesorderheader


-- Project Tasks
-- Retrieve all product information, including its category and inventory levels

;
With Inventory AS (
SELECT Productid, sum(quantity) as Quantity FROM productinventory
Group by Productid)

select p.productid, p.name, pc.name as category, psc.name as subcategory, i.Quantity
from product as p
join ProductSubcategory as psc on  p.productsubcategoryid=psc.productsubcategoryid
join productcategory as pc on psc.productcategoryid=pc.productcategoryid
join Inventory as i on i.Productid = p.productid;

-- Retrieve all orders placed by customers, showing product names, order date, and quntity ordered

SELECT sod.SalesOrderID, soh.Customerid,p.name, soh.orderdate, sod.orderqty
from salesorderdetail as sod
join salesorderheader as soh on sod.SalesOrderID=soh.SalesOrderID
join product as p on sod.ProductID=p.ProductID

-- Find products that are below their reorder level in inventory

select p.name, p.reorderpoint, pi.Quantity
from product as p
join productinventory as pi on pi.ProductID=p.ProductID
where p.ReorderPoint > pi.Quantity;

-- Total quantity of products ordered per customer and month

select soh.customerid, monthname(soh.orderdate) as month, sum(sod.orderqty) as quantity
from salesorderheader as soh
join salesorderdetail as sod on sod.SalesOrderID=soh.SalesOrderID
group by 1, 2

-- Retrive inventory turnover rate per product

select p.productid,p.name as Productname,
sum(sod.orderqty) as TotalUnitSold,
avg(pi.quantity) as AvgInventory,
Round(sum(sod.orderqty) / avg(pi.quantity), 2)  as inventoryTurnoverRate
from product as p
join salesorderdetail as sod on sod.productid=p.productid
join productinventory as pi on pi.productid=p.productid
group by p.productid, p.name
Order by inventoryTurnoverRate DESC


-- Decrese Stock for a product a specific location 
Update ProductInventory
Set Quantity = Quantity - 10
Where ProductID = 911 AND LocationID = 60;

-- Add a stock record 

Insert into ProductInventory(ProductId, LocationId, Shelf, Quantity)
Values (858, 7, 'A', 50);

