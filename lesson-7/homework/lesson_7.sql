🟢-- Easy-Level Tasks (10)
--Write a query to find the minimum (MIN) price of a product in the Products table.
	select min(Price) from Products;
--Write a query to find the maximum (MAX) Salary from the Employees table.
	SELECT MAX(Salary) from Products;
--Write a query to count the number of rows in the Customers table.
	Select count(*) from Customers;
--Write a query to count the number of unique product categories from the Products table.
	select count(distinct Categories) from Products;
--Write a query to find the total sales amount for the product with id 7 in the Sales table.
	Select sum(Quantity*Price) from sales
	where SaleID=7;
--Write a query to calculate the average age of employees in the Employees table.
	Select avg(Age) from Employees;
--Write a query to count the number of employees in each department.
	SELECT YEAR(SaleDate) AS SalesYear, SUM(SaleAmount) AS TotalSales FROM Sales
	GROUP BY YEAR(SaleDate);
--Write a query to show the minimum and maximum Price of products grouped by Category. Use products table.
	Select  min(Price) as Expensive from Products group by Category;
	Select  max(Price) as Expensive, Category from Products group by Category;
--Write a query to calculate the total sales per Customer in the Sales table.
	Select sum(SaleAmount) as Total_sales_per_Customers, CustomerID from Sales group by CustomerID;
--Write a query to filter departments having more than 5 employees from the Employees table.(DeptID is enough, if you don't have DeptName).
	Select Count(EmployeeID) as more_5_emplyees, DepartmentName from Employees group by DepartmentName 
	having count(EmployeeID)>5;
🟠 --Medium-Level Tasks (9)
--Write a query to calculate the total sales and average sales for each product category from the Sales table.
	Select Sum(SaleAmount) as total_sale, ProductID from Sales group by ProductID;
	Select Avg(SaleAmount) as average_sale, ProductID from Sales group by ProductID;
--Write a query to count the number of employees from the Department HR.
	Select count(EmployeeID) as Employees_number_of_HRDepartment,DepartmentName from Employees group by DepartmentName
	Having DepartmentName = 'HR';
--Write a query that finds the highest and lowest Salary by department in the Employees table.(DeptID is enough, if you don't have DeptName).
	Select max(Salary) as the_highest_salary, DepartmentName from Employees group by DepartmentName;
	Select min(Salary) as the_lowest_salary, DepartmentName from Employees group by DepartmentName;
--Write a query to calculate the average salary per Department.(DeptID is enough, if you don't have DeptName).
	Select avg(Salary) as average_salary, DepartmentName from Employees group by DepartmentName;
--Write a query to show the AVG salary and COUNT(*) of employees working in each department.(DeptID is enough, if you don't have DeptName).
	Select avg(Salary)  as average_salary, count(EmployeeID) as number_of_emplyees_in_departments, DepartmentName from Employees group by DepartmentName;
--Write a query to filter product categories with an average price greater than 400.
	Select AVG(Price*StockQuantity) as average_price_by_category, Category from Products group by Category;
--Write a query that calculates the total sales for each year in the Sales table.
	SELECT YEAR(SaleDate) AS SalesYear, SUM(SaleAmount) AS TotalSales
	FROM Sales
	GROUP BY YEAR(SaleDate);
--Write a query to show the list of customers who placed at least 3 orders.
	Select count(SaleID) as customer_sales, CustomerID from Sales group by CustomerID
	Having count(CustomerID)>3;
--Write a query to filter out Departments with average salary expenses greater than 60000.(DeptID is enough, if you don't have DeptName).
	Select avg(Salary)  as average_salary, DepartmentName from Employees group by DepartmentName
	Having avg(Salary)>60000;
🔴 --Hard-Level Tasks (6)
--Write a query that shows the average price for each product category, and then filter categories with an average price greater than 150.
	Select AVG(Price) as average_price_by_category, Category from Products group by Category
	having AVG(Price)>150;
--Write a query to calculate the total sales for each Customer, then filter the results to include only Customers with total sales over 1500.
	Select sum(SaleAmount) as total_sales, CustomerID from Sales group by CustomerID
	Having sum(SaleAmount)>1500;
--Write a query to find the total and average salary of employees in each department, and filter the output to include only departments with an average salary greater than 65000.
select * from Employees
	Select AVG(Salary) as average_salary, DepartmentName from Employees group by DepartmentName
	having AVG(Salary) > 65000;
--Write a query to find total amount for the orders which weights more than $50 for each customer along with their least purchases.
	--(least amount might be lower than 50, use tsql2012.sales.orders table,freight col, ask your assistant to give the TSQL2012 database).
	Select sum(freight) as total_amount, custid from [Sales].[Orders]r group by custid
	having sum(freight)>50;
	--Write a query that calculates the total sales and counts unique products sold in each month of each year, and then filter the months with at least 2 products sold.(Orders)	
	SELECT month(OrderDate) AS month_of_sale, Sum(Quantity) AS max_order, count(DISTINCT ProductID) as unique_products FROM  Orders
	GROUP BY month(OrderDate)
	having Sum(Quantity)>;
--Write a query to find the MIN and MAX order quantity per Year. From orders table. 
	SELECT YEAR(orderdate) AS SalesYear, max(Quantity) AS max_order FROM  Orders
	GROUP BY YEAR(orderdate);

	SELECT YEAR(orderdate) AS SalesYear, min(Quantity) AS min_order FROM  Orders
	GROUP BY YEAR(orderdate);
