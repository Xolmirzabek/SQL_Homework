Of course\! Here are the solutions to the lesson tasks using MSSQL Server.

### ✅ Easy-Level Tasks

**1. Write a query that uses an alias to rename the `ProductName` column as `Name` in the `Products` table.**

```sql
SELECT
  ProductName AS Name
FROM Products;
```

**2. Write a query that uses an alias to rename the `Customers` table as `Client` for easier reference.**

```sql
SELECT
  Client.FirstName,
  Client.LastName,
  Client.Country
FROM Customers AS Client;
```

**3. Use `UNION` to combine results from two queries that select `ProductName` from `Products` and `ProductName` from `Products_Discounted`.**

```sql
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;
```

**4. Write a query to find the intersection of `Products` and `Products_Discounted` tables using `INTERSECT`.**

```sql
SELECT ProductName FROM Products
INTERSECT
SELECT ProductName FROM Products_Discounted;
```

**5. Write a query to select distinct customer names and their corresponding `Country` using `SELECT DISTINCT`.**

```sql
SELECT DISTINCT
  FirstName,
  LastName,
  Country
FROM Customers;
```

**6. Write a query that uses `CASE` to create a conditional column that displays 'High' if `Price` \> 1000, and 'Low' if `Price` \<= 1000 from the `Products` table.**

```sql
SELECT
  ProductName,
  Price,
  CASE
    WHEN Price > 1000
    THEN 'High'
    ELSE 'Low'
  END AS PriceCategory
FROM Products;
```

**7. Use `IIF` to create a column that shows 'Yes' if `StockQuantity` \> 100, and 'No' otherwise (from the `Products_Discounted` table).**

```sql
SELECT
  ProductName,
  StockQuantity,
  IIF(StockQuantity > 100, 'Yes', 'No') AS HighStock
FROM Products_Discounted;
```

-----

### ✅ Medium-Level Tasks

**8. Use `UNION` to combine results from two queries that select `ProductName` from `Products` and `ProductName` from `Products_Discounted` tables.**
*(Note: This is the same as Easy Task 3 and yields the same result.)*

```sql
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;
```

**9. Write a query that returns the difference between the `Products` and `Products_Discounted` tables using `EXCEPT`.**

```sql
SELECT ProductName FROM Products
EXCEPT
SELECT ProductName FROM Products_Discounted;
```

**10. Create a conditional column using `IIF` that shows 'Expensive' if the `Price` is greater than 1000, and 'Affordable' if less, from the `Products` table.**

```sql
SELECT
  ProductName,
  Price,
  IIF(Price > 1000, 'Expensive', 'Affordable') AS PriceTag
FROM Products;
```

**11. Write a query to find employees in the `Employees` table who have either `Age` \< 25 or `Salary` \> 60000.**

```sql
SELECT
  EmployeeID,
  FirstName,
  LastName,
  Age,
  Salary
FROM Employees
WHERE
  Age < 25 OR Salary > 60000;
```

**12. Update the salary of an employee based on their department, increase by 10% if they work in 'HR' or `EmployeeID` = 5.**

```sql
UPDATE Employees
SET
  Salary = Salary * 1.10
WHERE
  DepartmentName = 'HR' OR EmployeeID = 5;

-- You can run this SELECT statement to verify the changes
SELECT EmployeeID, FirstName, DepartmentName, Salary FROM Employees WHERE DepartmentName = 'HR' OR EmployeeID = 5;
```

-----

### ✅ Hard-Level Tasks

**13. Write a query that uses `CASE` to assign 'Top Tier' if `SaleAmount` \> 500, 'Mid Tier' if `SaleAmount` BETWEEN 200 AND 500, and 'Low Tier' otherwise. (From `Sales` table)**

```sql
SELECT
  SaleID,
  CustomerID,
  SaleAmount,
  CASE
    WHEN SaleAmount > 500
    THEN 'Top Tier'
    WHEN SaleAmount BETWEEN 200 AND 500
    THEN 'Mid Tier'
    ELSE 'Low Tier'
  END AS SaleTier
FROM Sales;
```

**14. Use `EXCEPT` to find customers' ID who have placed orders but do not have a corresponding record in the `Sales` table.**

```sql
-- Select CustomerIDs from Orders
SELECT CustomerID FROM Orders
EXCEPT
-- Subtract CustomerIDs that are present in Sales
SELECT CustomerID FROM Sales;
```

**15. Write a query that uses a `CASE` statement to determine the discount percentage based on the quantity purchased. The result set should show `customerid`, `quantity`, and discount percentage from the `Orders` table.**

  * 1 item: 3%
  * Between 2 and 3 items: 5%
  * Otherwise: 7%

<!-- end list -->

```sql
SELECT
  CustomerID,
  Quantity,
  CASE
    WHEN Quantity = 1
    THEN '3%'
    WHEN Quantity BETWEEN 2 AND 3
    THEN '5%'
    ELSE '7%'
  END AS DiscountPercentage
FROM Orders;
```
