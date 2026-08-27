# 📌 Section 03: Basic Aggregate Functions Set (LeetCode SQL 50)

Welcome to the **Basic Aggregate Functions Set** section! This directory contains my personal solutions for problems 15 through 22 from the **LeetCode SQL 50** study plan.

This section covers core SQL aggregation techniques including `COUNT()`, `SUM()`, `AVG()`, `MIN()`, `MAX()`, `ROUND()`, conditional aggregations using `CASE`, date formatting (`YYYY-MM`), subqueries for initial/first-occurrence filtering, and multi-condition grouping with `GROUP BY` and `HAVING`.

---

## 📊 Summary of Problems

| # | Problem Name | Difficulty | Key Concepts Covered |
| :--- | :--- | :--- | :--- |
| **15** | [620. Not Boring Movies](./15-lc-620-not-boring-movies) | Easy | Modulus (`id % 2 = 1`), String filter (`!= 'boring'`), `ORDER BY` |
| **16** | [1251. Average Selling Price](./16-lc-1251-average-selling-price) | Easy | `LEFT JOIN`, `BETWEEN`, `SUM()`, `ROUND()`, `COALESCE()` |
| **17** | [1075. Project Employees I](./17-lc-1075-project-employees-i) | Easy | `JOIN`, `AVG()`, `ROUND()` |
| **18** | [1633. Percentage of Users Attended a Contest](./18-lc-1633-percentage-of-users-attended-a-contest) | Easy | Subquery, `COUNT()`, `ROUND()`, `ORDER BY` |
| **19** | [1211. Queries Quality and Percentage](./19-lc-1211-queries-quality-and-percentage) | Easy | `AVG()`, `CASE`, `ROUND()`, `WHERE IS NOT NULL` |
| **20** | [1193. Monthly Transactions I](./20-lc-1193-monthly-transactions-i) | Medium | Date formatting (`YYYY-MM`), Conditional `SUM(CASE)`, `GROUP BY` |
| **21** | [1174. Immediate Food Delivery II](./21-lc-1174-immediate-food-delivery-ii) | Medium | Subquery (`MIN(order_date)`), `AVG()`, `CASE`, `ROUND()` |
| **22** | [550. Game Play Analysis IV](./22-lc-550-game-play-analysis-iv) | Medium | Subquery (`MIN(event_date)`), `JOIN`, `COUNT(DISTINCT)`, `ROUND()` |

---

## 📝 Detailed Solutions & Explanations

### 15. [LC 620: Not Boring Movies](./15-lc-620-not-boring-movies)

#### 📋 Problem Statement:
Report the movies with an **odd-numbered ID** and a description that is **not `"boring"`**. Return the result table ordered by `rating` in **descending order**.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT id, movie, description, rating
FROM Cinema
WHERE id % 2 = 1
  AND description != 'boring'
ORDER BY rating DESC;
```

#### 💡 Explanation & Comment:
- `id % 2 = 1` filters for movies with odd IDs.
- `description != 'boring'` excludes movies classified as boring.
- `ORDER BY rating DESC` sorts the results from highest rating to lowest.

---

### 16. [LC 1251: Average Selling Price](./16-lc-1251-average-selling-price)

#### 📋 Problem Statement:
Find the **average selling price** for each product, rounded to **2 decimal places**. If a product has no sold units, assume its average selling price is `0`.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT Prices.product_id,
       COALESCE(
         ROUND(
           SUM(units * price)::numeric / SUM(units),
           2
         ),
         0
       ) AS average_price
FROM Prices
LEFT JOIN UnitsSold
  ON Prices.product_id = UnitsSold.product_id
 AND UnitsSold.purchase_date BETWEEN Prices.start_date AND Prices.end_date
GROUP BY Prices.product_id;
```

#### 💡 Explanation & Comment:
- Perform a `LEFT JOIN` between `Prices` and `UnitsSold` on `product_id` and date range (`BETWEEN`).
- Group by `product_id` and compute `SUM(units * price) / SUM(units)`.
- Use `ROUND(..., 2)` and `COALESCE(..., 0)` to handle products with zero units sold.

---

### 17. [LC 1075: Project Employees I](./17-lc-1075-project-employees-i)

#### 📋 Problem Statement:
Report the **average experience years** of all employees for each project, rounded to **2 decimal places**.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT p.project_id,
       ROUND(AVG(e.experience_years), 2) AS average_years
FROM Project AS p
JOIN Employee AS e
  ON p.employee_id = e.employee_id
