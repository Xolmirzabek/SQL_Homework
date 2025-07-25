### ✅ 1. Temporary Table `MonthlySales`

-- Current month range (e.g., July 2025)
DECLARE @StartOfMonth DATE = DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1);
DECLARE @EndOfMonth DATE = EOMONTH(@StartOfMonth);

-- Create temp table
CREATE TABLE #MonthlySales (
    ProductID INT,
    TotalQuantity INT,
    TotalRevenue DECIMAL(18,2)
);

-- Insert data
INSERT INTO #MonthlySales (ProductID, TotalQuantity, TotalRevenue)
SELECT 
    s.ProductID,
    SUM(s.Quantity),
    SUM(s.Quantity * p.Price)
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE s.SaleDate BETWEEN @StartOfMonth AND @EndOfMonth
GROUP BY s.ProductID;

-- Return result
SELECT * FROM #MonthlySales;

---

### ✅ 2. View: `vw_ProductSalesSummary`

CREATE VIEW vw_ProductSalesSummary AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    ISNULL(SUM(s.Quantity), 0) AS TotalQuantitySold
FROM Products p
LEFT JOIN Sales s ON s.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category;

---

### ✅ 3. Function: `fn_GetTotalRevenueForProduct`

CREATE FUNCTION fn_GetTotalRevenueForProduct(@ProductID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(18,2);

    SELECT @TotalRevenue = SUM(s.Quantity * p.Price)
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    WHERE s.ProductID = @ProductID;

    RETURN ISNULL(@TotalRevenue, 0);
END

---

### ✅ 4. Function: `fn_GetSalesByCategory`

CREATE FUNCTION fn_GetSalesByCategory(@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantity,
        SUM(s.Quantity * p.Price) AS TotalRevenue
    FROM Products p
    JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.Category = @Category
    GROUP BY p.ProductName
);

---

### ✅ 5. Function: `fn_IsPrime`

CREATE FUNCTION dbo.fn_IsPrime(@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    IF @Number < 2 RETURN 'No';
    DECLARE @i INT = 2;

    WHILE @i <= SQRT(@Number)
    BEGIN
        IF @Number % @i = 0 RETURN 'No';
        SET @i += 1;
    END

    RETURN 'Yes';
END

---

### ✅ 6. Table-Valued Function: `fn_GetNumbersBetween`

CREATE FUNCTION fn_GetNumbersBetween(@Start INT, @End INT)
RETURNS @Result TABLE (Number INT)
AS
BEGIN
    DECLARE @i INT = @Start;

    WHILE @i <= @End
    BEGIN
        INSERT INTO @Result VALUES (@i);
        SET @i += 1;
    END

    RETURN;
END

---

### ✅ 7. Get Nth Highest Salary

CREATE FUNCTION getNthHighestSalary(@N INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        (SELECT DISTINCT salary
         FROM Employee
         ORDER BY salary DESC
         OFFSET @N - 1 ROWS
         FETCH NEXT 1 ROWS ONLY) AS HighestNSalary
);

---

### ✅ 8. Most Friends Query

SELECT TOP 1 id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id FROM RequestAccepted
) all_friends
GROUP BY id
ORDER BY COUNT(*) DESC;

---

### ✅ 9. View: `vw_CustomerOrderSummary`

CREATE VIEW vw_CustomerOrderSummary AS
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

---

### ✅ 10. Fill Gaps (Workflow)

WITH Filled AS (
  SELECT *,
         MAX(TestCase) OVER (ORDER BY RowNumber
                             ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Workflow
  FROM Gaps
)
SELECT RowNumber, Workflow
FROM Filled;

---

Let me know if you'd like to test or tweak any of these in your environment!
