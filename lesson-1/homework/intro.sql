Easy
--Define the following terms: data, database, relational database, and table.
 Data-is information that we receive from the environent and other things that we can feel. There two tyoes of data. 1st one is structured which are put in to the cells and the other one is unstructured. Data analytics use the structured data.
database- information and data are gathered in database. Database contains all of the data anf information. 
relational database- connected or relatedd Databases and tables
table - is something that organaizes from columns and rows. It can save value.
List five key features of SQL Server
--1. High Availability and Disaster Recovery
--2.Business Intelligence and Analytics
--3. Robust Security
--4.Cloud Integration	
--5.Scalability and Performance
 What are the different authentication modes available when connecting to SQL Server? (Give at least 2)
1.Windows Authentication Mode
2.SQL Server Authentication Mode
3. Microsoft Entra MFA
4.Microsoft Entra Password
Medium 
Create a new database in SSMS named SchoolDB.

Write and execute a query to create a table called Students with columns: StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT).
create table Students(Student_ID int, name varchar(50), Age int)
Describe the differences between SQL Server, SSMS, and SQL.
--SQL Server- is set of data and databases. tables and other information. It is used to connect and work on amny dataabses and data in one time. 
--SSMS-SQL Server Managment Studio. it is beneficial when we work with interface of server and settings of them.
--SQL-Structured Query Language. Usually, there are many type of versions.
Hard
Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.
--DQL -Data query language
select - for demonstrate the data in the database or tables
--DDL- Data Definition language It used for changing object of SQL server
Drop - is used for removing the database and cells in it 
Alter - For changing the columns and rows in the database or the table.
Truncate— Mainly it used for tables, For deleting the information in the tables 
Create -For creating the data or object inn the database 
--DML - Data manipulation languaga 
insert- for adding or giving the new inofrmation or data to tables 
delete - For removing the data or information 
update- For changing the some tyoes of rows or columns

DCL-Data Control Language


Grant -this give permisssion to the enter and using the SQL Server
Revoke-For forbidding the access to SQL Server


TCL— Transaction Control LAnguage : it helps us to remove some types data which are the important for us f
begin Transaction -for used begining of the transaction 
Comit Transaction-For confirm the changing or removing 
rollback Transaction- used to return the previous data. But after commiting, we cannot return the information
--Write a query to insert three records into the Students table.
create table Students(Student_ID int, Name varchar(50), Age int)
Select * from Students 
INSERT INTO Students (Student_ID, Name, Age)
VALUES (1, 'Alice Johnson', 20);

INSERT INTO Students (Student_ID, Name, Age)
VALUES (2, 'Bob Smith', 22);

INSERT INTO Students (Student_ID, Name, Age)
VALUES (3, 'Charlie Davis', 19);


Restore AdventureWorksDW2022.bak file to your server. (write its steps to submit) You can find the database from this link :https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2022.bak
1.Click the right side of the mouse on Databeses
2. Click to the Restore Database
3.Tick the Devicea andd Click to '...'
4.Cilck to 'Add'button	
5.C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup find this folder from computer and new dowloaded file is moved to in this file
6.Choos the file which we want to backup or restore. Then click to the 'Ok' and again 'Ok'/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2022.bak
