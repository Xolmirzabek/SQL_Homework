 Easy-Level Tasks (10)
--Define and explain the purpose of BULK INSERT in SQL Server.
The BULK INSERT statement in SQL Server is a Transact-SQL (T-SQL) command specifically designed for efficiently loading large volumes of data from a data file (such as a CSV or text file) into a database table or view.

Purpose and Explanation:
The primary purpose of BULK INSERT is to provide a fast and optimized way to import data into SQL Server, especially when dealing with millions of rows. It bypasses some of the overhead associated with row-by-row INSERT statements, making it significantly quicker for large data loads.
--List four file formats that can be imported into SQL Server.
CSV (Comma-Separated Values): This is one of the most widely used plain-text formats. Data fields are separated by commas, and rows are separated by newlines. It is simple, human-readable, and very versatile for data exchange.
TXT (Tab-Delimited or other character-delimited text files): Similar to CSV, but fields can be delimited by tabs, pipes, or any other specified character. This falls under the general category of "flat files."
XML (Extensible Markup Language): SQL Server has robust support for XML data. You can import XML documents directly, often using OPENROWSET(BULK...) with the SINGLE_BLOB or SINGLE_CLOB options, and then parse the XML into a table structure.
Native Format (SQL Server is own binary format): This is a binary format specific to SQL Server, primarily used for high-performance bulk data transfer between different SQL Server instances. It is generally the fastest method for moving large amounts of data without any data type conversions.
--Create a table Products with columns: ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2)).
Create table Products (ProductID int Primary Key, ProductName varchar(50),Price decimal(10,2)) 
Drop table Products
Select * from Products
--Insert three records into the Products table using INSERT INTO.
Insert into Products values (2,'phone',7),(3,'bike',5),(5,'computer',3)
--Explain the difference between NULL and NOT NULL.
In SQL, NULL and NOT NULL are constraints that define whether a column can contain a missing or undefined value:

NULL: This indicates that a column in a row has no value. It is  not the same as zero, an empty string, or a blank space; it explicitly means "no data." By default, if you don not specify any constraint, a column will allow NULL values. This is useful for optional fields where data might not always be available (e.g., a MiddleName column in a Customers table).

NOT NULL: This constraint enforces that a column must always contain a value. You cannot insert a new row or update an existing row with a NULL value in a column defined as NOT NULL. This is crucial for columns that are essential for the integrity of your data, such as identifiers (like a CustomerID or OrderID) or mandatory information (like a LastName). PRIMARY KEY columns are inherently NOT NULL.
--Add a UNIQUE constraint to the ProductName column in the Products table.
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName Unique(ProductName);
--Write a comment in a SQL query explaining its purpose.f
--Add CategoryID column to the Products table.
alter table Products
add CategoryID int
--Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE.
Create table Categories(CategoryID int Primary Key, CategoryName varchar(30) Unique)

 
--Explain the purpose of the IDENTITY column in SQL Server.
🟠 Medium-Level Tasks (10)
--Use BULK INSERT to import data from a text file into the Products table.
bulk insert Products 
from 'C:\Users\xolmi\Desktop\SQL lessons\Productstable.txt'
with(fieldterminator=',', rowterminator='\n', firstrow=2)

--Create a FOREIGN KEY in the Products table that references the Categories table.
alter table Products 
add constraint FK_Categories Foreign key(Product

ID) references Categories(CategoryID)  
ALTER TABLE Products
ADD CONSTRAINT FK_Categories FOREIGN KEY (CategoryID) REFERENCES Products(ProductID);
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID)


--Explain the differences between PRIMARY KEY and UNIQUE KEY.
PRIMARY KEY
A PRIMARY KEY is a column or a set of columns that uniquely identifies each record (row) in a database table. It is the most critical identifier for a table.

Key Characteristics of a PRIMARY KEY:

Uniqueness: Every value in the primary key column(s) must be unique. No two rows can have the same primary key value.
Non-NULL: A primary key column cannot contain NULL values. This ensures that every record has a definite, identifiable value.
One per Table: A table can have only one PRIMARY KEY.
Clustered Index (Default): By default, most database systems create a clustered index on the primary key, which physically sorts the data in the table based on the primary key is order. This can significantly improve query performance for operations involving the primary key.
Main Identifier: It serves as the principal identifier for records and is often used by other tables as a FOREIGN KEY to establish relationships between tables.
CREATE TABLE Students (
    StudentID INT PRIMARY KEY, -- StudentID is the primary key
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100)
);

-- Valid insertions
INSERT INTO Students (StudentID, FirstName, LastName, Email) VALUES (1, 'Alice', 'Smith', 'alice@example.com');
INSERT INTO Students (StudentID, FirstName, LastName, Email) VALUES (2, 'Bob', 'Johnson', 'bob@example.com');


UNIQUE KEY
A UNIQUE KEY (or UNIQUE constraint) is a column or a set of columns that enforces uniqueness for the values in that column or set of columns.

Key Characteristics of a UNIQUE KEY:

Uniqueness: Every value in the unique key column(s) must be unique.
NULL Values: Unlike a primary key, a unique key can contain NULL values. However, most database systems allow only one NULL value per unique key column (because NULL is considered an unknown value, and comparing NULL to another NULL does not result in equality in standard SQL).
Multiple per Table: A table can have multiple UNIQUE KEY constraints.
Non-Clustered Index (Default): By default, a unique key creates a non-clustered index, which maintains the uniqueness but does not physically sort the data in the table.
Alternate Identifier: It serves as an alternate identifier for records, useful for columns that must be unique but are not the primary means of identifying a row.

CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE, -- Username must be unique
    Email VARCHAR(100) UNIQUE,           -- Email must be unique
    RegistrationDate DATE
);

