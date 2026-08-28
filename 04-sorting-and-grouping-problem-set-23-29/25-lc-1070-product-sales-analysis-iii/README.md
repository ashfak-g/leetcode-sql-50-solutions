# 1070. Product Sales Analysis III

**Difficulty:** Medium  
**Topic:** Sorting and Grouping  

---

## 📌 Problem Statement

Write a solution to find all sales entries that occurred in the **first year** each product was sold.

Return a table with the columns: **`product_id`**, **`first_year`**, **`quantity`**, and **`price`**.

Return the result table in **any order**.

---

## 📊 Database Schema

### `Sales` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `sale_id` | int | Primary key (part of primary key) |
| `product_id` | int | ID of the product |
| `year` | int | Year of sale (part of primary key) |
| `quantity` | int | Quantity sold |
| `price` | int | Price per unit |

---

## 📝 Example

### Input: `Sales` Table
| sale_id | product_id | year | quantity | price |
| :--- | :--- | :--- | :--- | :--- |
| 1 | 100 | 2008 | 10 | 5000 |
| 2 | 100 | 2009 | 12 | 5000 |
| 7 | 200 | 2011 | 15 | 9000 |

### Output:
| product_id | first_year | quantity | price |
| :--- | :--- | :--- | :--- |
| 100 | 2008 | 10 | 5000 |
| 200 | 2011 | 15 | 9000 |

### Explanation:
- **Product 100**: First year sold is `2008` (`quantity = 10`, `price = 5000`).
- **Product 200**: First year sold is `2011` (`quantity = 15`, `price = 9000`).

---

## 💡 Solution Approach

Use a Subquery to find the minimum (earliest) year for each product combined with a **`JOIN`**:
1. Subquery `SELECT product_id, MIN(year) AS first_year FROM Sales GROUP BY product_id` finds the earliest sales year for every product.
2. Join `Sales s` with the subquery `f` on `s.product_id = f.product_id` AND `s.year = f.first_year`.
3. Select `product_id`, `first_year`, `quantity`, and `price`.
