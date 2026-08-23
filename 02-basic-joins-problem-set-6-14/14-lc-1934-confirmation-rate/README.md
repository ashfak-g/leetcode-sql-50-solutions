# 1934. Confirmation Rate

**Difficulty:** Medium  
**Topic:** Basic Joins  

---

## 📌 Problem Statement

Write a solution to find the **confirmation rate** of each user.

- The **confirmation rate** of a user is the number of `'confirmed'` messages divided by the total number of requested confirmation messages.
- The confirmation rate of a user who did not request any confirmation messages is **`0`**.
- Round the confirmation rate to **2 decimal places**.

Return the result table in **any order**.

---

## 📊 Database Schema

### `Signups` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `user_id` | int | Primary key (column with unique values) |
| `time_stamp` | datetime | Signup timestamp |

### `Confirmations` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `user_id` | int | Foreign key referencing `Signups` table |
| `time_stamp` | datetime | Confirmation request timestamp |
| `action` | enum | `'confirmed'` or `'timeout'` |

> **Note:** `(user_id, time_stamp)` is the primary key for the `Confirmations` table.

---

## 📝 Example

### Input:

#### `Signups` Table
| user_id | time_stamp |
| :--- | :--- |
| 3 | 2020-03-21 10:16:13 |
| 7 | 2020-01-04 13:57:59 |
| 2 | 2020-07-29 23:09:44 |
| 6 | 2020-12-09 10:39:37 |

#### `Confirmations` Table
| user_id | time_stamp | action |
| :--- | :--- | :--- |
| 3 | 2021-01-06 03:30:46 | timeout |
| 3 | 2021-07-14 14:00:00 | timeout |
| 7 | 2021-06-12 11:57:29 | confirmed |
| 7 | 2021-06-13 12:58:28 | confirmed |
| 7 | 2021-06-14 13:59:27 | confirmed |
| 2 | 2021-01-22 00:00:00 | confirmed |
| 2 | 2021-02-28 23:59:59 | timeout |

### Output:
| user_id | confirmation_rate |
| :--- | :--- |
| 6 | 0.00 |
| 3 | 0.00 |
| 7 | 1.00 |
| 2 | 0.50 |

### Explanation:
- **User 6**: Requested `0` confirmation messages. Rate = `0.00`.
- **User 3**: Requested `2` messages, both timed out (`0/2`). Rate = `0.00`.
- **User 7**: Requested `3` messages, all confirmed (`3/3`). Rate = `1.00`.
- **User 2**: Requested `2` messages, 1 confirmed (`1/2`). Rate = `0.50`.

---

## 💡 Solution Approach

Use a **`LEFT JOIN`** combined with **`AVG()`**, **`CASE`**, and **`ROUND()`**:
1. `LEFT JOIN` `Signups` with `Confirmations` on `user_id` to preserve all users (including those without confirmation requests).
2. Convert `'confirmed'` actions to `1.0` and `'timeout'` / missing entries to `0.0` using `CASE WHEN c.action = 'confirmed' THEN 1.0 ELSE 0.0 END`.
3. Compute the `AVG()` grouped by `user_id` and use `ROUND(..., 2)` to format to 2 decimal places.
