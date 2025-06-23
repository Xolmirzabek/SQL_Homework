
## 🟢 Easy-Level Tasks (7)

--1. **Return**: `OrderID`, `CustomerName`, `OrderDate`  
   **Task**: Show all orders placed after 2022 along with the names of the customers who placed them.  
   **Tables Used**: `Orders`, `Customers`
Select o.OrderID, c.FirstName as CustomerName, OrderDate from Orders o join Customers c  on o.CustomerID=c.CustomerID where YEAR(OrderDate)>2022
--2. **Return**: `EmployeeName`, `DepartmentName`  
   **Task**: Display the names of employees who work in either the Sales or Marketing department.  
   **Tables Used**: `Employees`, `Departments`
Select Name as EmployeeName, d.DepartmentName from Employees e join Departments d on e.DepartmentID=d.DepartmentID where d.DepartmentNAme in ('Sales', 'Marketing')
--3. **Return**: `DepartmentName`,  `MaxSalary`  
   **Task**: Show the highest salary for each department.  
   **Tables Used**: `Departments`, `Employees`
Select d.DepartmentName, MAX(Salary) as MaxSalary from Employees e join Departments d on e.DepartmentID=d.DepartmentID group by DepartmentName
--4. **Return**: `CustomerName`, `OrderID`, `OrderDate`  
   **Task**: List all customers from the USA who placed orders in the year 2023.  
   **Tables Used**: `Customers`, `Orders`
Select c.FirstName as CustomerName, o.OrderID, o.Orderdate from Customers c join Orders o on c.CustomerID=o.CustomerID where Country='USA' and YEAR(OrderDate)=2023
--5. **Return**: `CustomerName`, `TotalOrders`  
   **Task**: Show how many orders each customer has placed.  
   **Tables Used**: `Orders` , `Customers`
Select FirstName as CustomerName, SUM(Quantity) as TotalOrders from Customers join Orders on Customers.CustomerID=Orders.CustomerID group by FirstName 
--6. **Return**: `ProductName`, `SupplierName`  
   **Task**: Display the names of products that are supplied by either Gadget Supplies or Clothing Mart.  
   **Tables Used**: `Products`, `Suppliers`
Select ProductName, SupplierName from Suppliers join Products on Products.ProductID=Suppliers.SupplierID 
--7. **Return**: `CustomerName`, `MostRecentOrderDate`  
   **Task**: For each customer, show their most recent order. Include customers who have not  placed any orders.  
Select FirstName as CustomerName, OrderID as MostRecentOrders from Customers left join Orders on Customers.CustomerID=Orders.CustomerID

## 🟠 Medium-Level Tasks (6)

--8. **Return**: `CustomerName`,  `OrderTotal`  
   **Task**: Show the customers who have placed an order where the total amount is greater than 500.  
   **Tables Used**: `Orders`, `Customers`
Select FirstName as CustomerName, SUM(TotalAmount) as OrderTotal from Customers join Orders on Customers.CustomerID = Orders.CustomerID group by FirstName
Having SUM(TotalAmount)>500
--9. **Return**: `ProductName`, `SaleDate`, `SaleAmount`  
   **Task**: List product sales where the sale was made in 2022 or the sale amount exceeded 400.  
   **Tables Used**: `Products`, `Sales`
Select ProductName, SaleDate,SaleAmount from Products join Sales on Products.ProductID=Sales.ProductID where YEAR(SaleDate)=2022 and SaleAmount>400
--10. **Return**: `ProductName`, `TotalSalesAmount`  
    **Task**: Display each product along with the total amount it has been sold for.  
    **Tables Used**: `Sales`, `Products`
Select ProductName, SUM(SaleAmount) as TotalSalesAmount from Products join Sales on Products.ProductID=Sales.ProductID group by ProductName
--11. **Return**: `EmployeeName`, `DepartmentName`, `Salary`  
    **Task**: Show the employees who work in the HR department and earn a salary greater than 60000.  
    **Tables Used**: `Employees`, `Departments`
Select Name as EmplyeeName, DepartmentName, Salary from Employees join Departments on Employees.DepartmentID=Departments.DepartmentID where DepartmentName='HR' and Salary>60000
--12. **Return**: `ProductName`, `SaleDate`, `StockQuantity`  
    **Task**: List the products that were sold in 2023 and had more than 100 units in stock at the time.  
    **Tables Used**: `Products`, `Sales`
Select ProductName, SaleDate,StockQuantity from Products join Sales on Products.ProductID=Sales.ProductID where YEAR(SaleDate)=2023

--13. **Return**: `EmployeeName`, `DepartmentName`, `HireDate`  
    **Task**: Show employees who either work in the Sales department or were hired after 2020.  
    **Tables Used**: `Employees`, `Departments`
Select Name as EmplyeeName, DepartmentName from Employees join Departments on Employees.EmployeeID=Departments.DepartmentID where YEAR(HireDate)>2020
---

## 🔴 Hard-Level Tasks (7)

--14. **Return**: `CustomerName`, `OrderID`, `Address`, `OrderDate`  
    **Task**: List all orders made by customers in the USA whose address starts with 4 digits.  
    **Tables Used**: `Customers`, `Orders`
Select FirstName as CustomerName, OrderID, Address, OrderDate from Customers join Orders on Customers.CustomerID=Orders.CustomerID where Country='USA' and Address like'____ %'
--15. **Return**: `ProductName`, `Category`, `SaleAmount`  
    **Task**: Display product sales for items in the Electronics category or where the sale amount exceeded 350.  
    **Tables Used**: `Products`, `Sales`
Select ProductName, Category, SaleAmount from Products join Sales on Products.ProductID=Sales.ProductID where Category=1 and SaleAmount>350
--16. **Return**: `CategoryName`, `ProductCount`  
    **Task**: Show the number of products available in each category.  
    **Tables Used**: `Products`, `Categories`
Select CategoryName,SUM(StockQuantity) as ProductCount from Products join Categories on Products.Category=Categories.CategoryID group by CategoryName
--17. **Return**: `CustomerName`, `City`, `OrderID`, `Amount`  
    **Task**: List orders where the customer is from Los Angeles and the order amount is greater than 300.  
    **Tables Used**: `Customers`, `Orders`
Select FirstName as CustomerName, City, OrderID, TotalAmount as Amount from Customers join Orders on Customers.CustomerID=Orders.CustomerID where City='Los Angeles' and TotalAmount>300 
--18. **Return**: `EmployeeName`, `DepartmentName`  
    **Task**: Display employees who are in the HR or Finance department, or whose name contains at least 4 vowels.  
    **Tables Used**: `Employees`, `Departments`
Select e.Name as EmplyeeName, d.DepartmentName from Employees e join Departments d on e.DepartmentID=d.DepartmentID where d.DepartmentName in('HR', 'Finance') and
     (
        Len (e.Name) - len(
            REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(e.Name), 'a', ''), 'e', ''), 'i', ''), 'o', ''), 'u', '')
        )
    ) >= 4;

--19. **Return**: `EmployeeName`, `DepartmentName`, `Salary`  
    **Task**: Show employees who are in the Sales or Marketing department and have a salary above 60000.  
    **Tables Used**: `Employees`, `Departments`
 Select Name as EmplyeeName, DepartmentName, Salary from Employees join Departments on Employees.DepartmentID=Departments.DepartmentID where DepartmentName in('Sales', 'Marketing') and Salary>60000
