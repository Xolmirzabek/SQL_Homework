

-----

## Easy Tasks

### 1\. Split Name and Surname

This query splits the Name column into two separate columns, Name and Surname, using the comma as a delimiter.

SELECT
  PARSENAME(REPLACE(Name, ',', '.'), 2) AS Name,
  PARSENAME(REPLACE(Name, ',', '.'), 1) AS Surname
FROM TestMultipleColumns;

\<br\>

### 2\. Find Strings Containing '%'

This query finds all strings in the TestPercent table that contain the % character. The ESCAPE clause is used to treat % as a literal character rather than a wildcard.

SELECT
  *
FROM TestPercent
WHERE
  Strs LIKE '%#%%' ESCAPE '#';

\<br\>

### 3\. Split String by Dot

This query splits the Vals string by the dot (.) into two parts. PARSENAME is effective here as it naturally uses dots as delimiters.

SELECT
  PARSENAME(Vals, 2) AS Part1,
  PARSENAME(Vals, 1) AS Part2
FROM Splitter;

\<br\>

### 4\. Replace All Digits with 'X'

This query replaces all numerical digits in the provided string with the character 'X'.

SELECT
  REPLACE(
    REPLACE(
      REPLACE(
        REPLACE(
          REPLACE(
            REPLACE(
              REPLACE(
                REPLACE(
                  REPLACE(
                    REPLACE('1234ABC123456XYZ1234567890ADS', '1', 'X'),
                    '2',
                    'X'
                  ),
                  '3',
                  'X'
                ),
                '4',
                'X'
              ),
              '5',
              'X'
            ),
            '6',
            'X'
          ),
          '7',
          'X'
        ),
        '8',
        'X'
      ),
      '9',
      'X'
    ),
    '0',
    'X'
  ) AS ReplacedString;


\<br\>

### 5\. Find Strings with More Than Two Dots

This query returns all rows where the Vals column contains more than two dots.

SELECT
  *
FROM testDots
WHERE
  LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;

\<br\>

### 6\. Count Spaces in a String

This query counts the total number of spaces in each string within the CountSpaces table.

SELECT
  texts,
  LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS NumberOfSpaces
FROM CountSpaces;

\<br\>

### 7\. Employees Earning More Than Their Managers

This query finds all employees who have a salary greater than their manager's salary.

SELECT
  e.Name AS Employee
FROM Employee e
JOIN Employee m
  ON e.ManagerId = m.Id
WHERE
  e.Salary > m.Salary;

\<br\>

### 8\. Employees with 10-15 Years of Service

This query finds employees who have been with the company for more than 10 years but less than 15.

SELECT
  EMPLOYEE_ID,
  FIRST_NAME,
  LAST_NAME,
  HIRE_DATE,
  DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS YearsOfService
FROM Employees
WHERE
  DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 10 AND DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 15;

-----

## Medium Tasks

### 1\. Separate Integer and Character Values

This query separates the integer and character values from the string 'rtcfvty34redt' into two different columns.

SELECT
  TRANSLATE('rtcfvty34redt', 'abcdefghijklmnopqrstuvwxyz', '                          ') AS Integers,
  TRANSLATE('rtcfvty34redt', '0123456789', '          ') AS Characters;

\<br\>

### 2\. Dates with Higher Temperature Than Previous Day

This query finds all `Id`s where the temperature was higher than on the previous day.

WITH TemperatureComparison AS (
  SELECT
    Id,
    Temperature,
    LAG(Temperature, 1, NULL) OVER (
      ORDER BY
        RecordDate
    ) AS PreviousDayTemp
  FROM weather
)
SELECT
  Id
FROM TemperatureComparison
WHERE
  Temperature > PreviousDayTemp;

\<br\>

### 3\. First Login Date for Each Player

This query reports the first login date for each player.

SELECT
  player_id,
  MIN(event_date) AS first_login
FROM Activity
GROUP BY
  player_id;

\<br\>

### 4\. Return the Third Item from a List

This query returns the third item from the comma-separated list in the `fruits` table.

