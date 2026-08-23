# 1068. Product Sales Analysis I

**Difficulty:** Easy  
**Topic:** Basic Joins  

---

## 📌 Problem Statement

Write a solution to report the **`product_name`**, **`year`**, and **`price`** for each `sale_id` in the `Sales` table.

Return the result table in **any order**.

---

## 📊 Database Schema

### `Sales` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `sale_id` | int | Sale ID (part of primary key) |
| `product_id` | int | Foreign key referencing `Product` table |
| `year` | int | Year of sale (part of primary key) |
| `quantity` | int | Quantity sold |
| `price` | int | Price per unit |

### `Product` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `product_id` | int | Primary key (column with unique values) |
| `product_name` | varchar | Name of the product |

---

## 📝 Example

### Input:

#### `Sales` Table
| sale_id | product_id | year | quantity | price |
| :--- | :--- | :--- | :--- | :--- |
| 1 | 100 | 2008 | 10 | 5000 |
| 2 | 100 | 2009 | 12 | 5000 |
| 7 | 200 | 2011 | 15 | 9000 |

#### `Product` Table
| product_id | product_name |
| :--- | :--- |
| 100 | Nokia |
| 200 | Apple |
| 300 | Samsung |

### Output:
| product_name | year | price |
| :--- | :--- | :--- |
| Nokia | 2008 | 5000 |
| Nokia | 2009 | 5000 |
| Apple | 2011 | 9000 |

### Explanation:
- **`sale_id = 1`**: Product `100` (`Nokia`) sold in `2008` for `5000`.
- **`sale_id = 2`**: Product `100` (`Nokia`) sold in `2009` for `5000`.
- **`sale_id = 7`**: Product `200` (`Apple`) sold in `2011` for `9000`.

---

## 💡 Solution Approach

Use a **`LEFT JOIN`** (or **`JOIN`**) between the `Sales` table and the `Product` table on `Sales.product_id = Product.product_id`:
- Connecting the two tables on `product_id` allows us to fetch the `product_name` matching each sale record.
- We select `product_name`, `year`, and `price` from the joined result.
