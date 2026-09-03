# 1978. Employees Whose Manager Left the Company

**Difficulty:** Easy  
**Topic:** Subqueries  

---

## 📌 Problem Statement

Find the IDs of the employees whose salary is **strictly less than `$30000`** and **whose manager left the company**.

- When a manager leaves the company, their record is deleted from the `Employees` table, but their former reports still retain their `manager_id`.
- If an employee does not have a manager, their `manager_id` is `null`.

Return the result table ordered by **`employee_id` in ascending order**.

---

## 📊 Database Schema

### `Employees` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `employee_id` | int | Primary key for this table |
| `name` | varchar | Name of employee |
| `manager_id` | int | ID of employee's manager (can be null) |
| `salary` | int | Employee's salary |

---

## 📝 Example

### Input: `Employees` Table
| employee_id | name | manager_id | salary |
| :--- | :--- | :--- | :--- |
| 3 | Mila | 9 | 60301 |
| 12 | Antonella | null | 31000 |
| 13 | Emery | null | 67084 |
| 1 | Kalel | 11 | 21241 |
| 9 | Mikaela | null | 50937 |
| 11 | Joziah | 6 | 28485 |

### Output:
| employee_id |
| :--- |
| 11 |

### Explanation:
- Employees with salary < $30000:
  - Employee `1` (Kalel, salary: 21241, manager: `11`). Employee `11` is still in the table -> Manager has NOT left.
  - Employee `11` (Joziah, salary: 28485, manager: `6`). Employee `6` is NOT in the table -> Manager left the company!
- Result: **`11`**.

---

## 💡 Solution Approaches

### Approach 1: Subquery with `NOT IN` (Standard Subquery Method)
1. Filter employees earning strictly under $30,000 (`salary < 30000`).
2. Ensure they actually have a manager assigned (`manager_id IS NOT NULL`).
3. Verify that the `manager_id` does not exist in the active `employee_id` list using `manager_id NOT IN (SELECT employee_id FROM Employees)`.

### Approach 2: Self `LEFT JOIN`
1. Perform a `LEFT JOIN` on `Employees e` and `Employees m` on `e.manager_id = m.employee_id`.
2. Keep rows where `e.salary < 30000`, `e.manager_id IS NOT NULL`, and `m.employee_id IS NULL`.
