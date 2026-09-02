# 📌 Section 05: Advanced Select and Joins Problem Set (LeetCode SQL 50)

Welcome to the **Advanced Select and Joins Problem Set** section! This directory contains my personal solutions for problems 30 through 36 from the **LeetCode SQL 50** study plan.

This section covers complex SQL selection and join techniques, including hierarchical Self-Joins (`manager-employee` relationships), triple consecutive row matching, conditional logic using mathematical theorems (`CASE WHEN`), window functions for running totals (`SUM() OVER`), point-in-time state reconstruction using date filters and `COALESCE()`, and structured categorical aggregations using `UNION ALL`.

---

## 📊 Summary of Problems

| # | Problem Name | Difficulty | Key Concepts Covered |
| :--- | :--- | :--- | :--- |
| **30** | [1731. The Number of Employees Which Report to Each Employee](./30-lc-1731-the-number-of-employees-which-report-to-each-employee) | Easy | `SELF JOIN`, `GROUP BY`, `COUNT()`, `ROUND(AVG())` |
| **31** | [1789. Primary Department for Each Employee](./31-lc-1789-primary-department-for-each-employee) | Easy | Subquery (`HAVING COUNT(*) = 1`), `WHERE OR` |
| **32** | [610. Triangle Judgement](./32-lc-610-triangle-judgement) | Easy | Triangle Inequality Theorem, `CASE WHEN` |
| **33** | [180. Consecutive Numbers](./33-lc-180-consecutive-numbers) | Medium | Triple `SELF JOIN`, `SELECT DISTINCT` |
| **34** | [1164. Product Price at a Given Date](./34-lc-1164-product-price-at-a-given-date) | Medium | Subquery (`MAX(change_date)`), `LEFT JOIN`, `COALESCE()` |
| **35** | [1204. Last Person to Fit in the Bus](./35-lc-1204-last-person-to-fit-in-the-bus) | Medium | Running Total (`SUM() OVER`), `LIMIT 1` |
| **36** | [1907. Count Salary Categories](./36-lc-1907-count-salary-categories) | Medium | `UNION ALL`, Conditional `COUNT(CASE)` |

---

## 📝 Detailed Solutions & Explanations

### 30. [LC 1731: The Number of Employees Which Report to Each Employee](./30-lc-1731-the-number-of-employees-which-report-to-each-employee)

#### 📋 Problem Statement:
Report the IDs and names of all **managers**, the number of employees reporting directly to them (`reports_count`), and the average age of their direct reports rounded to the nearest integer (`average_age`).

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT manager.employee_id,
       manager.name,
       COUNT(employee.employee_id) AS reports_count,
       ROUND(AVG(employee.age)) AS average_age
FROM Employees AS manager
JOIN Employees AS employee
  ON manager.employee_id = employee.reports_to
GROUP BY manager.employee_id,
         manager.name
ORDER BY manager.employee_id ASC;
```

#### 💡 Explanation & Comment:
- Perform a `SELF JOIN` on `Employees` joining `manager.employee_id = employee.reports_to`.
- Group by manager ID and name.
- Count direct reports (`COUNT()`) and compute rounded average age (`ROUND(AVG())`).

---

### 31. [LC 1789: Primary Department for Each Employee](./31-lc-1789-primary-department-for-each-employee)

#### 📋 Problem Statement:
Report all employees with their primary department. If an employee belongs to multiple departments, select the one with `primary_flag = 'Y'`. If an employee belongs to only 1 department, report that single department.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT employee_id,
       department_id
FROM Employee
WHERE primary_flag = 'Y'
   OR employee_id IN (
       SELECT employee_id
       FROM Employee
       GROUP BY employee_id
       HAVING COUNT(*) = 1
   );
```

#### 💡 Explanation & Comment:
- Use `WHERE primary_flag = 'Y'` to select primary departments for multi-dept employees.
- Use `OR employee_id IN (SELECT ... HAVING COUNT(*) = 1)` to capture employees who belong to only 1 department regardless of their `primary_flag`.

---

### 32. [LC 610: Triangle Judgement](./32-lc-610-triangle-judgement)

#### 📋 Problem Statement:
Report for every three line segments (`x`, `y`, `z`) whether they can form a **triangle** (`'Yes'` or `'No'`).

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT x, y, z,
       CASE 
           WHEN x + y > z 
            AND x + z > y 
            AND z + y > x 
           THEN 'Yes'
           ELSE 'No'
       END AS triangle
