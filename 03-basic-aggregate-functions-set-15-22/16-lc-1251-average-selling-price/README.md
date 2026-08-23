# 1251. Average Selling Price

**Difficulty:** Easy  
**Topic:** Basic Aggregate Functions  

---

## 📌 Problem Statement

Write a solution to find the **average selling price** for each product. 

- `average_price` should be rounded to **2 decimal places**.
- If a product does not have any sold units, its average selling price is assumed to be **`0`**.

Return the result table in **any order**.

---

## 📊 Database Schema

### `Prices` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `product_id` | int | Product ID (part of primary key) |
| `start_date` | date | Start date of price period (part of primary key) |
| `end_date` | date | End date of price period (part of primary key) |
| `price` | int | Price per unit during the period |

### `UnitsSold` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `product_id` | int | Product ID |
| `purchase_date` | date | Date of purchase |
| `units` | int | Number of units sold |

---

## 📝 Example

### Input:

#### `Prices` Table
| product_id | start_date | end_date | price |
| :--- | :--- | :--- | :--- |
| 1 | 2019-02-17 | 2019-02-28 | 5 |
| 1 | 2019-03-01 | 2019-03-22 | 20 |
| 2 | 2019-02-01 | 2019-02-20 | 15 |
| 2 | 2019-02-21 | 2019-03-31 | 30 |

#### `UnitsSold` Table
| product_id | purchase_date | units |
| :--- | :--- | :--- |
| 1 | 2019-02-25 | 100 |
| 1 | 2019-03-01 | 15 |
| 2 | 2019-02-10 | 200 |
| 2 | 2019-03-22 | 30 |

### Output:
| product_id | average_price |
| :--- | :--- |
| 1 | 6.96 |
| 2 | 16.96 |

### Explanation:
- **Product 1**: `((100 * 5) + (15 * 20)) / (100 + 15) = (500 + 300) / 115 = 800 / 115 = 6.96`
- **Product 2**: `((200 * 15) + (30 * 30)) / (200 + 30) = (3000 + 900) / 230 = 3900 / 230 = 16.96`

---

## 💡 Solution Approach

Use a **`LEFT JOIN`** matching date ranges combined with aggregation:
1. Perform a `LEFT JOIN` between `Prices` and `UnitsSold` on `product_id` and `purchase_date BETWEEN start_date AND end_date`.
2. Group by `Prices.product_id`.
3. Compute average price using `SUM(units * price) / SUM(units)`.
4. Wrap with `ROUND(..., 2)` and `COALESCE(..., 0)` to handle products with zero units sold.
