# 📌 Section 07: Advanced String Functions / Regex / Clause (LeetCode SQL 50)

Welcome to the **Advanced String Functions / Regex / Clause** section! This directory contains my personal solutions for problems 44 through 50 from the **LeetCode SQL 50** study plan.

This concluding section focuses on string manipulation and advanced SQL clauses. Topics include capitalization and substring extraction (`UPPER`, `LOWER`, `CONCAT`, `SUBSTR`), pattern matching with wildcards (`LIKE`), in-place data modification with `DELETE` statements and self-joins, handling missing records gracefully in scalar subqueries (`LIMIT 1 OFFSET 1`), string aggregation functions across dialects (`STRING_AGG` in PostgreSQL, `GROUP_CONCAT` in MySQL), date range filtering with `HAVING`, and complex regular expression validation (`REGEXP` in MySQL, `~` in PostgreSQL).

---

## 📊 Summary of Problems

| # | Problem Name | Difficulty | Key Concepts Covered |
| :--- | :--- | :--- | :--- |
| **44** | [1667. Fix Names in a Table](./44-lc-1667-fix-names-in-a-table) | Easy | `CONCAT()`, `UPPER()`, `LOWER()`, `SUBSTR()` / `LEFT()` |
| **45** | [1527. Patients With a Condition](./45-lc-1527-patients-with-a-condition) | Easy | `LIKE` with Wildcards (`'DIAB1%'`, `'% DIAB1%'`), `REGEXP` |
| **46** | [196. Delete Duplicate Emails](./46-lc-196-delete-duplicate-emails) | Easy | `DELETE` with Self-Join (`USING` / `JOIN`), Subquery with `MIN(id)` |
| **47** | [176. Second Highest Salary](./47-lc-176-second-highest-salary) | Medium | Scalar Subquery, `LIMIT 1 OFFSET 1`, `MAX()` Subquery |
| **48** | [1484. Group Sold Products By The Date](./48-lc-1484-group-sold-products-by-the-date) | Easy | `STRING_AGG()` / `GROUP_CONCAT()`, `COUNT(DISTINCT)` |
| **49** | [1327. List the Products Ordered in a Period](./49-lc-1327-list-the-products-ordered-in-a-period) | Easy | Date Range Filtering, `INNER JOIN`, `GROUP BY ... HAVING` |
| **50** | [1517. Find Users With Valid E-Mails](./50-lc-1517-find-users-with-valid-e-mails) | Easy | Regular Expressions (`~` in PostgreSQL, `REGEXP` in MySQL) |

---

## 📝 Detailed Solutions & Explanations

### 44. [LC 1667: Fix Names in a Table](./44-lc-1667-fix-names-in-a-table)

#### 📋 Problem Statement:
Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase. Return the result table ordered by `user_id` in ascending order.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT user_id,
       CONCAT(UPPER(LEFT(name, 1)), LOWER(SUBSTR(name, 2))) AS name
FROM Users
ORDER BY user_id ASC;
```

#### 💡 Explanation & Comment:
- Use `LEFT(name, 1)` to extract the first character and `UPPER(...)` to capitalize it.
- Use `SUBSTR(name, 2)` to extract the remaining characters and `LOWER(...)` to lowercase them.
- Combine both pieces using `CONCAT(...)`.
- Sort by `user_id ASC`.

---

### 45. [LC 1527: Patients With a Condition](./45-lc-1527-patients-with-a-condition)

#### 📋 Problem Statement:
Find the `patient_id`, `patient_name`, and `conditions` of the patients who have Type I Diabetes. Type I Diabetes code always starts with the `DIAB1` prefix. Return the result table in any order.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT patient_id,
       patient_name,
       conditions
FROM Patients
WHERE conditions LIKE 'DIAB1%'
   OR conditions LIKE '% DIAB1%';
```

#### 💡 Explanation & Comment:
- The condition code can appear at the very start of the `conditions` column (`conditions LIKE 'DIAB1%'`) or as a subsequent code preceded by a space (`conditions LIKE '% DIAB1%'`).
- *Note*: Simply using `%DIAB1%` is incorrect because it would erroneously match codes like `SADIAB100` where `DIAB1` is not a prefix.

---

### 46. [LC 196: Delete Duplicate Emails](./46-lc-196-delete-duplicate-emails)

#### 📋 Problem Statement:
Write a solution to delete all duplicate emails, keeping only one unique email with the smallest `id`. You must write a `DELETE` statement, not a `SELECT` statement.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

-- For PostgreSQL:
DELETE FROM Person AS p1
USING Person AS p2
WHERE p1.email = p2.email
  AND p1.id > p2.id;

