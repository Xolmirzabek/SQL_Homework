
## Easy Tasks

-----

### 1\. Concatenate Employee ID and Name

This query combines the `EMPLOYEE_ID`, `FIRST_NAME`, and `LAST_NAME` from the `Employees` table.

```sql
SELECT
  CONCAT(employee_id, '-', FIRST_NAME, ' ', LAST_NAME) AS "Employee Info"
FROM Employees;
```

\<br\>

### 2\. Update Phone Numbers

This query updates the `PHONE_NUMBER` in the `Employees` table, replacing all occurrences of '124' with '999'.

```sql
UPDATE Employees
SET
  PHONE_NUMBER = REPLACE(PHONE_NUMBER, '124', '999')
WHERE
  PHONE_NUMBER LIKE '%124%';

-- To see the result
SELECT
  PHONE_NUMBER
FROM Employees
WHERE
  PHONE_NUMBER LIKE '%999%';
```

\<br\>

### 3\. Display First Name and Length

This query shows the first name and its length for all employees whose name starts with 'A', 'J', or 'M', sorted by their first name.

```sql
SELECT
  FIRST_NAME AS "Name",
  LEN(FIRST_NAME) AS "Length"
FROM Employees
WHERE
  FIRST_NAME LIKE '[AJM]%'
ORDER BY
  FIRST_NAME;
```

\<br\>

### 4\. Total Salary per Manager

This query calculates the total salary for each manager.

```sql
SELECT
  MANAGER_ID,
  SUM(SALARY) AS "Total Salary"
FROM Employees
WHERE
  MANAGER_ID IS NOT NULL
GROUP BY
  MANAGER_ID;
```

\<br\>

### 5\. Find the Highest Value

This query retrieves the year and the maximum value from the `Max1`, `Max2`, and `Max3` columns for each row.

```sql
SELECT
  Year1,
  (
    SELECT
      MAX(v)
    FROM (
      VALUES
        (Max1),
        (Max2),
        (Max3)
    ) AS value (v)
  ) AS HighestValue
FROM TestMax;
```

\<br\>

### 6\. Filter Movies

This query finds all movies with an odd-numbered ID and a description other than 'boring'.

```sql
SELECT
  *
FROM cinema
WHERE
  id % 2 != 0 AND description != 'boring';
```

\<br\>

### 7\. Custom Sort

This query sorts the data by `Id`, ensuring that an `Id` of 0 is always the last row.

```sql
SELECT
  *
FROM SingleOrder
ORDER BY
  CASE WHEN Id = 0 THEN 1 ELSE 0 END,
  Id;
```

\<br\>

### 8\. Find First Non-Null Value

This query selects the first non-null identifier for each person.

```sql
SELECT
  id,
  COALESCE(ssn, passportid, itin) AS identifier
FROM person;
```

-----

## Medium Tasks

-----

### 1\. Split Full Name

This query splits the `FullName` column into `FirstName`, `MiddleName`, and `LastName`.

```sql
SELECT
  FullName,
  PARSENAME(REPLACE(FullName, ' ', '.'), 3) AS FirstName,
  PARSENAME(REPLACE(FullName, ' ', '.'), 2) AS MiddleName,
  PARSENAME(REPLACE(FullName, ' ', '.'), 1) AS LastName
FROM Students;
```

\<br\>

### 2\. Conditional Customer Orders

This query provides a result set of customer orders delivered to Texas for every customer that also had a delivery to California.

```sql
SELECT
  *
FROM Orders
WHERE
  DeliveryState = 'TX' AND CustomerID IN (
    SELECT
      CustomerID
    FROM Orders
    WHERE
      DeliveryState = 'CA'
  );
```

\<br\>

### 3\. Group Concatenate Values

This SQL statement groups and concatenates values from the `DMLTable`.

```sql
SELECT
  STRING_AGG(String, ' ')
FROM DMLTable;
```

\<br\>

### 4\. Find Employees with at Least 3 'a's

This query finds all employees whose full name contains the letter 'a' at least 3 times.

```sql
SELECT
  *
FROM Employees
WHERE
  LEN(CONCAT(FIRST_NAME, LAST_NAME)) - LEN(
    REPLACE(
      LOWER(CONCAT(FIRST_NAME, LAST_NAME)),
      'a',
      ''
    )
  ) >= 3;
```

\<br\>

### 5\. Department Employee Analysis

This query returns the total number of employees in each department and the percentage of those employees who have been with the company for more than 3 years.

