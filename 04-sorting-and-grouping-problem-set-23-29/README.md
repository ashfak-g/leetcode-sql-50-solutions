# 📌 Section 04: Sorting and Grouping Problem Set (LeetCode SQL 50)

Welcome to the **Sorting and Grouping Problem Set** section! This directory contains my personal solutions for problems 23 through 29 from the **LeetCode SQL 50** study plan.

This section focuses on advanced grouping and sorting techniques, including deduplication with `COUNT(DISTINCT)`, filtering grouped data with `HAVING`, subqueries combined with `MIN()` and `MAX()`, date range filtering (`BETWEEN`), and relational set division (finding records that match all items in another table).

---

## 📊 Summary of Problems

| # | Problem Name | Difficulty | Key Concepts Covered |
| :--- | :--- | :--- | :--- |
| **23** | [2356. Number of Unique Subjects Taught by Each Teacher](./23-lc-2356-number-of-unique-subjects-taught-by-each-teacher) | Easy | `GROUP BY`, `COUNT(DISTINCT)` |
| **24** | [1141. User Activity for the Past 30 Days I](./24-lc-1141-user-activity-for-the-past-30-days-i) | Easy | `WHERE BETWEEN`, `GROUP BY`, `COUNT(DISTINCT)` |
| **25** | [1070. Product Sales Analysis III](./25-lc-1070-product-sales-analysis-iii) | Medium | Subquery (`MIN(year)`), `JOIN` |
| **26** | [596. Classes With at Least 5 Students](./26-lc-596-classes-with-at-least-5-students) | Easy | `GROUP BY`, `HAVING COUNT() >= 5` |
| **27** | [1729. Find Followers Count](./27-lc-1729-find-followers-count) | Easy | `GROUP BY`, `COUNT()`, `ORDER BY ASC` |
| **28** | [619. Biggest Single Number](./28-lc-619-biggest-single-number) | Easy | Subquery (`HAVING COUNT(*) = 1`), `MAX()` |
| **29** | [1045. Customers Who Bought All Products](./29-lc-1045-customers-who-bought-all-products) | Medium | `GROUP BY`, `HAVING COUNT(DISTINCT) = (SELECT COUNT(*))` |

---

## 📝 Detailed Solutions & Explanations

### 23. [LC 2356: Number of Unique Subjects Taught by Each Teacher](./23-lc-2356-number-of-unique-subjects-taught-by-each-teacher)

#### 📋 Problem Statement:
Calculate the number of **unique subjects** each teacher teaches in the university (`cnt`).

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT teacher_id,
       COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id;
```

#### 💡 Explanation & Comment:
- Group records by `teacher_id`.
- Use `COUNT(DISTINCT subject_id)` to count unique subjects taught by each teacher, ignoring duplicate department entries for the same subject.

---

### 24. [LC 1141: User Activity for the Past 30 Days I](./24-lc-1141-user-activity-for-the-past-30-days-i)

#### 📋 Problem Statement:
Find the **daily active user count** (`active_users`) for a period of **30 days ending 2019-07-27 inclusively** (from `2019-06-28` to `2019-07-27`).

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT activity_date AS day,
       COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date;
```

#### 💡 Explanation & Comment:
- Filter activity records within the 30-day window (`BETWEEN '2019-06-28' AND '2019-07-27'`).
- Group by `activity_date` aliased as `day`.
- Count unique active users per day using `COUNT(DISTINCT user_id)`.

---

### 25. [LC 1070: Product Sales Analysis III](./25-lc-1070-product-sales-analysis-iii)

#### 📋 Problem Statement:
Find all sales entries that occurred in the **first year** each product was sold. Report `product_id`, `first_year`, `quantity`, and `price`.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT s.product_id,
       f.first_year,
       s.quantity,
       s.price
FROM Sales AS s
JOIN (
    SELECT product_id,
           MIN(year) AS first_year
    FROM Sales
    GROUP BY product_id
) AS f
  ON s.product_id = f.product_id
 AND s.year = f.first_year;
```

#### 💡 Explanation & Comment:
- Create a subquery `f` that finds the minimum (earliest) sales year for each product (`MIN(year) AS first_year`).
- Join `Sales s` with subquery `f` on `product_id` and `year = first_year` to fetch all transaction details from that initial year.

---

### 26. [LC 596: Classes With at Least 5 Students](./26-lc-596-classes-with-at-least-5-students)

#### 📋 Problem Statement:
Find all classes that have at least **five students**.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;
```

#### 💡 Explanation & Comment:
- Group records by `class`.
- Use `HAVING COUNT(student) >= 5` to filter for classes that have 5 or more enrolled students.

---

### 27. [LC 1729: Find Followers Count](./27-lc-1729-find-followers-count)

#### 📋 Problem Statement:
For each user, return the **number of followers** (`followers_count`), ordered by `user_id` in **ascending order**.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT user_id,
       COUNT(follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id ASC;
```

#### 💡 Explanation & Comment:
- Group records by `user_id`.
- Count followers using `COUNT(follower_id) AS followers_count`.
- Sort the final result by `user_id ASC`.

---

### 28. [LC 619: Biggest Single Number](./28-lc-619-biggest-single-number)

#### 📋 Problem Statement:
Find the **largest single number** in the `MyNumbers` table. A single number is a number that appears **only once**. If no single number exists, return `null`.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT MAX(num) AS num
FROM (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(*) = 1
) AS single_numbers;
```

#### 💡 Explanation & Comment:
- Inner Subquery: Group numbers and filter for those appearing exactly once using `HAVING COUNT(*) = 1`.
- Outer Query: Compute `MAX(num)` over the single numbers found. If no single numbers exist, `MAX()` automatically returns `null`.

---

### 29. [LC 1045: Customers Who Bought All Products](./29-lc-1045-customers-who-bought-all-products)

#### 📋 Problem Statement:
Find customer IDs from the `Customer` table that bought **all the products** listed in the `Product` table.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (
    SELECT COUNT(*)
    FROM Product
);
```

#### 💡 Explanation & Comment:
- Group customer purchases by `customer_id`.
- Use `HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product)` to select customers whose unique product count equals the total count of products available in the `Product` table.

---

## 🚀 Technologies Used
- **SQL (Structured Query Language)**
- Supported Databases: **MySQL**, **PostgreSQL**

---
*All solutions written and verified by [Ashfak](https://github.com/ashfak-g).*