-- For MySQL:
-- DELETE p1
-- FROM Person AS p1
-- JOIN Person AS p2
--   ON p1.email = p2.email
--  AND p1.id > p2.id;
```

#### 💡 Explanation & Comment:
- Match table `Person` against itself on `p1.email = p2.email`.
- Condition `p1.id > p2.id` identifies the duplicate records with strictly larger IDs.
- Deleting `p1` ensures only the smallest `id` for each unique email is preserved.

---

### 47. [LC 176: Second Highest Salary](./47-lc-176-second-highest-salary)

#### 📋 Problem Statement:
Find the second highest distinct salary from the `Employee` table. If there is no second highest salary, return `null`.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
) AS SecondHighestSalary;
```

#### 💡 Explanation & Comment:
- `SELECT DISTINCT salary FROM Employee ORDER BY salary DESC LIMIT 1 OFFSET 1` retrieves the 2nd distinct highest salary.
- Wrapping the query as a scalar subquery `SELECT ( ... ) AS SecondHighestSalary` guarantees that if fewer than 2 distinct salaries exist, SQL returns a single row containing `null` instead of an empty set.
- *Alternative ANSI SQL approach*: `SELECT MAX(salary) AS SecondHighestSalary FROM Employee WHERE salary < (SELECT MAX(salary) FROM Employee)`.

---

### 48. [LC 1484: Group Sold Products By The Date](./48-lc-1484-group-sold-products-by-the-date)

#### 📋 Problem Statement:
Find for each date the number of different products sold and their names. The sold product names for each date must be sorted lexicographically and comma-separated. Return the result table ordered by `sell_date` in ascending order.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

-- PostgreSQL:
SELECT sell_date,
       COUNT(DISTINCT product) AS num_sold,
       STRING_AGG(DISTINCT product, ',' ORDER BY product ASC) AS products
FROM Activities
GROUP BY sell_date
ORDER BY sell_date ASC;

-- MySQL:
-- SELECT sell_date,
--        COUNT(DISTINCT product) AS num_sold,
--        GROUP_CONCAT(DISTINCT product ORDER BY product ASC SEPARATOR ',') AS products
-- FROM Activities
-- GROUP BY sell_date
-- ORDER BY sell_date ASC;
```

#### 💡 Explanation & Comment:
- Use `COUNT(DISTINCT product)` to calculate the number of unique products sold per date.
- In PostgreSQL, aggregate unique product names alphabetically using `STRING_AGG(DISTINCT product, ',' ORDER BY product ASC)`.
- In MySQL, use `GROUP_CONCAT(DISTINCT product ORDER BY product ASC SEPARATOR ',')`.

---

### 49. [LC 1327: List the Products Ordered in a Period](./49-lc-1327-list-the-products-ordered-in-a-period)

#### 📋 Problem Statement:
Find the names of products that have at least 100 units ordered in February 2020 and their total ordered amount. Return the result table in any order.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT p.product_name,
       SUM(o.unit) AS unit
FROM Products AS p
JOIN Orders AS o
  ON p.product_id = o.product_id
WHERE o.order_date >= '2020-02-01'
  AND o.order_date < '2020-03-01'
GROUP BY p.product_id, p.product_name
HAVING SUM(o.unit) >= 100;
```

#### 💡 Explanation & Comment:
- `INNER JOIN` `Products` and `Orders` on `product_id`.
- Filter for orders placed in February 2020 using the sargable date comparison `order_date >= '2020-02-01' AND order_date < '2020-03-01'`.
- Group by product and apply `HAVING SUM(o.unit) >= 100` to filter for products with 100 or more total units ordered.

---

### 50. [LC 1517: Find Users With Valid E-Mails](./50-lc-1517-find-users-with-valid-e-mails)

#### 📋 Problem Statement:
Find the users who have valid emails. A valid email has a prefix name that starts with a letter and may contain letters, digits, underscores `_`, periods `.`, and dashes `-`. The domain must be strictly `@leetcode.com` in lowercase. Return the result table in any order.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

-- PostgreSQL:
SELECT user_id,
       name,
       mail
FROM Users
WHERE mail ~ '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\.com$';

-- MySQL:
-- SELECT user_id,
--        name,
--        mail
-- FROM Users
-- WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\\.com$';
```

#### 💡 Explanation & Comment:
- `^`: Matches the beginning of the string.
- `[A-Za-z]`: The first character must be a letter.
- `[A-Za-z0-9_.-]*`: Subsequent prefix characters may be letters, digits, underscores, periods, or dashes (dash placed at the end of the character class is treated literally).
- `@leetcode\.com$`: Domain must strictly match literal `@leetcode.com` at the end of the string.

---

## 🚀 Technologies Used
- **SQL (Structured Query Language)**
- Supported Databases: **MySQL**, **PostgreSQL**

---
*All solutions written and verified by [Ashfak](https://github.com/ashfak-g).*
