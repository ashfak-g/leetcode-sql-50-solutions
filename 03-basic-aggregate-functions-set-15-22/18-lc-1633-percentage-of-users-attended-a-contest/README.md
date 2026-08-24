# 1633. Percentage of Users Attended a Contest

**Difficulty:** Easy  
**Topic:** Basic Aggregate Functions  

---

## 📌 Problem Statement

Write a solution to find the **percentage of users** registered in each contest, rounded to **2 decimal places**.

Return the result table ordered by **`percentage` in descending order**. In case of a tie, order by **`contest_id` in ascending order**.

---

## 📊 Database Schema

### `Users` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `user_id` | int | Primary key (column with unique values) |
| `user_name` | varchar | Name of the user |

### `Register` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `contest_id` | int | ID of the contest (part of primary key) |
| `user_id` | int | ID of the registered user (part of primary key) |

---

## 📝 Example

### Input:

#### `Users` Table
| user_id | user_name |
| :--- | :--- |
| 6 | Alice |
| 2 | Bob |
| 7 | Alex |

#### `Register` Table
| contest_id | user_id |
| :--- | :--- |
| 215 | 6 |
| 209 | 2 |
| 208 | 2 |
| 210 | 6 |
| 208 | 6 |
| 209 | 7 |
| 209 | 6 |
| 215 | 7 |
| 208 | 7 |
| 210 | 2 |
| 207 | 2 |
| 210 | 7 |

### Output:
| contest_id | percentage |
| :--- | :--- |
| 208 | 100.0 |
| 209 | 100.0 |
| 210 | 100.0 |
| 215 | 66.67 |
| 207 | 33.33 |

### Explanation:
- Total Users = 3 (`6`, `2`, `7`).
- **Contests 208, 209, 210**: All 3 users registered -> `(3/3) * 100 = 100.0%`. Sorted by `contest_id ASC` for tie-breaking.
- **Contest 215**: 2 users registered (`6`, `7`) -> `(2/3) * 100 = 66.67%`.
- **Contest 207**: 1 user registered (`2`) -> `(1/3) * 100 = 33.33%`.

---

## 💡 Solution Approach

Use **`GROUP BY`** and a subquery to count total users:
1. Count the number of registered users for each `contest_id` using `COUNT(user_id)`.
2. Divide by the total count of all users fetched from `(SELECT COUNT(*) FROM Users)`.
3. Multiply by `100.0` and round to 2 decimal places using `ROUND(..., 2)`.
4. Order results by `percentage DESC, contest_id ASC`.
