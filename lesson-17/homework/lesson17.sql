
### 1\. Distributor Sales Report

This query creates a complete list of every distributor and region combination using a CROSS JOIN. It then LEFT JOIN`s this to the actual sales data, replacing any `NULL sales values with 0 to ensure every distributor is represented for every region.

WITH AllDistributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
),
AllRegions AS (
    SELECT DISTINCT Region FROM #RegionSales
)
SELECT
    ar.Region,
    ad.Distributor,
    ISNULL(rs.Sales, 0) AS Sales
FROM AllRegions ar
CROSS JOIN AllDistributors ad
LEFT JOIN #RegionSales rs ON ar.Region = rs.Region AND ad.Distributor = rs.Distributor
ORDER BY ad.Distributor, ar.Region;

-----

### 2\. Find Managers with At Least Five Direct Reports

This solution finds all managerId values that appear five or more times in the Employee table and then retrieves the names of those managers.

SELECT
    m.name
FROM Employee e
JOIN Employee m ON e.managerId = m.id
GROUP BY
    m.name
HAVING
    COUNT(e.id) >= 5;

-----

### 3\. Products Ordered in February 2020

This query filters orders placed in February 2020, groups them by product, and calculates the total units sold. The HAVING clause ensures only products with at least 100 units are returned.

SELECT
    p.product_name,
    SUM(o.unit) as unit
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE
    o.order_date >= '2020-02-01' AND o.order_date <= '2020-02-29'
GROUP BY
    p.product_name
HAVING
    SUM(o.unit) >= 100;

-----

### 4\. Customer's Most Frequent Vendor

This query uses a Common Table Expression (CTE) with the RANK() window function to find the vendor with the highest number of orders for each customer.

WITH VendorRank AS (
    SELECT
        CustomerID,
        Vendor,
        RANK() OVER (PARTITION BY CustomerID ORDER BY COUNT(OrderID) DESC) as RankNum
    FROM
        Orders
    GROUP BY
        CustomerID,
        Vendor
)
SELECT
    CustomerID,
    Vendor
FROM
    VendorRank
WHERE
    RankNum = 1;

-----

### 5\. Check for Prime Number

This script checks if a number is prime by attempting to divide it by numbers from 2 up to its square root. If no divisors are found, the number is prime.

DECLARE @Check_Prime INT = 91;
DECLARE @Is_Prime BIT = 1;
DECLARE @i INT = 2;

IF @Check_Prime <= 1
    SET @Is_Prime = 0;
ELSE
    WHILE @i <= SQRT(@Check_Prime)
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @Is_Prime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END

IF @Is_Prime = 1
    SELECT 'This number is prime';
ELSE
    SELECT 'This number is not prime';

-----

### 6\. Device Signal Analysis

This solution uses two CTEs. The first aggregates signal counts per location. The second ranks these locations for each device. The final query combines this information to produce the required report.

WITH LocationCounts AS (
    SELECT
        Device_id,
        Locations,
        COUNT(*) AS signal_count
    FROM Device
    GROUP BY Device_id, Locations
),
RankedLocations AS (
    SELECT
        Device_id,
        Locations,
        signal_count,
        ROW_NUMBER() OVER(PARTITION BY Device_id ORDER BY signal_count DESC, Locations ASC) as rn
    FROM LocationCounts
)
SELECT
    d.Device_id,
    COUNT(DISTINCT d.Locations) AS no_of_location,
    rl.Locations AS max_signal_location,
    COUNT(d.Device_id) AS no_of_signals
FROM Device d
JOIN RankedLocations rl ON d.Device_id = rl.Device_id AND rl.rn = 1
GROUP BY d.Device_id, rl.Locations
ORDER BY d.Device_id;

-----

### 7\. Employees Earning More Than Department Average

A CTE is used to first calculate the average salary for each department. This result is then joined back to the Employee table to find all employees who earn more than their department's average.

Xolmirzabek Ashiraliyev, [7/25/2025 8:03 AM]
WITH DeptAvgSalary AS (
    SELECT
        DeptID,
        AVG(Salary) as AvgSalary
    FROM Employee
    GROUP BY DeptID
)
SELECT
    e.EmpID,
    e.EmpName,
    e.Salary
FROM Employee e
JOIN DeptAvgSalary das ON e.DeptID = das.DeptID
WHERE e.Salary > das.AvgSalary;

-----

### 8\. Lottery Winnings Calculation

This query calculates the number of matches for each ticket. It then uses a CASE statement to assign winnings based on the match count and sums the total.

WITH TicketMatches AS (
    SELECT
        t.TicketID,
        COUNT(n.Number) AS MatchCount
    FROM Tickets t
    JOIN Numbers n ON t.Number = n.Number
    GROUP BY t.TicketID
),
TotalWinningNumbers AS (
    SELECT COUNT(*) AS TotalCount FROM Numbers
)
SELECT
    SUM(
        CASE
            WHEN tm.MatchCount = (SELECT TotalCount FROM TotalWinningNumbers) THEN 100
            WHEN tm.MatchCount > 0 THEN 10
            ELSE 0
        END
    ) AS TotalWinnings
FROM TicketMatches tm;

-----

### 9\. Daily User Spending by Platform

This query is complex. It first determines each user's platform usage type ('Mobile', 'Desktop', or 'Both') per day. It then joins this with a calendar of all possible platforms to construct the final report, ensuring all combinations are present for each day.

WITH DailyUserPlatform AS (
    SELECT
        spend_date,
        user_id,
        SUM(amount) AS total_amount,
        CASE
            WHEN COUNT(DISTINCT platform) = 2 THEN 'Both'
            ELSE MIN(platform)
        END AS platform_type
    FROM Spending
    GROUP BY spend_date, user_id
),
Platforms AS (
    SELECT 'Desktop' AS platform UNION ALL
    SELECT 'Mobile' UNION ALL
    SELECT 'Both'
),
Dates AS (
    SELECT DISTINCT spend_date FROM Spending
)
SELECT
    d.spend_date,
    p.platform,
    ISNULL(SUM(dup.total_amount), 0) AS total_amount,
    ISNULL(COUNT(dup.user_id), 0) AS total_users
FROM Dates d
CROSS JOIN Platforms p
LEFT JOIN DailyUserPlatform dup ON d.spend_date = dup.spend_date AND p.platform = dup.platform_type
GROUP BY d.spend_date, p.platform
ORDER BY d.spend_date, p.platform;

-----

### 10\. De-group Data Using Recursion

A recursive CTE is used to expand each product row. The anchor member starts the count, and the recursive part decrements the count for each new row until it reaches one, effectively "un-grouping" the data.

WITH DeGrouped AS (
    SELECT
        Product,
        Quantity
    FROM Grouped
    UNION ALL
    SELECT
        Product,
        Quantity - 1
    FROM DeGrouped
    WHERE Quantity > 1
)
SELECT
    Product,
    1 AS Quantity
FROM DeGrouped
ORDER BY Product;
