🟢 Easy (10 puzzles)

Using Products, Suppliers table List all combinations of product names and supplier names.
  Select p.ProductName,  s.SupplierName from Products as p cross join Suppliers as s;
Using Departments, Employees table Get all combinations of departments and employees.
  SELECT
  d.DepartmentName,
  e.Name AS EmployeeName
FROM Departments AS d
CROSS JOIN Employees AS e;
Using Products, Suppliers table List only the combinations where the supplier actually supplies the product. Return supplier name and product name
  SELECT
  s.SupplierName,
  p.ProductName
FROM Products AS p
INNER JOIN Suppliers AS s
  ON p.SupplierID = s.SupplierID;
Using Orders, Customers table List customer names and their orders ID.
  SELECT
  c.FirstName,
  c.LastName,
  o.OrderID
FROM Orders AS o
INNER JOIN Customers AS c
  ON o.CustomerID = c.CustomerID;
Using Courses, Students table Get all combinations of students and courses.
  SELECT
  s.Name AS StudentName,
  c.CourseName
FROM Students AS s
CROSS JOIN Courses AS c;
Using Products, Orders table Get product names and orders where product IDs match.
  SELECT
  p.ProductName,
  o.OrderID
FROM Orders AS o
INNER JOIN Products AS p
  ON o.ProductID = p.ProductID;
Using Departments, Employees table List employees whose DepartmentID matches the department.
  SELECT
  e.Name AS EmployeeName,
  d.DepartmentName
FROM Employees AS e
INNER JOIN Departments AS d
  ON e.DepartmentID = d.DepartmentID;
Using Students, Enrollments table List student names and their enrolled course IDs.
SELECT
  s.Name AS StudentName,
  e.CourseID
FROM Enrollments AS e
INNER JOIN Students AS s
  ON e.StudentID = s.StudentID;
Using Payments, Orders table List all orders that have matching payments.
  SELECT
  o.OrderID,
  p.PaymentID
FROM Orders AS o
INNER JOIN Payments AS p
  ON o.OrderID = p.OrderID;
Using Orders, Products table Show orders where product price is more than 100.
  SELECT
  o.OrderID,
  p.ProductName,
  p.Price
FROM Orders AS o
INNER JOIN Products AS p
  ON o.ProductID = p.ProductID
WHERE
  p.Price > 100;
🟡 Medium (10 puzzles)
Using Employees, Departments table List employee names and department names where department IDs are not equal. It means: Show all mismatched employee-department combinations.
  SELECT
  e.Name AS EmployeeName,
  d.DepartmentName
FROM Employees AS e
CROSS JOIN Departments AS d
WHERE
  e.DepartmentID <> d.DepartmentID;
Using Orders, Products table Show orders where ordered quantity is greater than stock quantity.
  SELECT
  o.OrderID,
  p.ProductName,
  o.Quantity AS OrderedQuantity,
  p.StockQuantity
FROM Orders AS o
INNER JOIN Products AS p
  ON o.ProductID = p.ProductID
WHERE
  o.Quantity > p.StockQuantity;
Using Customers, Sales table List customer names and product IDs where sale amount is 500 or more.
  SELECT
  c.FirstName,
  c.LastName,
  s.ProductID,
  s.SaleAmount
FROM Sales AS s
INNER JOIN Customers AS c
  ON s.CustomerID = c.CustomerID
WHERE
  s.SaleAmount >= 500;
Using Courses, Enrollments, Students table List student names and course names they’re enrolled in.
  SELECT
  s.Name AS StudentName,
  c.CourseName
FROM Students AS s
INNER JOIN Enrollments AS e
  ON s.StudentID = e.StudentID
INNER JOIN Courses AS c
  ON e.CourseID = c.CourseID;
Using Products, Suppliers table List product and supplier names where supplier name contains “Tech”.
  SELECT
  p.ProductName,
  s.SupplierName
FROM Products AS p
INNER JOIN Suppliers AS s
  ON p.SupplierID = s.SupplierID
WHERE
  s.SupplierName LIKE '%Tech%';
