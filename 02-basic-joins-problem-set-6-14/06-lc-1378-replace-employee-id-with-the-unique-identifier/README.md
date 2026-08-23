# 1378. Replace Employee ID With The Unique Identifier

**Difficulty:** Easy  
**Topic:** Basic Joins  

---

## 📌 Problem Statement

Write a solution to show the **unique ID** of each user. If a user does not have a unique ID, show `null` instead.

Return the result table in **any order**.

---

## 📊 Database Schema

### `Employees` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `id` | int | Primary key (column with unique values) |
| `name` | varchar | Employee name |

### `EmployeeUNI` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `id` | int | Employee ID |
| `unique_id` | int | Unique ID assigned to employee |

---

## 📝 Example

### Input:

#### `Employees` Table
| id | name |
| :--- | :--- |
| 1 | Alice |
| 7 | Bob |
| 11 | Meir |
| 90 | Winston |
| 3 | Jonathan |

#### `EmployeeUNI` Table
| id | unique_id |
| :--- | :--- |
| 3 | 1 |
| 11 | 2 |
| 90 | 3 |

### Output:
| unique_id | name |
| :--- | :--- |
| null | Alice |
| null | Bob |
| 2 | Meir |
| 3 | Winston |
| 1 | Jonathan |

### Explanation:
- **Alice** and **Bob** do not have an entry in `EmployeeUNI`, so `unique_id` shows `null`.
- **Meir** (`id = 11`) has `unique_id = 2`.
- **Winston** (`id = 90`) has `unique_id = 3`.
- **Jonathan** (`id = 3`) has `unique_id = 1`.

---

## 💡 Solution Approach

Use a **`LEFT JOIN`** between `Employees` and `EmployeeUNI` matching on `id`:
- A `LEFT JOIN` preserves all rows from the primary `Employees` table.
- When an employee has no matching `id` in `EmployeeUNI`, SQL automatically returns `null` for `unique_id`.
