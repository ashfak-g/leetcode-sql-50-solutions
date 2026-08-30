# 1045. Customers Who Bought All Products

**Difficulty:** Medium  
**Topic:** Sorting and Grouping  

---

## 📌 Problem Statement

Write a solution to report the `customer_id`s from the `Customer` table that bought **all the products** listed in the `Product` table.

Return the result table in **any order**.

---

## 📊 Database Schema

### `Customer` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `customer_id` | int | ID of the customer |
| `product_key` | int | Foreign key referencing `Product` table |

### `Product` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `product_key` | int | Primary key (column with unique values) |

---

## 📝 Example

### Input:

#### `Customer` Table
| customer_id | product_key |
| :--- | :--- |
| 1 | 5 |
| 2 | 6 |
| 3 | 5 |
| 3 | 6 |
| 1 | 6 |

#### `Product` Table
| product_key |
| :--- |
| 5 |
| 6 |

### Output:
| customer_id |
| :--- |
| 1 |
| 3 |

### Explanation:
- Total unique products in `Product` table = `2` (`5`, `6`).
- **Customer 1**: Bought products `5` and `6` (`count = 2`) -> Bought all products.
- **Customer 2**: Bought product `6` (`count = 1`) -> Excluded.
- **Customer 3**: Bought products `5` and `6` (`count = 2`) -> Bought all products.

---

## 💡 Solution Approach

Use **`GROUP BY`** and **`HAVING COUNT(DISTINCT ...)`** with a subquery:
1. Subquery `(SELECT COUNT(*) FROM Product)` counts the total number of distinct products available.
2. Group rows by `customer_id`.
3. Filter using `HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product)` to select customers whose distinct product purchase count equals the total product count.
