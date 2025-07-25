
## Level 1: Basic Subqueries

### 1\. Find Employees with Minimum Salary

This query finds the minimum salary in the employees table using a subquery and then retrieves all employees who earn that salary.

SELECT id, name, salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);

\<br\>

### 2\. Find Products Above Average Price

This query calculates the average price of all products and then returns the products with a price higher than the average.

SELECT id, product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-----

## Level 2: Nested Subqueries with Conditions

### 3\. Find Employees in Sales Department

This query retrieves the id for the 'Sales' department from the departments table and uses it to find all employees in that department.

SELECT id, name, department_id
FROM employees
WHERE department_id = (SELECT id FROM departments WHERE department_name = 'Sales');

\<br\>

### 4\. Find Customers with No Orders

This query finds customers who do not have any corresponding entries in the orders table using NOT EXISTS.

SELECT customer_id, name
FROM customers c
WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id);

-----

## Level 3: Aggregation and Grouping in Subqueries

### 5\. Find Products with Max Price in Each Category

This query finds the maximum price for each category and then retrieves the product(s) that match that price within each category.

SELECT p.id, p.product_name, p.price, p.category_id
FROM products p
JOIN (
    SELECT category_id, MAX(price) AS max_price
    FROM products
    GROUP BY category_id
) AS max_prices
ON p.category_id = max_prices.category_id AND p.price = max_prices.max_price;

\<br\>

### 6\. Find Employees in Department with Highest Average Salary

This query identifies the department with the highest average salary and then lists all employees working in it.

SELECT id, name, salary, department_id
FROM employees
WHERE department_id = (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);

-----

## Level 4: Correlated Subqueries

### 7\. Find Employees Earning Above Department Average

This query uses a correlated subquery to find employees whose salary is greater than the average salary of their respective departments.

SELECT id, name, salary, department_id
FROM employees e1
WHERE salary > (
    SELECT AVG(salary)
    FROM employees e2
    WHERE e2.department_id = e1.department_id
);

\<br\>

### 8\. Find Students with Highest Grade per Course

This query retrieves the students who achieved the highest grade in each course by correlating the grades table with itself.

SELECT s.name, g.course_id, g.grade
FROM grades g
JOIN students s ON g.student_id = s.student_id
WHERE g.grade = (
    SELECT MAX(grade)
    FROM grades g2
    WHERE g2.course_id = g.course_id
);

-----

## Level 5: Subqueries with Ranking and Complex Conditions

### 9\. Find Third-Highest Price per Category

This query uses a Common Table Expression (CTE) with the DENSE_RANK window function to find the product with the third-highest price in each category.

WITH RankedProducts AS (
    SELECT
        id,
        product_name,
        price,
        category_id,
        DENSE_RANK() OVER(PARTITION BY category_id ORDER BY price DESC) as price_rank
    FROM products
)
SELECT id, product_name, price, category_id
FROM RankedProducts
WHERE price_rank = 3;

\<br\>

### 10\. Find Employees with Salary Between Company Average and Department Max

This query retrieves employees whose salary is above the overall company average but below the maximum salary within their own department.

SELECT id, name, salary, department_id
FROM employees e1
WHERE salary > (SELECT AVG(salary) FROM employees)
  AND salary < (
        SELECT MAX(salary)
        FROM employees e2
        WHERE e2.department_id = e1.department_id
      );
