# 1729. Find Followers Count

**Difficulty:** Easy  
**Topic:** Sorting and Grouping  

---

## 📌 Problem Statement

Write a solution that will, for each user, return the **number of followers** (`followers_count`).

Return the result table ordered by **`user_id` in ascending order**.

---

## 📊 Database Schema

### `Followers` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `user_id` | int | User ID (part of primary key) |
| `follower_id` | int | Follower ID (part of primary key) |

> **Note:** `(user_id, follower_id)` is the primary key for this table.

---

## 📝 Example

### Input: `Followers` Table
| user_id | follower_id |
| :--- | :--- |
| 0 | 1 |
| 1 | 0 |
| 2 | 0 |
| 2 | 1 |

### Output:
| user_id | followers_count |
| :--- | :--- |
| 0 | 1 |
| 1 | 1 |
| 2 | 2 |

### Explanation:
- User `0` is followed by `{1}` -> count = **`1`**.
- User `1` is followed by `{0}` -> count = **`1`**.
- User `2` is followed by `{0, 1}` -> count = **`2`**.

---

## 💡 Solution Approach

Use **`GROUP BY`** combined with **`COUNT()`** and **`ORDER BY`**:
1. Group records by `user_id`.
2. Count the number of followers for each user using `COUNT(follower_id) AS followers_count`.
3. Order the output by `user_id` in ascending order (`ORDER BY user_id ASC`).
