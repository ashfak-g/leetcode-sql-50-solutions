# 610. Triangle Judgement

**Difficulty:** Easy  
**Topic:** Advanced Select and Joins  

---

## 📌 Problem Statement

Write a solution to report for every three line segments (`x`, `y`, `z`) whether they can form a **triangle** (`'Yes'` or `'No'`).

- According to the **Triangle Inequality Theorem**, three lengths can form a triangle if and only if the sum of any two sides is strictly greater than the third side:
  - `x + y > z`
  - `x + z > y`
  - `y + z > x`

Return the result table in **any order**.

---

## 📊 Database Schema

### `Triangle` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `x` | int | Length of segment x (part of primary key) |
| `y` | int | Length of segment y (part of primary key) |
| `z` | int | Length of segment z (part of primary key) |

---

## 📝 Example

### Input: `Triangle` Table
| x | y | z |
| :--- | :--- | :--- |
| 13 | 15 | 30 |
| 10 | 20 | 15 |

### Output:
| x | y | z | triangle |
| :--- | :--- | :--- | :--- |
| 13 | 15 | 30 | No |
| 10 | 20 | 15 | Yes |

### Explanation:
- **Row 1**: `13 + 15 = 28`, which is NOT greater than `30` -> Output `'No'`.
- **Row 2**: `10 + 20 > 15`, `10 + 15 > 20`, `20 + 15 > 10` -> Output `'Yes'`.

---

## 💡 Solution Approach

Use conditional logic with **`CASE WHEN`**:
1. Check if `x + y > z AND x + z > y AND y + z > x`.
2. If true, return `'Yes'`, otherwise return `'No'`.
