# 570. Managers with at Least 5 Direct Reports

**Difficulty:** Medium  
**Topic:** Basic Joins  

---

## 📌 Problem Statement

Write a solution to find managers with at least **five direct reports**.

Return the result table in **any order**.

---

## 📊 Database Schema

### `Employee` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `id` | int | Primary key (column with unique values) |
| `name` | varchar | Employee name |
| `department` | varchar | Department name |
| `managerId` | int | ID of the employee's manager |

> **Note:** If `managerId` is `null`, the employee does not have a manager. No employee is their own manager.

---

## 📝 Example

### Input: `Employee` Table
| id | name | department | managerId |
| :--- | :--- | :--- | :--- |
| 101 | John | A | null |
| 102 | Dan | A | 101 |
| 103 | James | A | 101 |
| 104 | Amy | A | 101 |
| 105 | Anne | A | 101 |
| 106 | Ron | B | 101 |

### Output:
| name |
| :--- |
| John |

### Explanation:
- Employee `101` (**John**) is the manager of 5 employees (`102`, `103`, `104`, `105`, `106`). Thus, John is reported.

---

## 💡 Solution Approach

Use a **Self-Join** combined with **`GROUP BY`** and **`HAVING`**:
1. Perform a `JOIN` on `Employee` aliased as `manager` and `Employee` aliased as `employee` matching `employee.managerId = manager.id`.
2. Group the records by `manager.id` and `manager.name`.
3. Apply `HAVING COUNT(employee.id) >= 5` to filter for managers who supervise at least 5 employees.
