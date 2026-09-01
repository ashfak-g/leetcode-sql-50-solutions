# 1164. Product Price at a Given Date

**Difficulty:** Medium  
**Topic:** Advanced Select and Joins  

---

## 📌 Problem Statement

Write a solution to find the **prices of all products on the date `2019-08-16`**.

- Initially, all products have a default price of **`10`**.
- Each row in the `Products` table represents a price update to `new_price` on `change_date`.
- On `2019-08-16`, a product's price is determined by the **latest `change_date` on or before `2019-08-16`**. If a product had no price changes on or before that date, its price is `10`.

Return the result table in **any order**.

---

## 📊 Database Schema

### `Products` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `product_id` | int | Product ID (part of primary key) |
| `new_price` | int | New price after change |
| `change_date` | date | Date price change took effect (part of primary key) |

---

## 📝 Example

### Input: `Products` Table
| product_id | new_price | change_date |
| :--- | :--- | :--- |
| 1 | 20 | 2019-08-14 |
| 2 | 50 | 2019-08-14 |
| 1 | 30 | 2019-08-15 |
| 1 | 35 | 2019-08-16 |
| 2 | 65 | 2019-08-17 |
| 3 | 20 | 2019-08-18 |

### Output:
| product_id | price |
| :--- | :--- |
| 2 | 50 |
| 1 | 35 |
| 3 | 10 |

### Explanation:
- **Product 1**: Latest change on/before `2019-08-16` was on `2019-08-16` (`price = 35`).
- **Product 2**: Latest change on/before `2019-08-16` was on `2019-08-14` (`price = 50`). Change on `2019-08-17` is after target date.
- **Product 3**: First price change was on `2019-08-18` (after target date). So price remains default **`10`**.

---

## 💡 Solution Approach

Use **`LEFT JOIN`** with a Subquery + **`COALESCE()`**:
1. Find unique products (`SELECT DISTINCT product_id FROM Products`).
2. Find the latest price change on or before `2019-08-16` for each product using `WHERE (product_id, change_date) IN (SELECT product_id, MAX(change_date) FROM Products WHERE change_date <= '2019-08-16' GROUP BY product_id)`.
3. Perform a `LEFT JOIN` between unique products and the latest price subquery.
4. Use `COALESCE(x.new_price, 10) AS price` to assign `10` to products with no price changes on or before target date.
