## Easy Tasks

### 1\. Create a numbers table from 1 to 1000

This query uses a recursive Common Table Expression (CTE) to generate a list of numbers from 1 to 1000.

WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM Numbers
    WHERE n < 1000
)
SELECT n
FROM Numbers
OPTION (MAXRECURSION 1000);

\<br\>

### 2\. Find the total sales per employee

This query uses a derived table to first calculate the total sales for each employee and then joins it with the Employees table to display their names.

SELECT
    e.FirstName,
    e.LastName,
    dt.TotalSales
FROM Employees e
JOIN (
    SELECT
        EmployeeID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) AS dt ON e.EmployeeID = dt.EmployeeID;

\<br\>

### 3\. Find the average salary of employees

This query uses a CTE to calculate the average salary of all employees.

WITH AverageSalary AS (
    SELECT AVG(Salary) AS AvgSal FROM Employees
)
SELECT AvgSal
FROM AverageSalary;

\<br\>

### 4\. Find the highest sales for each product

This query uses a derived table to find the maximum sale amount for each product and then joins back to the Products and Sales tables to show the product name.

SELECT
    p.ProductName,
    dt.MaxSale
FROM Products p
JOIN (
    SELECT
        ProductID,
        MAX(SalesAmount) AS MaxSale
    FROM Sales
    GROUP BY ProductID
) AS dt ON p.ProductID = dt.ProductID;

\<br\>

### 5\. Double the number sequence

This recursive CTE starts at 1 and doubles the number in each iteration, stopping when the value exceeds 1,000,000.

WITH DoubleNumber AS (
    SELECT 1 AS Value
    UNION ALL
    SELECT Value * 2
    FROM DoubleNumber
    WHERE Value * 2 < 1000000
)
SELECT Value
FROM DoubleNumber;

\<br\>

### 6\. Get employees with more than 5 sales

This CTE counts the number of sales for each employee and filters to show only those who have made more than 5 sales.

WITH EmployeeSales AS (
    SELECT
        EmployeeID,
        COUNT(SalesID) AS NumberOfSales
    FROM Sales
    GROUP BY EmployeeID
)
SELECT
    e.FirstName,
    e.LastName,
    es.NumberOfSales
FROM Employees e
JOIN EmployeeSales es ON e.EmployeeID = es.EmployeeID
WHERE es.NumberOfSales > 5;

\<br\>

### 7\. Find products with sales greater than $500

This query uses a CTE to calculate total sales for each product and lists the products with total sales exceeding $500.

WITH ProductSales AS (
    SELECT
        ProductID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
)
SELECT
    p.ProductName,
    ps.TotalSales
FROM Products p
JOIN ProductSales ps ON p.ProductID = ps.ProductID
WHERE ps.TotalSales > 500;

\<br\>

### 8\. Find employees with salaries above average

This CTE first calculates the company's average salary, then retrieves all employees who earn more than that average.

WITH AverageSalary AS (
    SELECT AVG(Salary) AS AvgSal
    FROM Employees
)
SELECT
    e.FirstName,
    e.LastName,
    e.Salary
FROM Employees e, AverageSalary av
WHERE e.Salary > av.AvgSal;

-----

## Medium Tasks

### 1\. Find the top 5 employees by number of orders

This query uses a derived table to count the number of sales per employee, orders them in descending order, and retrieves the top 5.

SELECT TOP 5
    e.FirstName,
    e.LastName,
    dt.OrderCount
FROM Employees e
JOIN (
    SELECT
        EmployeeID,
        COUNT(SalesID) AS OrderCount
    FROM Sales
    GROUP BY EmployeeID
) AS dt ON e.EmployeeID = dt.EmployeeID
ORDER BY dt.OrderCount DESC;

\<br\>

### 2\. Find the sales per product category

This query joins Sales and Products in a derived table to calculate the total sales amount for each product category.

SELECT
    dt.CategoryID,
    SUM(dt.SalesAmount) AS TotalCategorySales
FROM (
    SELECT
        p.CategoryID,
        s.SalesAmount
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
) AS dt
GROUP BY dt.CategoryID;

\<br\>

### 3\. Calculate the factorial of each value

Xolmirzabek Ashiraliyev, [7/25/2025 8:00 AM]
This recursive CTE calculates the factorial for each number in the Numbers1 table.

WITH FactorialCTE AS (
    SELECT
        Number,
        1 AS i,
        CAST(1 AS BIGINT) AS fact
    FROM Numbers1
    UNION ALL
    SELECT
        Number,
        i + 1,
        CAST(fact * (i + 1) AS BIGINT)
    FROM FactorialCTE
    WHERE i < Number
)
SELECT
    Number,
    MAX(fact) AS Factorial
FROM FactorialCTE
GROUP BY Number;

\<br\>

### 4\. Split a string into rows

This script uses a recursive CTE to split each string in the Example table into individual characters, each on a new row.

