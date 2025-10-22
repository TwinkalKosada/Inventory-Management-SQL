# Inventory Management System (MySQL)

This project is a relational database model designed to manage inventory operations.  
It uses structured data to model products, categories, stock levels, locations, and order activity to support inventory movement, monitoring, and reporting.

---

## Tools and Technologies
- MySQL Workbench – data modeling and EER diagram
- MySQL Server – database creation and queries
- CSV Import – real data population
- GitHub – version control and documentation

 ## Business Insights

This project is designed to turn raw inventory and sales data into practical insights that help businesses manage stock more efficiently and make better decisions.

Product Overview: Gives a clear picture of all products, their categories, and current stock levels. Useful for tracking what’s in inventory.

Customer Orders: Shows what customers are buying and when. Helps identify demand trends and top-selling products.

Reorder Alerts: Highlights products that are running low, so they can be restocked before they run out.

Monthly Trends: Reveals which months and customers drive the most orders, supporting smarter planning and forecasting.

Inventory Turnover: Identifies fast- and slow-moving products, helping reduce overstock and optimize storage.

Stock Update: Allows real-time stock adjustments to keep inventory records accurate.

---

## Database Schema Overview
The database includes the following tables:

- Product – product details and attributes  
- ProductCategory and ProductSubcategory – product classification  
- Location – storage location details  
- ProductInventory – stock tracking  
- SalesOrderHeader and SalesOrderDetail – order activity linked to inventory movement

EER Diagram:  
![EER Diagram](images/EER_Diagram.png)


---

## Project Files

| File | Description |
|------|-------------|
| `Inventory_Model.mwb` | MySQL Workbench model |
| `Inventory-Management-SQL.sql` | Main script (tables, relationships, and queries) |
| `Constraints.sql` | Check constraints and default values |
| `EER_Diagram.png` | ERD diagram image |
| `data/` | CSV files for data import |

## Data Cleaning & Preparation

- Adjusted column formats to match SQL data types (e.g., converting dates to `YYYY-MM-DD`, ensuring decimal precision).  
- Removed unnecessary columns and standardized null values.  
- Validated foreign key columns to maintain referential integrity.  
- Ensured consistency between related tables (e.g., product and inventory tables).

---

## How to Set Up the Database

1. Create a new schema in MySQL Workbench:
   ```sql
   CREATE DATABASE inventory_db;
   USE inventory_db;
   
2. Run the SQL scripts in order:
   - `Inventory-Management-SQL.sql`
   - `Constraints.sql`
  
3. Import the CSV data into each table:

   - Right-click the target table in MySQL Workbench (e.g., `Product`)
   - Select **“Table Data Import Wizard”**
   - Browse and select the matching CSV file from the `data` folder
   - Click **Next** → check column mapping → **Next** → **Finish**
   
| Table Name         | CSV File                                                |
| ------------------ | ------------------------------------------------------- |
| ProductCategory    | [ProductCategory.csv](./data/ProductCategory.csv)       |
| ProductSubcategory | [ProductSubcategory.csv](./data/ProductSubcategory.csv) |
| Product            | [Product.csv](./data/Product.csv)                       |
| Location           | [Location.csv](./data/Location.csv)                     |
| ProductInventory   | [ProductInventory.csv](./data/ProductInventory.csv)     |
| SalesOrderHeader   | [SalesOrderHeader.csv](./data/SalesOrderHeader.csv)     |
| SalesOrderDetail   | [SalesOrderDetail.csv](./data/SalesOrderDetail.csv)     |


   📌 *Note: Make sure you import data in the correct order to avoid foreign key conflicts (e.g., category → subcategory → product → others).*
   
3. Refresh your schema to confirm the data is loaded successfully.

## Learning Outcomes

Designing a normalized inventory management schema

Creating relationships between product, stock, and order tables

Importing large CSV datasets into MySQL

Writing analytical queries for inventory metrics

## Data Source

This project uses the AdventureWorks sample database provided by Microsoft as the primary data source.
AdventureWorks is a publicly available sample database designed for learning and demonstration purposes.

Source: [Microsoft AdventureWorks Sample Database](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver17&tabs=ssms)

License: Microsoft Sample Data License

## Support
If you have any Doubts,queries or Suggestions, please Connect with me on [LinkedIn](https://www.linkedin.com/in/twinkal-kosada-4909ba266/)


