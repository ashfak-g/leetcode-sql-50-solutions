# 2356. Number of Unique Subjects Taught by Each Teacher

**Difficulty:** Easy  
**Topic:** Sorting and Grouping  

---

## 📌 Problem Statement

Write a solution to calculate the number of **unique subjects** each teacher teaches in the university (`cnt`).

Return the result table in **any order**.

---

## 📊 Database Schema

### `Teacher` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `teacher_id` | int | ID of the teacher |
| `subject_id` | int | ID of the subject (part of primary key) |
| `dept_id` | int | ID of the department (part of primary key) |

> **Note:** `(subject_id, dept_id)` is the primary key for this table.

---

## 📝 Example

### Input: `Teacher` Table
| teacher_id | subject_id | dept_id |
| :--- | :--- | :--- |
| 1 | 2 | 3 |
| 1 | 2 | 4 |
| 1 | 3 | 3 |
| 2 | 1 | 1 |
| 2 | 2 | 1 |
| 2 | 3 | 1 |
| 2 | 4 | 1 |

### Output:
| teacher_id | cnt |
| :--- | :--- |
| 1 | 2 |
| 2 | 4 |

### Explanation:
- **Teacher 1**: Teaches subject `2` (in depts `3` & `4`) and subject `3` (in dept `3`). Total unique subjects = **`2`**.
- **Teacher 2**: Teaches subjects `1`, `2`, `3`, and `4` (all in dept `1`). Total unique subjects = **`4`**.

---

## 💡 Solution Approach

Use **`GROUP BY`** along with **`COUNT(DISTINCT ...)`**:
1. Group records by `teacher_id`.
2. Count unique subjects for each teacher using `COUNT(DISTINCT subject_id) AS cnt`.
