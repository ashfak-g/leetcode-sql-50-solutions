# 1327. List the Products Ordered in a Period

**Difficulty:** Easy  
**Topic:** Advanced String Functions / Regex / Clause  

---

## 📌 Problem Statement

Write a solution to get the names of products that have **at least 100 units** ordered in **February 2020** and their total amount.

Return the result table in **any order**.

---

## 📊 Database Schema

### `Products` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `product_id` | int | Primary key (column with unique values) |
| `product_name` | varchar | Name of the product |
| `product_category` | varchar | Category of the product |

### `Orders` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `product_id` | int | Foreign key referencing `Products(product_id)` |
| `order_date` | date | Date of the order |
| `unit` | int | Number of units ordered |

---

## 📝 Example

### Input:

#### `Products` Table
| product_id | product_name | product_category |
| :--- | :--- | :--- |
| 1 | Leetcode Solutions | Book |
| 2 | Jewels of Stringology | Book |
| 3 | HP | Laptop |
| 4 | Lenovo | Laptop |
| 5 | Leetcode Kit | T-shirt |

#### `Orders` Table
| product_id | order_date | unit |
| :--- | :--- | :--- |
| 1 | 2020-02-05 | 60 |
| 1 | 2020-02-10 | 70 |
| 2 | 2020-01-18 | 30 |
| 2 | 2020-02-11 | 80 |
| 3 | 2020-02-17 | 2 |
| 3 | 2020-02-24 | 3 |
| 4 | 2020-03-01 | 20 |
| 4 | 2020-03-04 | 30 |
| 4 | 2020-03-04 | 60 |
| 5 | 2020-02-25 | 50 |
| 5 | 2020-02-27 | 50 |
| 5 | 2020-03-01 | 50 |

### Output:

| product_name | unit |
| :--- | :--- |
| Leetcode Solutions | 130 |
| Leetcode Kit | 100 |

### Explanation:
- **`Leetcode Solutions`** (`product_id = 1`): Total February orders = `60 + 70 = 130` (>= 100) -> ✅
- **`Jewels of Stringology`** (`product_id = 2`): Total February orders = `80` (< 100) -> ❌
- **`HP`** (`product_id = 3`): Total February orders = `2 + 3 = 5` (< 100) -> ❌
- **`Lenovo`** (`product_id = 4`): No orders in February 2020 -> ❌
- **`Leetcode Kit`** (`product_id = 5`): Total February orders = `50 + 50 = 100` (>= 100, March order excluded) -> ✅

---

## 💡 Solution Approaches

### Approach 1: Date Range Filtering with `HAVING` (Recommended)

1. **Join Tables**:
   - `INNER JOIN` `Products` and `Orders` on `product_id`.
2. **Filter February 2020 Orders**:
   - Use sargable boundary comparison: `order_date >= '2020-02-01' AND order_date < '2020-03-01'`.
   - Alternatively: `order_date BETWEEN '2020-02-01' AND '2020-02-29'`.
3. **Aggregate & Filter Threshold**:
   - `GROUP BY p.product_id, p.product_name`.
   - Apply `HAVING SUM(o.unit) >= 100` to retain only products with 100+ units.

```sql
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
