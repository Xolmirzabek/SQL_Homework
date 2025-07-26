---

### ✅ 1. Customers who purchased at least one item in March 2024 using `EXISTS`:

SELECT DISTINCT s.CustomerName
FROM #Sales s
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s.CustomerName = s2.CustomerName
      AND MONTH(s2.SaleDate) = 3
      AND YEAR(s2.SaleDate) = 2024
);

---

### ✅ 2. Product with the highest total sales revenue using subquery:

SELECT TOP 1 Product
FROM #Sales
GROUP BY Product
ORDER BY SUM(Quantity * Price) DESC;

---

### ✅ 3. Second highest sale amount using subquery:

SELECT MAX(TotalAmount) AS SecondHighest
FROM (
    SELECT Quantity * Price AS TotalAmount
    FROM #Sales
) AS amounts
WHERE TotalAmount < (
    SELECT MAX(Quantity * Price) FROM #Sales
);

---

### ✅ 4. Total quantity of products sold per month using subquery:

SELECT
    FORMAT(SaleDate, 'yyyy-MM') AS SaleMonth,
    (SELECT SUM(s2.Quantity)
     FROM #Sales s2
     WHERE FORMAT(s2.SaleDate, 'yyyy-MM') = FORMAT(s1.SaleDate, 'yyyy-MM')) AS TotalQuantity
FROM #Sales s1
GROUP BY FORMAT(SaleDate, 'yyyy-MM');

---

### ✅ 5. Customers who bought same products as another customer using `EXISTS`:

SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s1.Product = s2.Product
      AND s1.CustomerName <> s2.CustomerName
);

---

### ✅ 6. Count fruits for each person in individual fruit level:

SELECT
    Name,
    SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
    SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
    SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name;

---

### ✅ 7. Older people in the family with younger ones:

WITH FamilyTree AS (
    SELECT ParentId AS PID, ChildID AS CHID
    FROM Family
    UNION ALL
    SELECT f.ParentId, ft.CHID
    FROM Family f
    JOIN FamilyTree ft ON f.ChildID = ft.PID
)
SELECT * FROM FamilyTree
ORDER BY PID, CHID;

---

### ✅ 8. Customers with orders in Texas, if they had any order in California:

SELECT *
FROM #Orders o
WHERE DeliveryState = 'TX'
  AND EXISTS (
      SELECT 1
      FROM #Orders o2
      WHERE o.CustomerID = o2.CustomerID
        AND o2.DeliveryState = 'CA'
);

---

### ✅ 9. Insert missing names into `fullname` field:

UPDATE #residents
SET fullname = 
    SUBSTRING(address, CHARINDEX('name=', address) + 5,
              CHARINDEX(' ', address + ' ', CHARINDEX('name=', address) + 5) - CHARINDEX('name=', address) - 5)
WHERE fullname IS NULL OR fullname = ''

---

### ✅ 10. Route from Tashkent to Khorezm (Cheapest and Most Expensive):

WITH Paths AS (
    SELECT 'Tashkent' AS StartCity, 'Samarkand' AS NextCity, 'Tashkent - Samarkand' AS Route, Cost
    FROM #Routes WHERE DepartureCity = 'Tashkent' AND ArrivalCity = 'Samarkand'
    UNION ALL
    SELECT 'Tashkent', r.ArrivalCity, p.Route + ' - ' + r.ArrivalCity, p.Cost + r.Cost
    FROM Paths p
    JOIN #Routes r ON p.NextCity = r.DepartureCity
    WHERE r.ArrivalCity != p.StartCity
)
SELECT Route, Cost
FROM Paths
WHERE NextCity = 'Khorezm';

---

### ✅ 11. Rank products based on insertion order:

WITH Grouped AS (
    SELECT *, 
           SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END) OVER (ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS GroupNum
    FROM #RankingPuzzle
)
SELECT ID, Vals, 
       DENSE_RANK() OVER (PARTITION BY GroupNum ORDER BY ID) AS RankInGroup
FROM Grouped
WHERE Vals <> 'Product';

---

### ✅ 12. Employees with above-average department sales:

SELECT *
FROM #EmployeeSales e
WHERE SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM #EmployeeSales
    WHERE Department = e.Department
      AND SalesMonth = e.SalesMonth
      AND SalesYear = e.SalesYear
);

---

### ✅ 13. Employees with highest sales in any month using `EXISTS`:

Xolmirzabek Ashiraliyev, [7/25/2025 11:38 PM]
SELECT *
FROM #EmployeeSales e1
WHERE NOT EXISTS (
    SELECT 1
    FROM #EmployeeSales e2
    WHERE e1.SalesMonth = e2.SalesMonth
      AND e1.SalesYear = e2.SalesYear
      AND e2.SalesAmount > e1.SalesAmount
);

---

### ✅ 14. Employees who made sales in every month using `NOT EXISTS`:

SELECT DISTINCT e.EmployeeName
FROM #EmployeeSales e
WHERE NOT EXISTS (
    SELECT 1
    FROM (SELECT DISTINCT SalesMonth FROM #EmployeeSales) m
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales s
        WHERE s.EmployeeName = e.EmployeeName
          AND s.SalesMonth = m.SalesMonth
    )
);

---

### ✅ 15. Products more expensive than average price:

SELECT Name
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

---

### ✅ 16. Products with stock less than highest stock:

SELECT Name
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);

---

### ✅ 17. Products in same category as 'Laptop':

SELECT Name
FROM Products
WHERE Category = (SELECT Category FROM Products WHERE Name = 'Laptop');

---

### ✅ 18. Products priced higher than lowest price in Electronics:

SELECT Name
FROM Products
WHERE Price > (
    SELECT MIN(Price)
    FROM Products
    WHERE Category = 'Electronics'
);

---

### ✅ 19. Products priced above average of their category:

SELECT Name
FROM Products p
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
    WHERE Category = p.Category
);

---

### ✅ 20. Products that have been ordered at least once:

SELECT DISTINCT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID;

---

### ✅ 21. Products ordered more than average quantity:

SELECT p.Name
FROM Orders o
JOIN Products p ON p.ProductID = o.ProductID
GROUP BY p.Name
HAVING SUM(o.Quantity) > (
    SELECT AVG(TotalQuantity)
    FROM (
        SELECT SUM(Quantity) AS TotalQuantity
        FROM Orders
        GROUP BY ProductID
    ) AS AvgQty
);

---

### ✅ 22. Products that have never been ordered:

SELECT Name
FROM Products
WHERE ProductID NOT IN (
    SELECT DISTINCT ProductID FROM Orders
);

---

### ✅ 23. Product with highest total quantity ordered:

SELECT TOP 1 p.Name
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY SUM(o.Quantity) DESC;

---

Let me know if you want all of these bundled into one SQL script or help with testing any particular one!
