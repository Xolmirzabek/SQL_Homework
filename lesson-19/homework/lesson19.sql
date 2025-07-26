 🔵 Part 1: Stored Procedure Tasks

---

### 📄 Task 1: Employee Bonus

CREATE PROCEDURE GetEmployeeBonuses
AS
BEGIN
    CREATE TABLE #EmployeeBonus (
        EmployeeID INT,
        FullName NVARCHAR(100),
        Department NVARCHAR(50),
        Salary DECIMAL(10,2),
        BonusAmount DECIMAL(10,2)
    );

    INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Department,
        e.Salary,
        e.Salary * b.BonusPercentage / 100 AS BonusAmount
    FROM Employees e
    JOIN DepartmentBonus b ON e.Department = b.Department;

    SELECT * FROM #EmployeeBonus;
END;

---

### 📄 Task 2: Salary Increase by Department

CREATE PROCEDURE IncreaseDepartmentSalary
    @Department NVARCHAR(50),
    @IncreasePercent DECIMAL(5,2)
AS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * @IncreasePercent / 100)
    WHERE Department = @Department;

    SELECT * FROM Employees
    WHERE Department = @Department;
END;

---

## 🔵 Part 2: MERGE Tasks

---

### 📄 Task 3: MERGE `Products_Current` with `Products_New`

MERGE Products_Current AS target
USING Products_New AS source
ON target.ProductID = source.ProductID

WHEN MATCHED THEN 
    UPDATE SET 
        target.ProductName = source.ProductName,
        target.Price = source.Price

WHEN NOT MATCHED BY TARGET THEN 
    INSERT (ProductID, ProductName, Price)
    VALUES (source.ProductID, source.ProductName, source.Price)

WHEN NOT MATCHED BY SOURCE THEN 
    DELETE;

-- View final state
SELECT * FROM Products_Current;

---

### 📄 Task 4: Tree Node Classification

SELECT 
    t1.id,
    CASE 
        WHEN t1.p_id IS NULL THEN 'Root'
        WHEN t1.id IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Inner'
        ELSE 'Leaf'
    END AS type
FROM Tree t1
ORDER BY t1.id;

---

### 📄 Task 5: Confirmation Rate

SELECT 
    s.user_id,
    CAST(
        ISNULL(SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END), 0) * 1.0 /
        NULLIF(COUNT(c.action), 0)
        AS DECIMAL(4,2)
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id
ORDER BY s.user_id;

---

### 📄 Task 6: Employees with Lowest Salary

SELECT *
FROM employees
WHERE salary = (
    SELECT MIN(salary) FROM employees
);

---

### 📄 Task 7: Get Product Sales Summary Stored Procedure

CREATE PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantitySold,
        SUM(s.Quantity * p.Price) AS TotalSalesAmount,
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductName;
END;

---

Let me know if you’d like to test any of these with sample executions or get them all bundled as .sql file.
