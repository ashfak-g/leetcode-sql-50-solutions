# 180. Consecutive Numbers

**Difficulty:** Medium  
**Topic:** Advanced Select and Joins  

---

## 📌 Problem Statement

Write a solution to find all numbers (**`ConsecutiveNums`**) that appear **at least three times consecutively** in the `Logs` table.

Return the result table in **any order**.

---

## 📊 Database Schema

### `Logs` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `id` | int | Primary key (autoincrement starting from 1) |
| `num` | varchar | Number logged |

---

## 📝 Example

### Input: `Logs` Table
| id | num |
| :--- | :--- |
| 1 | 1 |
| 2 | 1 |
| 3 | 1 |
| 4 | 2 |
| 5 | 1 |
| 6 | 2 |
| 7 | 2 |

### Output:
| ConsecutiveNums |
| :--- |
| 1 |

### Explanation:
- `1` appears at consecutive IDs `1`, `2`, `3` -> Included (**`1`**).
- `2` appears at IDs `6`, `7` (only 2 consecutive times) -> Excluded.

---

## 💡 Solution Approach

Use **`SELF JOINS`** across 3 table aliases (`l1`, `l2`, `l3`):
1. Join `Logs l1` with `Logs l2` on `l2.id = l1.id + 1`.
2. Join `Logs l2` with `Logs l3` on `l3.id = l2.id + 1`.
3. Filter rows where `l1.num = l2.num AND l2.num = l3.num`.
4. Use `SELECT DISTINCT l1.num AS ConsecutiveNums` to deduplicate numbers that appear 3+ consecutive times.
