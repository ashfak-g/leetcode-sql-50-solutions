# 197. Rising Temperature

**Difficulty:** Easy  
**Topic:** Basic Joins  

---

## 📌 Problem Statement

Write a solution to find all dates' `id` with higher temperatures compared to their previous dates (yesterday).

Return the result table in **any order**.

---

## 📊 Database Schema

### `Weather` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `id` | int | Primary key (column with unique values) |
| `recordDate` | date | Date of the record |
| `temperature` | int | Temperature on that date |

> **Note:** There are no duplicate rows with the same `recordDate`.

---

## 📝 Example

### Input: `Weather` Table
| id | recordDate | temperature |
| :--- | :--- | :--- |
| 1 | 2015-01-01 | 10 |
| 2 | 2015-01-02 | 25 |
| 3 | 2015-01-03 | 20 |
| 4 | 2015-01-04 | 30 |

### Output:
| id |
| :--- |
| 2 |
| 4 |

### Explanation:
- On **`2015-01-02`**, temperature was **25**, which is higher than yesterday `2015-01-01` (**10**). Output: `2`.
- On **`2015-01-03`**, temperature was **20**, which is lower than yesterday `2015-01-02` (**25**).
- On **`2015-01-04`**, temperature was **30**, which is higher than yesterday `2015-01-03` (**20**). Output: `4`.

---

## 💡 Solution Approach

Use a **Self-Join** on the `Weather` table:
1. Join the `Weather` table with itself, aliasing them as `today` and `previous_day`.
2. Connect `today.recordDate` to yesterday's date (`previous_day.recordDate + 1` or using date functions).
3. Filter rows where `today.temperature > previous_day.temperature` to extract the IDs of dates with higher temperatures.