Using Orders, Payments table Show orders where payment amount is less than total amount.
  SELECT
  o.OrderID,
  o.TotalAmount AS OrderTotalAmount,
  p.Amount AS PaymentAmount
FROM Orders AS o
INNER JOIN Payments AS p
  ON o.OrderID = p.OrderID
WHERE
  p.Amount < o.TotalAmount;
Using Employees and Departments tables, get the Department Name for each employee.
  SELECT
  e.Name AS EmployeeName,
  d.DepartmentName
FROM Employees AS e
INNER JOIN Departments AS d
  ON e.DepartmentID = d.DepartmentID;
Using Products, Categories table Show products where category is either 'Electronics' or 'Furniture'.
  SELECT
  p.ProductName,
  c.CategoryName
FROM Products AS p
INNER JOIN Categories AS c
  ON P.Category = C.CategoryID
WHERE
  c.CategoryName IN ('Electronics', 'Furniture');
Using Sales, Customers table Show all sales from customers who are from 'USA'.
  SELECT
  s.SaleID,
  c.FirstName,
  c.LastName,
  c.Country,
  s.SaleAmount
FROM Sales AS s
INNER JOIN Customers AS c
  ON s.CustomerID = c.CustomerID
WHERE
  c.Country = 'USA';
Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100.
  SELECT
  o.OrderID,
  c.FirstName,
  c.LastName,
  c.Country,
  o.TotalAmount
FROM Orders AS o
INNER JOIN Customers AS c
  ON o.CustomerID = c.CustomerID
WHERE
  c.Country = 'Germany' AND o.TotalAmount > 100;
🔴 Hard (5 puzzles)(Do some research for the tasks below)
Using Employees table List all pairs of employees from different departments.
  SELECT
  e1.Name AS Employee1,
  e2.Name AS Employee2,
  d1.DepartmentName AS Department1,
  d2.DepartmentName AS Department2
FROM Employees AS e1
INNER JOIN Employees AS e2
  ON e1.EmployeeID <> e2.EmployeeID -- Ensures different employees
INNER JOIN Departments AS d1
  ON e1.DepartmentID = d1.DepartmentID
INNER JOIN Departments AS d2
  ON e2.DepartmentID = d2.DepartmentID
WHERE
  e1.DepartmentID <> e2.DepartmentID
ORDER BY
  Employee1,
  Employee2;
Using Payments, Orders, Products table List payment details where the paid amount is not equal to (Quantity × Product Price).
  SELECT
  p.PaymentID,
  p.Amount AS PaidAmount,
  o.Quantity,
  prod.Price AS ProductPrice,
  (o.Quantity * prod.Price) AS CalculatedAmount
FROM Payments AS p
INNER JOIN Orders AS o
  ON p.OrderID = o.OrderID
INNER JOIN Products AS prod
  ON o.ProductID = prod.ProductID
WHERE
  p.Amount <> (o.Quantity * prod.Price);
Using Students, Enrollments, Courses table Find students who are not enrolled in any course.
  SELECT
  s.Name AS StudentName
FROM Students AS s
LEFT JOIN Enrollments AS e
  ON s.StudentID = e.StudentID
WHERE
  e.EnrollmentID IS NULL;
Using Employees table List employees who are managers of someone, but their salary is less than or equal to the person they manage.
  SELECT
  Manager.Name AS ManagerName,
  Manager.Salary AS ManagerSalary,
  Employee.Name AS ManagedEmployeeName,
  Employee.Salary AS ManagedEmployeeSalary
FROM Employees AS Manager
INNER JOIN Employees AS Employee
  ON Manager.EmployeeID = Employee.ManagerID
WHERE
  Manager.Salary <= Employee.Salary;
Using Orders, Payments, Customers table List customers who have made an order, but no payment has been recorded for it.
  SELECT
  c.FirstName,
  c.LastName,
  o.OrderID,
  o.TotalAmount
FROM Customers AS c
INNER JOIN Orders AS o
  ON c.CustomerID = o.CustomerID
LEFT JOIN Payments AS p
  ON o.OrderID = p.OrderID
WHERE
  p.PaymentID IS NULL;