Xolmirzabek Ashiraliyev, [7/25/2025 7:44 AM]
SELECT
  value
FROM (
  SELECT
    value,
    ROW_NUMBER() OVER (
      ORDER BY
        (
          SELECT
            NULL
        )
    ) as rn
  FROM
    fruits
    CROSS APPLY STRING_SPLIT(fruit_list, ',')
) t
WHERE
  rn = 3;

\<br\>

### 5\. Convert String to Rows

This query converts each character from the string 'sdgfhsdgfhs@121313131' into a separate row.

WITH RECURSIVE CharSplit AS (
  SELECT
    CAST('sdgfhsdgfhs@121313131' AS VARCHAR(100)) as str,
    1 as n
  UNION ALL
  SELECT
    str,
    n + 1
  FROM CharSplit
  WHERE
    n < LEN(str)
)
SELECT
  SUBSTRING(str, n, 1) as Character
FROM CharSplit;

\<br\>

### 6\. Conditional Join

This query joins p1 and p2, but if p1.code is 0, it replaces it with the p2.code value.

SELECT
  p1.id,
  CASE WHEN p1.code = 0 THEN p2.code ELSE p1.code END AS code
FROM p1
JOIN p2
  ON p1.id = p2.id;

\<br\>

### 7\. Determine Employment Stage

This query determines the employment stage for each employee based on their hire date.

SELECT
  EMPLOYEE_ID,
  FIRST_NAME,
  LAST_NAME,
  HIRE_DATE,
  CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 THEN 'New Hire' WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 1 AND 5 THEN 'Junior' WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 5 AND 10 THEN 'Mid-Level' WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 20 THEN 'Senior' ELSE 'Veteran' END AS EmploymentStage
FROM Employees;

\<br\>

### 8\. Extract Integer from Start of String

This query extracts the integer value from the beginning of the VALS column.

SELECT
  VALS,
  LEFT(VALS, PATINDEX('%[^0-9]%', VALS + 'a') - 1) AS ExtractedInteger
FROM GetIntegers
WHERE
  ISNUMERIC(LEFT(VALS, 1)) = 1;

-----

## Difficult Tasks

### 1\. Swap First Two Letters of a String

This puzzle swaps the first two letters of a comma-separated string. For example, 'a,b,c' becomes 'b,a,c'.

SELECT
  Id,
  Vals,
  STUFF(
    Vals,
    1,
    CHARINDEX(',', Vals, CHARINDEX(',', Vals) + 1) - 1,
    SUBSTRING(
      Vals,
      CHARINDEX(',', Vals) + 1,
      CHARINDEX(',', Vals, CHARINDEX(',', Vals) + 1) - CHARINDEX(',', Vals) - 1
    ) + ',' + LEFT(Vals, CHARINDEX(',', Vals) - 1)
  ) AS SwappedVals
FROM MultipleVals;

\<br\>

### 2\. First Device Logged In

This SQL query reports the first device that was logged in for each player.

WITH FirstLogin AS (
  SELECT
    player_id,
    device_id,
    ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date ASC) as rn
  FROM Activity
)
SELECT
  player_id,
  device_id
FROM FirstLogin
WHERE
  rn = 1;

\<br\>

### 3\. Week-on-Week Sales Percentage

This query calculates the week-on-week percentage of sales for each area based on the financial week.

WITH WeeklySales AS (
  SELECT
    Area,
    [Date],
    FinancialWeek,
    COALESCE(SalesLocal, 0) + COALESCE(SalesRemote, 0) AS DailyTotal,
    SUM(COALESCE(SalesLocal, 0) + COALESCE(SalesRemote, 0)) OVER (PARTITION BY FinancialWeek, Area) AS WeeklyTotal
  FROM WeekPercentagePuzzle
)
SELECT
  Area,
  [Date],
  FinancialWeek,
  DailyTotal,
  WeeklyTotal,
  (
    CAST(DailyTotal AS DECIMAL(10, 2)) / WeeklyTotal
  ) * 100 AS SalesPercentage
FROM WeeklySales
WHERE
  WeeklyTotal > 0;
