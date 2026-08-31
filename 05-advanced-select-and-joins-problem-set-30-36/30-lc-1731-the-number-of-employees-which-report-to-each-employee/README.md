# 1731. The Number of Employees Which Report to Each Employee

**Difficulty:** Easy  
**Topic:** Advanced Select and Joins  

---

## 📌 Problem Statement

Write a solution to report the **`employee_id`** and **`name`** of all **managers**, the number of employees who report directly to them (**`reports_count`**), and the **average age** of their direct reports rounded to the nearest integer (**`average_age`**).

- A **manager** is defined as an employee who has at least 1 other employee reporting to them (`reports_to = manager.employee_id`).

Return the result table ordered by **`employee_id` in ascending order**.

---

## 📊 Database Schema

### `Employees` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `employee_id` | int | Primary key (column with unique values) |
| `name` | varchar | Employee name |
| `reports_to` | int | ID of the manager (foreign key to `employee_id`) |
| `age` | int | Age of employee |

---

## 📝 Examples

### Example 1:

#### Input: `Employees` Table
| employee_id | name | reports_to | age |
| :--- | :--- | :--- | :--- |
| 9 | Hercy | null | 43 |
| 6 | Alice | 9 | 41 |
| 4 | Bob | 9 | 36 |
| 2 | Winston | null | 37 |

#### Output:
| employee_id | name | reports_count | average_age |
| :--- | :--- | :--- | :--- |
| 9 | Hercy | 2 | 39 |

#### Explanation:
Hercy (`id = 9`) has 2 direct reports (`Alice` aged 41, `Bob` aged 36).
Average age = `(41 + 36) / 2 = 38.5` -> rounded to nearest integer is **`39`**.

---

## 💡 Solution Approach

Use a **`SELF JOIN`** on the `Employees` table:
1. Join `Employees AS manager` with `Employees AS employee` on `manager.employee_id = employee.reports_to`.
2. Group records by `manager.employee_id` and `manager.name`.
3. Compute `COUNT(employee.employee_id) AS reports_count`.
4. Compute `ROUND(AVG(employee.age)) AS average_age`.
5. Order output by `manager.employee_id` ascending.
