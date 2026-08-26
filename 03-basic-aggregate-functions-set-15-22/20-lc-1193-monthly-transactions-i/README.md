# 1193. Monthly Transactions I

**Difficulty:** Medium  
**Topic:** Basic Aggregate Functions  

---

## 📌 Problem Statement

Write a solution to find for each **month** and **country**:
1. The total number of transactions (`trans_count`).
2. The total amount of all transactions (`trans_total_amount`).
3. The number of approved transactions (`approved_count`).
4. The total amount of approved transactions (`approved_total_amount`).

Return the result table in **any order**.

---

## 📊 Database Schema

### `Transactions` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `id` | int | Primary key (column with unique values) |
| `country` | varchar | Country code |
| `state` | enum | `'approved'` or `'declined'` |
| `amount` | int | Transaction amount |
| `trans_date` | date | Date of transaction |

---

## 📝 Example

### Input: `Transactions` Table
| id | country | state | amount | trans_date |
| :--- | :--- | :--- | :--- | :--- |
| 121 | US | approved | 1000 | 2018-12-18 |
| 122 | US | declined | 2000 | 2018-12-19 |
| 123 | US | approved | 2000 | 2019-01-01 |
| 124 | DE | approved | 2000 | 2019-01-07 |

### Output:
| month | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 2018-12 | US | 2 | 1 | 3000 | 1000 |
| 2019-01 | US | 1 | 1 | 2000 | 2000 |
| 2019-01 | DE | 1 | 1 | 2000 | 2000 |

### Explanation:
- **`2018-12`, US**: 2 total transactions (`1000 + 2000 = 3000`), 1 approved (`1000`).
- **`2019-01`, US**: 1 total transaction (`2000`), 1 approved (`2000`).
- **`2019-01`, DE**: 1 total transaction (`2000`), 1 approved (`2000`).

---

## 💡 Solution Approach

Use **`GROUP BY`** on month and country combined with conditional aggregation (`SUM`, `CASE`):
1. Extract month from `trans_date` formatted as `'YYYY-MM'`.
2. Group by `month` and `country`.
3. Compute `trans_count` using `COUNT(*)` and `trans_total_amount` using `SUM(amount)`.
4. Use `SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END)` for `approved_count`.
5. Use `SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END)` for `approved_total_amount`.
