--1. **Using the `Employees` and `Departments` tables**, write a query to return the names and salaries of employees whose salary is greater than 50000, along with their department names.  
   🔁 *Expected Columns:* `EmployeeName`, `Salary`, `DepartmentName`
   
   Select Name as EmployeeName ,Salary,Departments.DepartmentName from Employees join Departments on Employees.DepartmentID=Departments.DepartmentID and Salary>50000
  -- 2. **Using the `Customers` and `Orders` tables**, write a query to display customer names and order dates for orders placed in the year 2023.  
   🔁 *Expected Columns:* `FirstName`, `LastName`, `OrderDate`
        
	 Select FirstName ,LastName,OrderDate from Customers join Orders on Customers.CustomerID=Orders.CustomerID and year(OrderDate)=2023

--3. **Using the `Employees` and `Departments` tables**, write a query to show all employees along with their department names. Include employees who do not belong to any department.  
   🔁 *Expected Columns:* `EmployeeName`, `DepartmentName`  
      Select Name as EmployeeName ,Departments.DepartmentName from Employees join Departments on Employees.DepartmentID=Departments.DepartmentID
	  
--4. **Using the `Products` and `Suppliers` tables**, write a query to list all suppliers and the products they supply. Show suppliers even if they don’t supply any product.  
   🔁 *Expected Columns:* `SupplierName`, `ProductName`
      
         Select ContactName as SupplierName ,ProductName from Products right join Suppliers on Products.SupplierID=Suppliers.SupplierID 
--5. **Using the `Orders` and `Payments` tables**, write a query to return all orders and their corresponding payments. Include orders without payments and payments not linked to any order.  
   🔁 *Expected Columns:* `OrderID`, `OrderDate`, `PaymentDate`, `Amount`
   
    Select  Orders.OrderID ,OrderDate,PaymentDate,Amount from Orders right join Payments on Orders.OrderID=Payments.OrderID 

--6. **Using the `Employees` table**, write a query to show each employee is name along with the name of their manager.  
   🔁 *Expected Columns:* `EmployeeName`, `ManagerName`
	
Select  b.Name as EmployeeName,	a.Name  ManagerName from Employees a left join Employees b  on a.EmployeeID=b.ManagerID
--7. **Using the `Students`, `Courses`, and `Enrollments` tables**, write a query to list the names of students who are enrolled in the course named 'Math 101'.  
   🔁 *Expected Columns:* `StudentName`, `CourseName`
 
 Select  Students.Name as StudentName,Courses.CourseName from Students join Enrollments on Students.StudentID=Enrollments.StudentID join Courses on Courses.CourseID=Enrollments.CourseID where CourseName ='Math 101' 

--8. **Using the `Customers` and `Orders` tables**, write a query to find customers who have placed an order with more than 3 items. Return their name and the quantity they ordered.  
   🔁 *Expected Columns:* `FirstName`, `LastName`, `Quantity`
   
   	 Select FirstName ,LastName,Quantity from Customers join Orders on Customers.CustomerID=Orders.CustomerID group by   FirstName ,LastName,Quantity
	HAVING SUM(Quantity)>3

--9. **Using the `Employees` and `Departments` tables**, write a query to list employees working in the 'Human Resources' department.  
   🔁 *Expected Columns:* `EmployeeName`, `DepartmentName`  
 Select Name as EmployeeName ,Departments.DepartmentName from Employees join Departments on Employees.DepartmentID=Departments.DepartmentID AND Departments.DepartmentID=2

---

## 🟠 **Medium-Level Tasks (9)**

--10. **Using the `Employees` and `Departments` tables**, write a query to return department names that have more than 5 employees.  
   🔁 *Expected Columns:* `DepartmentName`, `EmployeeCount`
 Select  DepartmentName ,Count(Employees.DepartmentID) as EmployeeCount from Employees right join Departments on Employees.DepartmentID=Departments.DepartmentID group by DepartmentName
 Having Count( Employees.DepartmentID)>5

--11. **Using the `Products` and `Sales` tables**, write a query to find products that have never been sold.  
   🔁 *Expected Columns:* `ProductID`, `ProductName`
   	 Select Products.ProductID ,ProductName from Products left  join Sales on Products.ProductID =Sales.ProductID where   Sales.ProductID is null

--12. **Using the `Customers` and `Orders` tables**, write a query to return customer names who have placed at least one order.  
   🔁 *Expected Columns:* `FirstName`, `LastName`, `TotalOrders`
   	 Select FirstName ,LastName, Quantity as TotalOrders from Customers join Orders on Customers.CustomerID=Orders.CustomerID group by   FirstName ,LastName,Quantity
	 HAVING SUM(Quantity)=1
--13. **Using the `Employees` and `Departments` tables**, write a query to show only those records where both employee and department exist (no NULLs).  
   🔁 *Expected Columns:* `EmployeeName`, `DepartmentName`  

 Select Name as EmployeeName, DepartmentName from Employees right join Departments on Employees.DepartmentID=Departments.DepartmentID group by Name,DepartmentName


14. **Using the `Employees` table**, write a query to find pairs of employees who report to the same manager.  
   🔁 *Expected Columns:* `Employee1`, `Employee2`, `ManagerID`
   SELECT 
    e1.Name AS Employee1,
    e2.Name AS Employee2,
    e1.ManagerID
FROM
    Employees AS e1
JOIN
    Employees AS e2 ON e1.ManagerID = e2.ManagerID
