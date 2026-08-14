# 📌 Section 01: Select Problem Set (LeetCode SQL 50)

Welcome to the **Select Problem Set** section! This directory contains my personal solutions for the first 5 foundational SQL problems from the **LeetCode SQL 50** study plan. 

These problems focus on essential SQL concepts such as basic `SELECT` projections, filtering with `WHERE`, handling `NULL` values, logical operators (`AND`, `OR`), string length evaluation (`LENGTH`), deduplication (`DISTINCT`), and sorting (`ORDER BY`).

---

## 📊 Summary of Problems

| # | Problem Name | Difficulty | Key Concepts Covered |
| :--- | :--- | :--- | :--- |
| **01** | [1757. Recyclable and Low Fat Products](./01.%20LC%201757.%20Recyclable%20and%20Low%20Fat%20Products) | Easy | `WHERE`, `AND` filtering |
| **02** | [584. Find Customer Referee](./02.%20LC%20584.%20Find%20Customer%20Referee) | Easy | `IS NULL`, `OR`, handling `NULL` |
| **03** | [595. Big Countries](./03.%20LC%20595.%20Big%20Countries) | Easy | `WHERE`, `OR` comparison |
| **04** | [1148. Article Views I](./04.%20LC%201148.%20Article%20Views%20I) | Easy | Self-comparison (`author_id = viewer_id`), `DISTINCT`, `ORDER BY` |
| **05** | [1683. Invalid Tweets](./05.%20LC%201683.%20Invalid%20Tweets) | Easy | String function `LENGTH()` |

---

## 📝 Detailed Solutions & Explanations

### 1. [LC 1757: Recyclable and Low Fat Products](./01.%20LC%201757.%20Recyclable%20and%20Low%20Fat%20Products)

#### 📋 Problem Statement:
Find the IDs of products that are both **low fat** (`low_fats = 'Y'`) and **recyclable** (`recyclable = 'Y'`).

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT product_id
FROM Products
WHERE low_fats = 'Y'
  AND recyclable = 'Y';
```

#### 💡 Explanation & Comment:
- We select the `product_id` column from the `Products` table.
- The `WHERE` clause filters rows where both conditions are satisfied at the same time using the `AND` operator.
- Only products marked as `'Y'` for both attributes are included in the result.

---

### 2. [LC 584: Find Customer Referee](./02.%20LC%20584.%20Find%20Customer%20Referee)

#### 📋 Problem Statement:
Find the names of customers who are **not referred by the customer with `id = 2`** (including customers who were not referred by anyone at all).

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT name
FROM Customer
WHERE referee_id != 2
   OR referee_id IS NULL;
```

#### 💡 Explanation & Comment:
- In SQL, missing values (`NULL`) do not evaluate to `TRUE` or `FALSE` when using standard comparison operators like `!= 2`.
- Therefore, to include customers without a referee, we must explicitly add `OR referee_id IS NULL` alongside `referee_id != 2`.

---

### 3. [LC 595: Big Countries](./03.%20LC%20595.%20Big%20Countries)

#### 📋 Problem Statement:
Find the **name**, **population**, and **area** of all big countries. A country is considered big if:
1. It has an area of at least **3,000,000 km²**, OR
2. It has a population of at least **25,000,000**.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT name, population, area
FROM World
WHERE area >= 3000000
   OR population >= 25000000;
```

#### 💡 Explanation & Comment:
- We query the `name`, `population`, and `area` columns from the `World` table.
- Using the `OR` logical operator ensures that if a country satisfies **either** the area threshold (`>= 3000000`) or the population threshold (`>= 25000000`), it will be selected in the final output.

---

### 4. [LC 1148: Article Views I](./04.%20LC%201148.%20Article%20Views%20I)

#### 📋 Problem Statement:
Find all authors who viewed at least one of their own articles. Return the result table sorted by `id` in **ascending order**.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY id ASC;
```

#### 💡 Explanation & Comment:
- When an author views their own article, the `author_id` equals the `viewer_id`.
- An author might view their own articles multiple times, so we use `DISTINCT` to keep unique author IDs and alias the column as `id`.
- Finally, `ORDER BY id ASC` sorts the output IDs in ascending order as required by the problem.

---

### 5. [LC 1683: Invalid Tweets](./05.%20LC%201683.%20Invalid%20Tweets)

#### 📋 Problem Statement:
Find the IDs of tweets that are **invalid**. A tweet is invalid if the number of characters in the tweet's content is **strictly greater than 15**.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;
```

#### 💡 Explanation & Comment:
- We use the built-in SQL function `LENGTH(content)` to count the total number of characters in each tweet.
- The condition `WHERE LENGTH(content) > 15` filters for tweets whose character count exceeds 15.

---

## 🚀 Technologies Used
- **SQL (Structured Query Language)**
- Supported Databases: **MySQL**, **PostgreSQL**

---
*All solutions written and verified by [Ashfak](https://github.com/ashfak-g).*
