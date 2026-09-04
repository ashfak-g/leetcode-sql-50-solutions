# 626. Exchange Seats

**Difficulty:** Medium  
**Topic:** Subqueries  

---

## 📌 Problem Statement

Write a solution to **swap the seat id of every two consecutive students**. 

- If the total number of students is **odd**, the `id` of the last student is **not swapped**.

Return the result table ordered by **`id` in ascending order**.

---

## 📊 Database Schema

### `Seat` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `id` | int | Primary key (unique autoincrement from 1) |
| `student` | varchar | Name of student |

---

## 📝 Example

### Input: `Seat` Table
| id | student |
| :--- | :--- |
| 1 | Abbot |
| 2 | Doris |
| 3 | Emerson |
| 4 | Green |
| 5 | Jeames |

### Output:
| id | student |
| :--- | :--- |
| 1 | Doris |
| 2 | Abbot |
| 3 | Green |
| 4 | Emerson |
| 5 | Jeames |

### Explanation:
- Student 1 (Abbot) swaps seat with Student 2 (Doris) -> Abbot becomes id 2, Doris becomes id 1.
- Student 3 (Emerson) swaps seat with Student 4 (Green) -> Emerson becomes id 4, Green becomes id 3.
- Student 5 (Jeames) is the last student in an odd-sized table, so their seat id remains 5.

---

## 💡 Solution Approach

Use **`CASE WHEN`** logic combined with a subquery for the maximum ID:
1. **Case 1 (Last odd student)**: If `id % 2 = 1 AND id = (SELECT MAX(id) FROM Seat)`, keep `id` unchanged.
2. **Case 2 (Other odd students)**: If `id % 2 = 1`, swap to the next even seat by adding 1 (`id + 1`).
3. **Case 3 (Even students)**: If `id % 2 = 0`, swap to the preceding odd seat by subtracting 1 (`id - 1`).
4. Order the output by the newly assigned `id` in ascending order (`ORDER BY id ASC`).
