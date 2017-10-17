What was done:
1. Created five tables
•	City - table with city names
•	Stores - table with company stores, has a foreign key related to City table
•	ProductType - table with list of available product types
•	Product - table with list of available products, has a foreign key related to ProductType table
•	Price – contains price for each product in each store, has a foreign keys related to Product and Stores tables
Each table has three additional columns:
•	IsActive – when 1 means that row is not marked as deleted, when 0 row is marked as deleted.
•	ChangeDate – date when row was added or changed
•	ChangedUser – name of user who added row
These three columns added to have a logging of made changes and to have a historical data for future reports.
Therefore, we not making any deletions from database tables, instead we mark rows as deleted. For those proposes we have spatial stored procedures names procDelete[tablename].
2. For each table created trigger for update, that logs changes to “ChangeDate” and “ChangedUser” columns. Also if row marked as deleted it marcs related rows in related tables as deleted too, for example when we mark some city as deleted then trigger will set all stores in this city as deleted.  
Probably triggers it`s not greatest idea and I could do such things with stored procedures, but usually such tables is note very loaded and triggers wouldn`t create any impact on performance.
2. Created five views for each table from which application can get data.
3. Created stored procedures to add create or delete data from tables.
In procedure procAddOrChangePrice I use user-defined table type to add or change many prices at one time.