WITH SplitString AS (
    SELECT
        Id,
        String,
        1 AS StartPos,
        SUBSTRING(String, 1, 1) AS CharValue
    FROM Example
    UNION ALL
    SELECT
        Id,
        String,
        StartPos + 1,
        SUBSTRING(String, StartPos + 1, 1)
    FROM SplitString
    WHERE StartPos < LEN(String)
)
SELECT Id, CharValue
FROM SplitString
ORDER BY Id, StartPos;

\<br\>

### 5\. Calculate the monthly sales difference

This CTE calculates the total sales for each month and then uses the LAG window function to find the difference from the previous month's sales.

WITH MonthlySales AS (
    SELECT
        EOMONTH(SaleDate) AS MonthEnd,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EOMONTH(SaleDate)
),
SalesDiff AS (
    SELECT
        MonthEnd,
        TotalSales,
        LAG(TotalSales, 1, 0) OVER (ORDER BY MonthEnd) AS PreviousMonthSales
    FROM MonthlySales
)
SELECT
    MonthEnd,
    TotalSales,
    PreviousMonthSales,
    TotalSales - PreviousMonthSales AS SalesDifference
FROM SalesDiff;

\<br\>

### 6\. Find employees with sales over $45000 in a quarter

This query uses a derived table to aggregate sales by employee and quarter, then filters to show only those who exceeded $45,000 in sales in any quarter.

SELECT
    e.FirstName,
    e.LastName,
    dt.SaleQuarter,
    dt.QuarterlySales
FROM Employees e
JOIN (
    SELECT
        EmployeeID,
        DATEPART(QUARTER, SaleDate) AS SaleQuarter,
        SUM(SalesAmount) AS QuarterlySales
    FROM Sales
    GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
) AS dt ON e.EmployeeID = dt.EmployeeID
WHERE dt.QuarterlySales > 45000;

-----

## Difficult Tasks

### 1\. Calculate Fibonacci numbers

This recursive CTE generates the first 15 numbers in the Fibonacci sequence.

WITH Fibonacci (n, fib_n, next_fib_n) AS (
    SELECT 1, 0, 1
    UNION ALL
    SELECT n + 1, next_fib_n, fib_n + next_fib_n
    FROM Fibonacci
    WHERE n < 15
)
SELECT fib_n
FROM Fibonacci;

\<br\>

### 2\. Find strings where all characters are the same

This query finds strings where all characters are identical and the string length is greater than one by replacing all occurrences of the first character and checking if the result is an empty string.

SELECT Id, Vals
FROM FindSameCharacters
WHERE LEN(REPLACE(Vals, LEFT(Vals, 1), '')) = 0 AND LEN(Vals) > 1;

\<br\>

### 3\. Create a cumulative number string

This recursive CTE builds a string by progressively concatenating the next number in the sequence up to n=5.

WITH NumberSeries (n, str) AS (
    SELECT 1, CAST('1' AS VARCHAR(100))
    UNION ALL
    SELECT n + 1, CAST(str + CAST(n + 1 AS VARCHAR(10)) AS VARCHAR(100))
    FROM NumberSeries
    WHERE n < 5
)
SELECT str
FROM NumberSeries;

\<br\>

### 4\. Find top employees by sales in the last 6 months

This query uses a derived table to filter sales from the last 6 months, aggregates the sales data, and identifies the employee(s) with the highest total sales in that period.

SELECT TOP 1 WITH TIES
    e.FirstName,
    e.LastName,
    dt.TotalSales
FROM Employees e
JOIN (
    SELECT
        EmployeeID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY EmployeeID
) AS dt ON e.EmployeeID = dt.EmployeeID
ORDER BY dt.TotalSales DESC;

\<br\>

### 5\. Remove duplicate and single integers from a string

Xolmirzabek Ashiraliyev, [7/25/2025 8:00 AM]
This query uses a series of CTEs to extract digits, find unique ones, and then reconstruct the string, excluding any single-digit integers and duplicate integers.

WITH ExtractedDigits AS (
    SELECT
        PawanName,
        Pawan_slug_name,
        (SELECT STRING_AGG(C, '') FROM (SELECT DISTINCT SUBSTRING(Pawan_slug_name, Number, 1) AS C FROM master.dbo.spt_values WHERE Type = 'P' AND Number BETWEEN 1 AND LEN(Pawan_slug_name) AND ISNUMERIC(SUBSTRING(Pawan_slug_name, Number, 1)) = 1) AS UniqueDigits) AS Digits
    FROM RemoveDuplicateIntsFromNames
),
FilteredDigits AS (
    SELECT
        PawanName,
        Pawan_slug_name,
        CASE WHEN LEN(Digits) > 1 THEN Digits ELSE '' END AS FinalDigits
    FROM ExtractedDigits
)
SELECT
    fd.PawanName,
    REPLACE(TRANSLATE(fd.Pawan_slug_name, '0123456789', '##########'), '#', '') + '-' + fd.FinalDigits AS CleanedName
FROM FilteredDigits;
