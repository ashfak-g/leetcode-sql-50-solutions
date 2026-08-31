# 1789. Primary Department for Each Employee

**Difficulty:** Easy  
**Topic:** Advanced Select and Joins  

---

## 📌 Problem Statement

Write a solution to report all employees with their **primary department**.

- If an employee belongs to multiple departments, select the department where `primary_flag = 'Y'`.
- If an employee belongs to **only one department**, report that single department (even if `primary_flag` is `'N'`).

Return the result table in **any order**.

---

## 📊 Database Schema

### `Employee` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `employee_id` | int | Employee ID (part of primary key) |
| `department_id` | int | Department ID (part of primary key) |
| `primary_flag` | varchar | ENUM (`'Y'`, `'N'`) indicating primary department status |

> **Note:** `(employee_id, department_id)` is the primary key for this table.

---

## 📝 Example

### Input: `Employee` Table
| employee_id | department_id | primary_flag |
| :--- | :--- | :--- |
| 1 | 1 | N |
| 2 | 1 | Y |
| 2 | 2 | N |
| 3 | 3 | N |
| 4 | 2 | N |
| 4 | 3 | Y |
| 4 | 4 | N |

### Output:
| employee_id | department_id |
| :--- | :--- |
| 1 | 1 |
| 2 | 1 |
| 3 | 3 |
| 4 | 3 |

### Explanation:
- **Employee 1**: Belongs to only 1 department (`1`) -> Output `(1, 1)`.
- **Employee 2**: Belongs to 2 departments (`1` & `2`), primary flag is `'Y'` for dept `1` -> Output `(2, 1)`.
- **Employee 3**: Belongs to only 1 department (`3`) -> Output `(3, 3)`.
- **Employee 4**: Belongs to 3 departments (`2`, `3`, `4`), primary flag is `'Y'` for dept `3` -> Output `(4, 3)`.

---

## 💡 Solution Approach

Use **`OR`** with a Subquery:
1. **Condition 1**: Select records where `primary_flag = 'Y'`.
2. **Condition 2**: Select records where `employee_id` belongs to only one department using a subquery with `GROUP BY employee_id HAVING COUNT(*) = 1`.