WHERE
    e1.EmployeeID < e2.EmployeeID 


--15. **Using the `Orders` and `Customers` tables**, write a query to list all orders placed in 2022 along with the customer name.  
   🔁 *Expected Columns:* `OrderID`, `OrderDate`, `FirstName`, `LastName`
            
	 Select OrderID,OrderDate,FirstName ,LastName from Customers join Orders on Customers.CustomerID=Orders.CustomerID and year(OrderDate)=2022

--16. **Using the `Employees` and `Departments` tables**, write a query to return employees from the 'Sales' department whose salary is above 60000.  
   🔁 *Expected Columns:* `EmployeeName`, `Salary`, `DepartmentName`
    
   Select Name as EmployeeName ,Salary,Departments.DepartmentName from Employees join Departments on Employees.DepartmentID=Departments.DepartmentID and Salary>60000 and Departments.DepartmentID=1 
-------------17. **Using the `Orders` and `Payments` tables**, write a query to return only those orders that have a corresponding payment.  
   🔁 *Expected Columns:* `OrderID`, `OrderDate`, `PaymentDate`, `Amount`
      
    Select  Orders.OrderID ,OrderDate,PaymentDate,Amount from Orders join Payments on Orders.OrderID=Payments.OrderID 


--18. **Using the `Products` and `Orders` tables**, write a query to find products that were never ordered.  
   🔁 *Expected Columns:* `ProductID`, `ProductName`
       	 Select Products.ProductID ,ProductName from Products left  join Orders on Products.ProductID =Orders.ProductID where   Orders.ProductID is null
---

## 🔴 **Hard-Level Tasks (9)**

--19. **Using the `Employees` table**, write a query to find employees whose salary is greater than the average salary in their own departments.  
   🔁 *Expected Columns:* `EmployeeName`, `Salary`
   
   Select Name as EmployeeName,Salary from Employees join(Select AVG(Salary) as average_salary_by_department, Employees.DepartmentID from Employees  group by  Employees.DepartmentID
) Departments on Employees.DepartmentID=Departments.DepartmentID where Salary>average_salary_by_department
--20. **Using the `Orders` and `Payments` tables**, write a query to list all orders placed before 2020 that have no corresponding payment.  
   🔁 *Expected Columns:* `OrderID`, `OrderDate`
      
   Select  Orders.OrderID ,OrderDate from Orders left join Payments on Orders.OrderID=Payments.OrderID where YEAR(OrderDate)<2020 and Payments.OrderID is null

--21. **Using the `Products` and `Categories` tables**, write a query to return products that do not have a matching category.  
   🔁 *Expected Columns:* `ProductID`, `ProductName`
       Select Products.ProductID ,ProductName from Products left  join Categories on Products.Category =Categories.CategoryID   where   Categories.CategoryID is null

--22. **Using the `Employees` table**, write a query to find employees who report to the same manager and earn more than 60000.  
   🔁 *Expected Columns:* `Employee1`, `Employee2`, `ManagerID`, `Salary`
SELECT
    e1.Name AS Employee1,
    e2.Name AS Employee2,
    e1.ManagerID,
    e1.Salary -- Both employees in the pair will have salary > 60000
FROM
    Employees AS e1
JOIN
    Employees AS e2 ON e1.ManagerID = e2.ManagerID
WHERE
    e1.EmployeeID < e2.EmployeeID -- To avoid duplicate pairs (e.g., A,B and B,A) and self-comparison
    AND e1.Salary > 60000
    AND e2.Salary > 60000;

--23. **Using the `Employees` and `Departments` tables**, write a query to return employees who work in departments which name starts with the letter 'M'. 
   🔁 *Expected Columns:* `EmployeeName`, `DepartmentName`
   
   Select Name as EmployeeName ,Departments.DepartmentName from Employees join Departments on Employees.DepartmentID=Departments.DepartmentID where DepartmentName like 'M%'
--24. **Using the `Products` and `Sales` tables**, write a query to list sales where the amount is greater than 500, including product names.  
   🔁 *Expected Columns:* `SaleID`, `ProductName`, `SaleAmount`
   
   	 Select SaleID ,ProductName,SaleAmount from Products left  join Sales on Products.ProductID =Sales.ProductID and SaleAmount>500

--25. **Using the `Students`, `Courses`, and `Enrollments` tables**, write a query to find students who have **not** enrolled in the course 'Math 101'.  
   🔁 *Expected Columns:* `StudentID`, `StudentName`
   
	Select  Students.Name as StudentName,Courses.CourseName from Students  full join Enrollments on Students.StudentID=Enrollments.StudentID full join Courses on Courses.CourseID=Enrollments.CourseID where CourseName !='Math 101' or CourseName is null

--26. **Using the `Orders` and `Payments` tables**, write a query to return orders that are missing payment details.  
   🔁 *Expected Columns:* `OrderID`, `OrderDate`, `PaymentID`
	Select  Orders.OrderID ,OrderDate,PaymentID from Orders left join Payments on Orders.OrderID=Payments.OrderID where PaymentID is null  


--27. **Using the `Products` and `Categories` tables**, write a query to list products that belong to either the 'Electronics' or 'Furniture' category.  
   🔁 *Expected Columns:* `ProductID`, `ProductName`, `CategoryName`
 Select Products.ProductID ,ProductName,CategoryName from Products left join Categories on Products.Category =Categories.CategoryID  where  CategoryName='Electronics' or CategoryName='Furniture'
