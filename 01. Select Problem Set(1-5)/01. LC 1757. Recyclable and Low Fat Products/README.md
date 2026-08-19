# 1757. Recyclable and Low Fat Products

**Difficulty:** Easy  
**Topic:** Select  

---

## 📌 Problem Statement

Write a solution to find the IDs of products that are both **low fat** and **recyclable**.

Return the result table in **any order**.

---

## 📊 Database Schema

### `Products` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `product_id` | int | Primary key (unique value) |
| `low_fats` | enum | `'Y'` if low fat, `'N'` otherwise |
| `recyclable` | enum | `'Y'` if recyclable, `'N'` otherwise |

---

## 📝 Example

### Input: `Products` Table
| product_id | low_fats | recyclable |
| :--- | :--- | :--- |
| 0 | Y | N |
| 1 | Y | Y |
| 2 | N | Y |
| 3 | Y | Y |
| 4 | N | N |

### Output:
| product_id |
| :--- |
| 1 |
| 3 |

### Explanation:
Only products **1** and **3** are both low fat (`low_fats = 'Y'`) and recyclable (`recyclable = 'Y'`).

---

## 💡 Solution Approach

Filter records from the `Products` table where both conditions are satisfied simultaneously:
- `low_fats = 'Y'`
- `recyclable = 'Y'`