GROUP BY p.project_id;
```

#### 💡 Explanation & Comment:
- `JOIN` `Project` and `Employee` tables on `employee_id`.
- Group records by `project_id`.
- Calculate `ROUND(AVG(e.experience_years), 2)` for each project group.

---

### 18. [LC 1633: Percentage of Users Attended a Contest](./18-lc-1633-percentage-of-users-attended-a-contest)

#### 📋 Problem Statement:
Find the **percentage of users** registered in each contest, rounded to **2 decimal places**. Order by `percentage DESC` and `contest_id ASC`.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT contest_id,
       ROUND(COUNT(user_id) * 100.0 / (SELECT COUNT(*) FROM Users), 2) AS percentage
FROM Register
GROUP BY contest_id
ORDER BY percentage DESC, contest_id ASC;
```

#### 💡 Explanation & Comment:
- Group records by `contest_id` in the `Register` table.
- Divide the count of registered users for each contest by the total user count from `(SELECT COUNT(*) FROM Users)`.
- Multiply by `100.0` and round to 2 decimal places using `ROUND(..., 2)`.

---

### 19. [LC 1211: Queries Quality and Percentage](./19-lc-1211-queries-quality-and-percentage)

#### 📋 Problem Statement:
Find each `query_name`, its **`quality`** (average of `rating / position`), and its **`poor_query_percentage`** (percentage of queries with `rating < 3`), rounded to **2 decimal places**.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT query_name,
       ROUND(AVG(rating * 1.0 / position), 2) AS quality,
       ROUND(AVG(CASE WHEN rating < 3 THEN 1.0 ELSE 0.0 END) * 100, 2) AS poor_query_percentage
FROM Queries
WHERE query_name IS NOT NULL
GROUP BY query_name;
```

#### 💡 Explanation & Comment:
- Filter out missing query names with `WHERE query_name IS NOT NULL`.
- Group by `query_name`.
- Calculate `quality` as `ROUND(AVG(rating * 1.0 / position), 2)`.
- Calculate `poor_query_percentage` using `ROUND(AVG(CASE WHEN rating < 3 THEN 1.0 ELSE 0.0 END) * 100, 2)`.

---

### 20. [LC 1193: Monthly Transactions I](./20-lc-1193-monthly-transactions-i)

#### 📋 Problem Statement:
Find for each month and country: total transaction count, total amount, approved transaction count, and approved total amount.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT TO_CHAR(trans_date, 'YYYY-MM') AS month,
       country,
       COUNT(*) AS trans_count,
       SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
       SUM(amount) AS trans_total_amount,
       SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY TO_CHAR(trans_date, 'YYYY-MM'), country;
```

#### 💡 Explanation & Comment:
- Extract month formatted as `'YYYY-MM'` from `trans_date`.
- Group by `month` and `country`.
- Use `COUNT(*)` for total transactions and `SUM(amount)` for total amount.
- Use `SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END)` for approved count and `SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END)` for approved amount.

---

### 21. [LC 1174: Immediate Food Delivery II](./21-lc-1174-immediate-food-delivery-ii)

#### 📋 Problem Statement:
Find the **percentage of immediate orders** in the **first orders of all customers**, rounded to **2 decimal places**.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT ROUND(
         AVG(CASE WHEN order_date = customer_pref_delivery_date THEN 1.0 ELSE 0.0 END) * 100,
         2
       ) AS immediate_percentage
FROM Delivery
WHERE (customer_id, order_date) IN (
    SELECT customer_id, MIN(order_date)
    FROM Delivery
    GROUP BY customer_id
);
```

#### 💡 Explanation & Comment:
- Use a subquery `SELECT customer_id, MIN(order_date) FROM Delivery GROUP BY customer_id` to filter for only first orders.
- Map immediate orders (`order_date = customer_pref_delivery_date`) to `1.0` and scheduled orders to `0.0` using `CASE`.
- Compute `ROUND(AVG(...) * 100, 2)` to calculate the final percentage.

---

### 22. [LC 550: Game Play Analysis IV](./22-lc-550-game-play-analysis-iv)

#### 📋 Problem Statement:
Report the **fraction of players that logged in again on the day after the day they first logged in**, rounded to **2 decimal places**.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT ROUND(
         COUNT(a.player_id) * 1.0 / (SELECT COUNT(DISTINCT player_id) FROM Activity),
         2
       ) AS fraction
FROM Activity AS a
JOIN (
    SELECT player_id,
           MIN(event_date) AS first_date
    FROM Activity
    GROUP BY player_id
) AS f
  ON a.player_id = f.player_id
 AND a.event_date = f.first_date + 1;
```

#### 💡 Explanation & Comment:
- Create a subquery `f` to find each player's initial login date (`first_date`).
- Join `Activity a` with `f` matching `a.event_date = f.first_date + 1` to find consecutive day logins.
- Divide this count by total distinct players `(SELECT COUNT(DISTINCT player_id) FROM Activity)` and round to 2 decimal places.

---

## 🚀 Technologies Used
- **SQL (Structured Query Language)**
- Supported Databases: **MySQL**, **PostgreSQL**

---
*All solutions written and verified by [Ashfak](https://github.com/ashfak-g).*
