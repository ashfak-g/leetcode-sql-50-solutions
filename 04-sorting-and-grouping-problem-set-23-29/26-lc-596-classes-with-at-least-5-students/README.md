# 596. Classes With at Least 5 Students

**Difficulty:** Easy  
**Topic:** Sorting and Grouping  

---

## 📌 Problem Statement

Write a solution to find all the **classes that have at least five students**.

Return the result table in **any order**.

---

## 📊 Database Schema

### `Courses` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `student` | varchar | Student name (part of primary key) |
| `class` | varchar | Class name (part of primary key) |

> **Note:** `(student, class)` is the primary key for this table.

---

## 📝 Example

### Input: `Courses` Table
| student | class |
| :--- | :--- |
| A | Math |
| B | English |
| C | Math |
| D | Biology |
| E | Math |
| F | Computer |
| G | Math |
| H | Math |
| I | Math |

### Output:
| class |
| :--- |
| Math |

### Explanation:
- **Math**: Enrolled by 6 students (`A`, `C`, `E`, `G`, `H`, `I`) -> `>= 5`. Included.
- **English**: Enrolled by 1 student (`B`). Excluded.
- **Biology**: Enrolled by 1 student (`D`). Excluded.
- **Computer**: Enrolled by 1 student (`F`). Excluded.

---

## 💡 Solution Approach

Use **`GROUP BY`** along with **`HAVING`**:
1. Group records by `class`.
2. Apply `HAVING COUNT(student) >= 5` to filter for classes with 5 or more enrolled students.
