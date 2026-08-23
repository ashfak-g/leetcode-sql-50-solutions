# 1280. Students and Examinations

**Difficulty:** Easy  
**Topic:** Basic Joins  

---

## 📌 Problem Statement

Write a solution to find the number of times each student attended each exam.

Return the result table ordered by **`student_id`** and **`subject_name`**.

---

## 📊 Database Schema

### `Students` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `student_id` | int | Primary key (column with unique values) |
| `student_name` | varchar | Student name |

### `Subjects` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `subject_name` | varchar | Primary key (column with unique values) |

### `Examinations` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `student_id` | int | ID of student taking exam (may contain duplicates) |
| `subject_name` | varchar | Subject name of exam taken |

---

## 📝 Example

### Input:

#### `Students` Table
| student_id | student_name |
| :--- | :--- |
| 1 | Alice |
| 2 | Bob |
| 13 | John |
| 6 | Alex |

#### `Subjects` Table
| subject_name |
| :--- |
| Math |
| Physics |
| Programming |

#### `Examinations` Table
| student_id | subject_name |
| :--- | :--- |
| 1 | Math |
| 1 | Physics |
| 1 | Programming |
| 2 | Programming |
| 1 | Physics |
| 1 | Math |
| 13 | Math |
| 13 | Programming |
| 13 | Physics |
| 2 | Math |
| 1 | Math |

### Output:
| student_id | student_name | subject_name | attended_exams |
| :--- | :--- | :--- | :--- |
| 1 | Alice | Math | 3 |
| 1 | Alice | Physics | 2 |
| 1 | Alice | Programming | 1 |
| 2 | Bob | Math | 1 |
| 2 | Bob | Physics | 0 |
| 2 | Bob | Programming | 1 |
| 6 | Alex | Math | 0 |
| 6 | Alex | Physics | 0 |
| 6 | Alex | Programming | 0 |
| 13 | John | Math | 1 |
| 13 | John | Physics | 1 |
| 13 | John | Programming | 1 |

### Explanation:
- **Alice (`id = 1`)**: Math (3 times), Physics (2 times), Programming (1 time).
- **Bob (`id = 2`)**: Math (1 time), Physics (0 times), Programming (1 time).
- **Alex (`id = 6`)**: Math (0 times), Physics (0 times), Programming (0 times).
- **John (`id = 13`)**: Math (1 time), Physics (1 time), Programming (1 time).

---

## 💡 Solution Approach

Use a **`CROSS JOIN`** combined with a **`LEFT JOIN`** and **`COUNT()`**:
1. Perform a `CROSS JOIN` between `Students` and `Subjects` to generate all possible (student, subject) combinations.
2. `LEFT JOIN` the `Examinations` table on both `student_id` and `subject_name`.
3. Group by `student_id`, `student_name`, and `subject_name`, then count attended exams using `COUNT(Examinations.student_id) AS attended_exams`.
4. Order the output by `student_id` and `subject_name`.