-- Valid insertions
INSERT INTO Users (UserID, Username, Email, RegistrationDate) VALUES (101, 'john_doe', 'john.doe@example.com', '2023-01-15');
INSERT INTO Users (UserID, Username, Email, RegistrationDate) VALUES (102, 'jane_smith', 'jane.smith@example.com', '2023-01-16');
INSERT INTO Users (UserID, Username, Email, RegistrationDate) VALUES (103, 'peter_parker', NULL, '2023-01-17'); -- NULL is allowed for Email

-- Invalid insertion (duplicate Username)
-- INSERT INTO Users (UserID, Username, Email, RegistrationDate) VALUES (104, 'john_doe', 'jd@example.com', '2023-01-18');

-- Invalid insertion (duplicate Email)
-- INSERT INTO Users (UserID, Username, Email, RegistrationDate) VALUES (105, 'new_user', 'john.doe@example.com', '2023-01-19');

-- Valid insertion (another NULL Email) - Most databases will allow only one NULL in a UNIQUE column
-- INSERT INTO Users (UserID, Username, Email, RegistrationDate) VALUES (106, 'another_user', NULL, '2023-01-20');

-- Invalid insertion (duplicate StudentID)
-- INSERT INTO Students (StudentID, FirstName, LastName, Email) VALUES (1, 'Charlie', 'Brown', 'charlie@example.com');

-- Invalid insertion (NULL StudentID)
-- INSERT INTO Students (StudentID, FirstName, LastName, Email) VALUES (NULL, 'David', 'Lee', 'david@example.com');
	
--Add a CHECK constraint to the Products table ensuring Price > 0.
	Alter table Products
	Add constraint CHK_Price check(Price>0);
	--OR
	Create table Products(id int, productname varchar(50), Price int check(Price>0	))

   --Modify the Products table to add a column Stock (INT, NOT NULL).
	alter table Products
	add Stock int not null
--Use the ISNULL function to replace NULL values in Price column with a 0.
Select isnull(Price,0)from Products
--Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.
🔴 Hard-Level Tasks (10)
--Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.
create table Customers (Age int check(Age>=18)) 
--Create a table with an IDENTITY column starting at 100 and incrementing by 10.
Create table StaffMembers(StaffID int identity(100,10))
--Write a query to create a composite PRIMARY KEY in a new table OrderDetails.
create table OrderDetails(id int, OrderName varchar(30), constraint PK_id_OrderName primary key (id,OrderName))
--Explain the use of COALESCE and ISNULL functions for handling NULL values.

1. COALESCE Function
COALESCE is a standard SQL function available in most relational database management systems (RDBMS) like MySQL, PostgreSQL, Oracle, SQL Server, and SQLite.

Purpose: It evaluates a list of expressions (or columns) from left to right and returns the first non-NULL value it encounters. If all expressions in the list are NULL, COALESCE will return NULL.
Syntax:
SQL

COALESCE(expression1, expression2, expression3, ...)
expression1, expression2, ...: A list of expressions, column names, or literal values to be evaluated.
Flexibility: One of its main advantages is its ability to handle multiple arguments. This makes it very versatile for defining fallback logic where you might have several potential values, and you want to pick the first one that is not NULL.
Data Type Precedence: COALESCE follows the CASE expression rules for data type determination, returning the data type of the value with the highest precedence among its arguments. This generally ensures more consistent data types in the result.
Standardization: Being an ANSI SQL standard function, COALESCE is highly portable across different database systems.
Example:
Suppose you have a Customers table with PhoneNumber, MobileNumber, and Email columns, and some might be NULL. You want to retrieve the best available contact information

SELECT
    CustomerID,
    COALESCE(MobileNumber, PhoneNumber, Email, 'No contact info available') AS PreferredContact
FROM
    Customers;
In this example, PreferredContact would show MobileNumber if it is not NULL, otherwise PhoneNumber if that's not NULL, otherwise Email if that's not NULL, and finally "No contact info available" if all three are NULL.

2. ISNULL Function
ISNULL is primarily a Microsoft SQL Server-specific function (though some other databases like MySQL have an IFNULL function that behaves similarly). It is not part of the ANSI SQL standard.

Purpose: It checks if a given expression is NULL. If it is, the function replaces the NULL value with a specified replacement value.
Syntax:
SQL

ISNULL(check_expression, replacement_value)
check_expression: The expression to check for NULL.
replacement_value: The value to return if check_expression is NULL.
Limitations: The main limitation of ISNULL is that it accepts only two arguments. If you need more complex fallback logic involving multiple expressions, you would have to nest ISNULL functions, which can become cumbersome and less readable.
Data Type Determination: ISNULL uses the data type of the check_expression (the first parameter) for its return value. This can sometimes lead to unexpected data type conversions if the replacement_value has a different data type with lower precedence.
Nullability: The return value of ISNULL is always considered NOT NULLable (assuming the replacement_value itself is non-nullable).
Example:
Suppose you want to display "N/A" for any NULL values in a Description column in a Products table.

SQL

SELECT
    ProductID,
    ISNULL(Description, 'N/A') AS ProductDescription
FROM
    Products;
--Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
create table Employee (EmpID int, Email varchar(30), constraint unique_EmpID_and_Email unique (EmpID,Email))
--Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DepartmentID INT, -- This column will be the FOREIGN KEY

    -- Define the FOREIGN KEY constraint with ON DELETE CASCADE and ON UPDATE CASCADE
    CONSTRAINT FK_Department
        FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
        ON DELETE CASCADE -- If a department is deleted, all employees in that department will also be deleted.
        ON UPDATE CASCADE  -- If a DepartmentID changes in Departments, it will automatically update in Employees.
);