```sql
SELECT
  d.DEPARTMENT_ID,
  COUNT(e.EMPLOYEE_ID) AS TotalEmployees,
  (
    CAST(
      SUM(
        CASE WHEN DATEDIFF(YEAR, e.HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END
      ) AS FLOAT
    ) / COUNT(e.EMPLOYEE_ID)
  ) * 100 AS PercentageLongTermEmployees
FROM Employees e
JOIN (
  SELECT DISTINCT
    DEPARTMENT_ID
  FROM Employees
) d
  ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
GROUP BY
  d.DEPARTMENT_ID;
```

\<br\>

### 6\. Find Most and Least Experienced Spaceman

This query determines the most and least experienced `SpacemanID` based on their job description.

```sql
WITH RankedSpacemen AS (
  SELECT
    SpacemanID,
    JobDescription,
    MissionCount,
    ROW_NUMBER() OVER (PARTITION BY JobDescription ORDER BY MissionCount DESC) AS RankDesc,
    ROW_NUMBER() OVER (PARTITION BY JobDescription ORDER BY MissionCount ASC) AS RankAsc
  FROM Personal
)
SELECT
  JobDescription,
  MAX(
    CASE WHEN RankDesc = 1 THEN SpacemanID END
  ) AS MostExperienced,
  MAX(
    CASE WHEN RankAsc = 1 THEN SpacemanID END
  ) AS LeastExperienced
FROM RankedSpacemen
WHERE
  RankDesc = 1 OR RankAsc = 1
GROUP BY
  JobDescription;
```

-----

## Difficult Tasks

-----

### 1\. Separate Characters from a String

This query separates the uppercase letters, lowercase letters, numbers, and other characters from the string 'tf56sd\#%OqH' into separate columns.

```sql
WITH Chars AS (
  SELECT 'tf56sd#%OqH' AS str
)
SELECT
  (
    SELECT
      STRING_AGG(c, '')
    FROM (
      SELECT
        SUBSTRING(str, n, 1) AS c
      FROM (
        SELECT
          ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
        FROM master.dbo.spt_values
      ) AS nums
      WHERE
        n <= LEN(str) AND SUBSTRING(str, n, 1) LIKE '[A-Z]'
    ) AS UpperChars
  ) AS Uppercase,
  (
    SELECT
      STRING_AGG(c, '')
    FROM (
      SELECT
        SUBSTRING(str, n, 1) AS c
      FROM (
        SELECT
          ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
        FROM master.dbo.spt_values
      ) AS nums
      WHERE
        n <= LEN(str) AND SUBSTRING(str, n, 1) LIKE '[a-z]'
    ) AS LowerChars
  ) AS Lowercase,
  (
    SELECT
      STRING_AGG(c, '')
    FROM (
      SELECT
        SUBSTRING(str, n, 1) AS c
      FROM (
        SELECT
          ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
        FROM master.dbo.spt_values
      ) AS nums
      WHERE
        n <= LEN(str) AND SUBSTRING(str, n, 1) LIKE '[0-9]'
    ) AS NumberChars
  ) AS Numbers,
  (
    SELECT
      STRING_AGG(c, '')
    FROM (
      SELECT
        SUBSTRING(str, n, 1) AS c
      FROM (
        SELECT
          ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
        FROM master.dbo.spt_values
      ) AS nums
      WHERE
        n <= LEN(str) AND SUBSTRING(str, n, 1) LIKE '[^a-zA-Z0-9]'
    ) AS OtherChars
  ) AS Others
FROM Chars;
```

\<br\>

### 2\. Calculate Running Total

This query replaces each row's `Grade` with the sum of its value and the previous rows' values.

```sql
SELECT
  StudentID,
  FullName,
  Grade,
  SUM(Grade) OVER (
    ORDER BY
      StudentID
  ) AS RunningTotal
FROM Students;
```

\<br\>

### 3\. Sum Equations from a String

This query sums the equations in the `Equation` column and provides the answers in the output. This is a more complex task that typically requires dynamic SQL.

```sql
DECLARE @sql NVARCHAR(MAX) = '';

SELECT
  @sql += 'SELECT ''' + Equation + ''' AS Equation, ' + Equation +
' AS Result UNION ALL '
FROM Equations;

-- Remove the last 'UNION ALL'
SET @sql = SUBSTRING(@sql, 1, LEN(@sql) - 10);

EXEC sp_executesql @sql;
```

\<br\>

### 4\. Find Students with the Same Birthday

This query finds all students who share a birthday.

```sql
SELECT
  s1.StudentName,
  s1.Birthday
FROM Student s1
JOIN Student s2
  ON s1.Birthday = s2.Birthday AND s1.StudentName <> s2.StudentName
ORDER BY
  s1.Birthday,
  s1.StudentName;
```

\<br\>

### 5\. Aggregate Player Scores

This query calculates the total score for each unique player pair, regardless of the order in which they appear.

```sql
SELECT
  CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
  CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS Player2,
  SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY
  CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
  CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END;
```
