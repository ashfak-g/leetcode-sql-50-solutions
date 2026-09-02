# 1907. Count Salary Categories

**Difficulty:** Medium  
**Topic:** Advanced Select and Joins  

---

## 📌 Problem Statement

Write a solution to calculate the number of bank accounts for each of the following salary categories:

- **`"Low Salary"`**: Income strictly less than `$20000` (`income < 20000`).
- **`"Average Salary"`**: Income in the inclusive range `[$20000, $50000]` (`income BETWEEN 20000 AND 50000`).
- **`"High Salary"`**: Income strictly greater than `$50000` (`income > 50000`).

The result table **must contain all three categories**. If there are no accounts in a category, return `0` for that category.

Return the result table in **any order**.

---

## 📊 Database Schema

### `Accounts` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `account_id` | int | Primary key (column with unique values) |
| `income` | int | Monthly income of bank account |

---

## 📝 Example

### Input: `Accounts` Table
| account_id | income |
| :--- | :--- |
| 3 | 108939 |
| 2 | 12747 |
| 8 | 87709 |
| 6 | 91796 |

### Output:
| category | accounts_count |
| :--- | :--- |
| Low Salary | 1 |
| Average Salary | 0 |
| High Salary | 3 |

### Explanation:
- **Low Salary**: Account `2` (`12747 < 20000`) -> **`1`**.
- **Average Salary**: No accounts -> **`0`**.
- **High Salary**: Accounts `3`, `8`, `6` -> **`3`**.

---

## 💡 Solution Approach

Use **`UNION ALL`** to force all 3 categories into the output:
1. Query 1: Count accounts where `income < 20000` and label as `'Low Salary'`.
2. Query 2: Count accounts where `income BETWEEN 20000 AND 50000` and label as `'Average Salary'`.
3. Query 3: Count accounts where `income > 50000` and label as `'High Salary'`.
4. Combine all three queries using `UNION ALL`. `COUNT(CASE WHEN ... THEN 1 END)` automatically returns `0` if no rows match.