FROM Triangle;
```

#### 💡 Explanation & Comment:
- Apply the **Triangle Inequality Theorem**: three side lengths form a valid triangle if and only if the sum of any two sides is strictly greater than the third side (`x+y > z`, `x+z > y`, `y+z > x`).

---

### 33. [LC 180: Consecutive Numbers](./33-lc-180-consecutive-numbers)

#### 📋 Problem Statement:
Find all numbers (`ConsecutiveNums`) that appear **at least three times consecutively** in the `Logs` table.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT DISTINCT l1.num AS ConsecutiveNums
FROM Logs AS l1
JOIN Logs AS l2
  ON l2.id = l1.id + 1
JOIN Logs AS l3
  ON l3.id = l2.id + 1
WHERE l1.num = l2.num
  AND l2.num = l3.num;
```

#### 💡 Explanation & Comment:
- Perform a triple `SELF JOIN` matching consecutive IDs (`l1.id`, `l1.id + 1`, `l2.id + 1`).
- Filter rows where `l1.num = l2.num AND l2.num = l3.num`.
- Deduplicate using `SELECT DISTINCT`.

---

### 34. [LC 1164: Product Price at a Given Date](./34-lc-1164-product-price-at-a-given-date)

#### 📋 Problem Statement:
Find the prices of all products on the date `2019-08-16`. Initially, all products have a default price of `$10`.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT p.product_id,
       COALESCE(x.new_price, 10) AS price
FROM (
    SELECT DISTINCT product_id
    FROM Products
) AS p
LEFT JOIN (
    SELECT product_id,
           new_price
    FROM Products
    WHERE (product_id, change_date) IN (
        SELECT product_id,
               MAX(change_date)
        FROM Products
        WHERE change_date <= '2019-08-16'
        GROUP BY product_id
    )
) AS x
  ON p.product_id = x.product_id;
```

#### 💡 Explanation & Comment:
- Select all unique `product_id`s.
- `LEFT JOIN` with a subquery that extracts the latest price change on or before `2019-08-16` (`MAX(change_date)`).
- Use `COALESCE(x.new_price, 10)` to assign the default price `$10` if no changes occurred on or before target date.

---

### 35. [LC 1204: Last Person to Fit in the Bus](./35-lc-1204-last-person-to-fit-in-the-bus)

#### 📋 Problem Statement:
Find the `person_name` of the last person that can fit on the bus without exceeding the total cumulative weight limit of **1000 kg**.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT person_name
FROM (
    SELECT person_name,
           turn,
           SUM(weight) OVER (ORDER BY turn) AS total_weight
    FROM Queue
) AS q
WHERE total_weight <= 1000
ORDER BY turn DESC
LIMIT 1;
```

#### 💡 Explanation & Comment:
- Use Window Function `SUM(weight) OVER (ORDER BY turn)` to calculate running total weight for passengers in boarding order.
- Filter `total_weight <= 1000`, sort by `turn DESC`, and fetch top 1 using `LIMIT 1`.

---

### 36. [LC 1907: Count Salary Categories](./36-lc-1907-count-salary-categories)

#### 📋 Problem Statement:
Calculate the number of bank accounts for each category: `"Low Salary"` (`< $20k`), `"Average Salary"` (`$20k-$50k`), and `"High Salary"` (`> $50k`). All 3 categories must appear in output (return `0` if empty).

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT 'Low Salary' AS category,
       COUNT(CASE WHEN income < 20000 THEN 1 END) AS accounts_count
FROM Accounts

UNION ALL

SELECT 'Average Salary' AS category,
       COUNT(CASE WHEN income BETWEEN 20000 AND 50000 THEN 1 END) AS accounts_count
FROM Accounts

UNION ALL

SELECT 'High Salary' AS category,
       COUNT(CASE WHEN income > 50000 THEN 1 END) AS accounts_count
FROM Accounts;
```

#### 💡 Explanation & Comment:
- Construct 3 explicit `SELECT` queries for each salary bucket using `COUNT(CASE WHEN ... THEN 1 END)`.
- Combine them with `UNION ALL` to guarantee all 3 category rows exist in the output with correct counts (or `0`).

---

## 🚀 Technologies Used
- **SQL (Structured Query Language)**
- Supported Databases: **MySQL**, **PostgreSQL**

---
*All solutions written and verified by [Ashfak](https://github.com/ashfak-g).*
