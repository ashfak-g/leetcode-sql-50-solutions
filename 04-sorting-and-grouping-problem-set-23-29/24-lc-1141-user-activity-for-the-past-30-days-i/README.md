# 1141. User Activity for the Past 30 Days I

**Difficulty:** Easy  
**Topic:** Sorting and Grouping  

---

## 📌 Problem Statement

Write a solution to find the **daily active user count** (`active_users`) for a period of **30 days ending 2019-07-27 inclusively** (from `2019-06-28` to `2019-07-27`).

- A user is considered **active** on a day if they performed at least one activity on that day.

Return the result table in **any order**.

---

## 📊 Database Schema

### `Activity` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `user_id` | int | ID of the user |
| `session_id` | int | ID of the session |
| `activity_date` | date | Date of the activity |
| `activity_type` | enum | `'open_session'`, `'end_session'`, `'scroll_down'`, `'send_message'` |

---

## 📝 Example

### Input: `Activity` Table
| user_id | session_id | activity_date | activity_type |
| :--- | :--- | :--- | :--- |
| 1 | 1 | 2019-07-20 | open_session |
| 1 | 1 | 2019-07-20 | scroll_down |
| 1 | 1 | 2019-07-20 | end_session |
| 2 | 4 | 2019-07-20 | open_session |
| 2 | 4 | 2019-07-21 | send_message |
| 2 | 4 | 2019-07-21 | end_session |
| 3 | 2 | 2019-07-21 | open_session |
| 3 | 2 | 2019-07-21 | send_message |
| 3 | 2 | 2019-07-21 | end_session |
| 4 | 3 | 2019-06-25 | open_session |
| 4 | 3 | 2019-06-25 | end_session |

### Output:
| day | active_users |
| :--- | :--- |
| 2019-07-20 | 2 |
| 2019-07-21 | 2 |

### Explanation:
- **`2019-07-20`**: Users `1` and `2` were active -> `2` active users.
- **`2019-07-21`**: Users `2` and `3` were active -> `2` active users.
- Activity on `2019-06-25` is outside the 30-day window (`2019-06-28` to `2019-07-27`) so it is excluded.

---

## 💡 Solution Approach

Use **`WHERE`** date range filtering along with **`GROUP BY`** and **`COUNT(DISTINCT ...)`**:
1. Filter rows using `WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'`.
2. Group the records by `activity_date` aliased as `day`.
3. Count distinct active users for each day using `COUNT(DISTINCT user_id) AS active_users`.
