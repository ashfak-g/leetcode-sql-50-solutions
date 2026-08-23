# 1075. Project Employees I

**Difficulty:** Easy  
**Topic:** Basic Aggregate Functions  

---

## 📌 Problem Statement

Write a solution to report the **average experience years** of all employees for each project, rounded to **2 decimal places**.

Return the result table in **any order**.

---

## 📊 Database Schema

### `Project` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `project_id` | int | Project ID (part of primary key) |
| `employee_id` | int | Foreign key referencing `Employee` table (part of primary key) |

### `Employee` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `employee_id` | int | Primary key (column with unique values) |
| `name` | varchar | Employee name |
| `experience_years` | int | Years of experience (guaranteed not null) |

---

## 📝 Example

### Input:

#### `Project` Table
| project_id | employee_id |
| :--- | :--- |
| 1 | 1 |
| 1 | 2 |
| 1 | 3 |
| 2 | 1 |
| 2 | 4 |

#### `Employee` Table
| employee_id | name | experience_years |
| :--- | :--- | :--- |
| 1 | Khaled | 3 |
| 2 | Ali | 2 |
| 3 | John | 1 |
| 4 | Doe | 2 |

### Output:
| project_id | average_years |
| :--- | :--- |
| 1 | 2.00 |
| 2 | 2.50 |

### Explanation:
- **Project 1**: `(3 + 2 + 1) / 3 = 6 / 3 = 2.00`
- **Project 2**: `(3 + 2) / 2 = 5 / 2 = 2.50`

---

## 💡 Solution Approach

Use an **`INNER JOIN`** combined with **`AVG()`** and **`ROUND()`**:
1. Join `Project p` and `Employee e` on `p.employee_id = e.employee_id`.
2. Group the records by `project_id`.
3. Compute the average experience using `AVG(e.experience_years)` and round it to 2 decimal places using `ROUND(..., 2)`.
