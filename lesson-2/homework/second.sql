Basic-Level Tasks (10)
--Create a table Employees with columns: EmpID INT, Name (VARCHAR(50)), and Salary (DECIMAL(10,2)).
	create table Employees(EmpID int, Name varchar(50), Salary decimal(10,2))
--Insert three records into the Employees table using different INSERT INTO approaches (single-row insert and multiple-row insert).
	--single-row insert
insert Employees values (1,'John', 15),(3, 'Bale', 12),(2, 'Smith', 13)
     --multiple-row insert
	insert Employees values (1,'John', 15)
	insert Employees values (3, 'Bale', 12)
	insert Employees values (2, 'Smith', 13)
	Select * from Employees
--Update the Salary of an employee to 7000 where EmpID = 1.
	UPDATE Employees
	SET Salary=7000
	WHERE EmpID=1;
--Delete a record from the Employees table where EmpID = 2.
	delete from Employees
	where EmpID=2
--Give a brief definition for difference between DELETE, TRUNCATE, and DROP.
	DELETE: Removes specific rows from a table based on a condition, leaving the table structure intact. It is a DML (Data Manipulation Language) command, logged for recovery, and can be rolled back in a transaction. Example:  DELETE FROM Products WHERE Price < 10;
	TRUNCATE: Removes all rows from a table, resetting it to an empty state, but keeps the table structure. It is a DDL (Data Definition Language) command, typically faster than DELETE as it does not log individual row deletions, and cannot be rolled back in some DBMS. Example TRUNCATE TABLE Products;
	DROP: Completely removes a table (or other database object) and its structure from the database, including all data, indexes, and constraints. It is a DDL command, not reversible without a backup, and frees up storage space. Example: DROP TABLE Products;
--Modify the Name column in the Employees table to VARCHAR(100).aa
	Alter table Employees
	alter column Name varchar(100)

--Add a new column Department (VARCHAR(50)) to the Employees table.
	Alter table Employees
	add Department varchar(50)

--Change the data type of the Salary column to FLOAT.
   Alter table Employees
   alter column Salary float

--Create another table Departments with columns DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50)).
	create table Departments (DepartmentID int Primary key, DepartmentName varchar(50))

--Remove all records from the Employees table without deleting its structure.
	Delete from Employees;
Intermediate-Level Tasks (6)

--Insert five records into the Departments table using INSERT INTO SELECT method(you can write anything you want as data).
	insert into Departments
	Select 5,'Human Resources'
	insert into Departments
	Select 3,'Finance'
	insert into Departments
	Select 2,'Marketing',2000
	insert into Departments
	Select 6,'Information Technology'
	insert into Departments
	Select 4,'Operations'
--Update the Department of all employees where Salary > 5000 to 'Management'.
	Update Departments
	Set DepartmentName='Management'
	Where Salary>5000
--Write a query that removes all employees but keeps the table structure intact.
	truncate table Employees
--Drop the Department column from the Employees table.
	alter table Employees
	drop column Department
--Rename the Employees table to StaffMembers using SQL commands.
	Select * from Employees as StaffMembers 
--Write a query to completely remove the Departments table from the database.
	 Drop table Departments
Advanced-Level Tasks (9)
--Create a table named Products with at least 5 columns, including: ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)
	Create table Products (ProductID int Primary key, ProductName varchar(50), Category varchar(50) , Price decimal)

--Add a CHECK constraint to ensure Price is always greater than 0.

	Alter table Products
	add check (Price>0)

--Modify the table to add a StockQuantity column with a DEFAULT value of 50.
	ALTER TABLE Products
	ADD StockQuantity INT DEFAULT 50;
--Rename Category to ProductCategory
	EXEC sp_rename 'Products.Category',  'ProductCategory', 'COLUMN';
--Insert 5 records into the Products table using standard INSERT INTO queries.
	Insert into Products (ProductID, ProductName,Category,Price)
	Values (19,'apple iphone 16','smartphone',10)
	Insert into Products (ProductID, ProductName,Category,Price)
	Values (15,	'tesla model y','electric vehicle',56655)
	Insert into Products (ProductID, ProductName,Category,Price)
	Values (20, 'sony playstation 5 pro','gaming console',45)
	Insert into Products (ProductID, ProductName,Category,Price)
	Values (12,'dyson airwrap','hair styling tool',55)
	Insert into Products (ProductID, ProductName,Category,Price)
	Values (17,'samsung galaxy watch ultra','smartwatch',15)
--Use SELECT INTO to create a backup table called Products_Backup containing all Products data.
	Select *  into Products_Backup from Products
--Rename the Products table to Inventory.
 EXEC sp_rename 'Products', 'Inventroy';
--Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT. and multiple-row insert).
	Alter table Products 
	alter column Price float
--Add an IDENTITY column named ProductCode that starts from 1000 and increments by 5 to Inventory table.
	ALTER TABLE Inventory
	ADD ProductCode INT IDENTITY(1000, 5);
