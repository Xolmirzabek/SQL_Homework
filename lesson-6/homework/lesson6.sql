Here are the solutions to the practice puzzles for Lesson 6.

### Puzzle 1: Finding Distinct Values

Question: Explain at least two ways to find distinct values based on two columns, where the order of values does not matter (e.g., (a, b) is treated the same as (b, a)).

-----

#### Explanation

This problem requires us to find unique pairs, regardless of the order of values within the pair. A simple SELECT DISTINCT col1, col2 won't work because it would treat (a, b) and (b, a) as two different records. The key is to create a consistent, or "canonical," representation for each pair before finding the distinct ones.

Method 1: Using `CASE` to Normalize Pairs

This is the most straightforward and often most efficient method. We can use a CASE (or IIF) statement to reorder the values in each row so that the lesser value is always in the first column and the greater value is in the second. After normalizing each pair, we can then use DISTINCT to remove duplicates.

Method 2: Using a `WHERE` Clause with a Condition

Another approach is to filter the rows in a way that for any given pair (x, y) and its reverse (y, x), only one of them is ever included in the result set. We can achieve this by adding a condition to the WHERE clause, for example, WHERE col1 <= col2. This ensures that for any pair of values, only the row where the first column's value is less than or equal to the second's is selected. Applying DISTINCT afterward removes any remaining duplicates (like the multiple (a, b) rows).

-----

#### SQL Solution

Here is the SQL query using Method 1, which is generally recommended.

SELECT DISTINCT
  CASE
    WHEN col1 < col2
    THEN col1
    ELSE col2
  END AS c1,
  CASE
    WHEN col1 < col2
    THEN col2
    ELSE col1
  END AS c2
FROM InputTbl;

### Puzzle 2: Removing Rows with All Zeroes

Question: If all the columns have zero values, then don’t show that row.

SELECT
  A,
  B,
  C,
  D
FROM TestMultipleZero
WHERE
  A <> 0 OR B <> 0 OR C <> 0 OR D <> 0;

*This query filters the table to include only those rows where at least one of the columns has a non-zero value.*

### Puzzle 3: Find those with odd ids

SELECT
  id,
  name
FROM section1
WHERE
  id % 2 <> 0;

*This query uses the modulo operator (%) to find rows where the id is not divisible by 2.*

### Puzzle 4: Person with the smallest id

SELECT TOP 1
  id,
  name
FROM section1
ORDER BY
  id ASC;

*This query sorts the table by id in ascending order and selects the first record.*

### Puzzle 5: Person with the highest id

SELECT TOP 1
  id,
  name
FROM section1
ORDER BY
  id DESC;

*This query sorts the table by id in descending order and selects the first record.*

### Puzzle 6: People whose name starts with b

SELECT
  id,
  name
FROM section1
WHERE
  name LIKE 'B%';

*This query uses the LIKE operator with the wildcard % to find any name starting with 'B'. This will work for both 'Been' and 'Bruno' on a case-insensitive SQL Server instance.*

### Puzzle 7: Write a query to return only the rows where the code contains the literal underscore \_

SELECT
  Code
FROM ProductCodes
WHERE
  Code LIKE '%[_]%';

*The LIKE operator treats _ as a wildcard for a single character. To search for the literal underscore, we can enclose it in square brackets [] to tell SQL Server to treat it as a character to match, not a wildcard.*
