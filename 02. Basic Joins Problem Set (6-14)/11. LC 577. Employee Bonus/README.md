# 577. Employee Bonus

**Difficulty:** Easy  
**Topic:** Basic Joins  

---

## 📌 Problem Statement

Write a solution to report the **`name`** and **`bonus`** amount of each employee who satisfies either of the following conditions:
- The employee has a bonus **less than 1000**, OR
- The employee did not receive any bonus (`bonus` is `null`).

Return the result table in **any order**.

---

## 📊 Database Schema

### `Employee` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `empId` | int | Primary key (column with unique values) |
| `name` | varchar | Employee name |
| `supervisor` | int | ID of the manager |
| `salary` | int | Employee salary |

### `Bonus` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `empId` | int | Foreign key referencing `Employee` table |
| `bonus` | int | Bonus amount |

---

## 📝 Example

### Input:

#### `Employee` Table
| empId | name | supervisor | salary |
| :--- | :--- | :--- | :--- |
| 3 | Brad | null | 4000 |
| 1 | John | 3 | 1000 |
| 2 | Dan | 3 | 2000 |
| 4 | Thomas | 3 | 4000 |

#### `Bonus` Table
| empId | bonus |
| :--- | :--- |
| 2 | 500 |
| 4 | 2000 |

### Output:
| name | bonus |
| :--- | :--- |
| Brad | null |
| John | null |
| Dan | 500 |

### Explanation:
- **Brad**: No bonus record -> `bonus` is `null`. Included.
- **John**: No bonus record -> `bonus` is `null`. Included.
- **Dan**: Bonus is `500` (`< 1000`). Included.
- **Thomas**: Bonus is `2000` (`>= 1000`). Excluded.

---

## 💡 Solution Approach

Use a **`LEFT JOIN`** between `Employee` and `Bonus` matching on `empId`:
- A `LEFT JOIN` ensures all employees are returned, even if they have no entry in the `Bonus` table.
- Filter rows using `WHERE Bonus.bonus < 1000 OR Bonus.bonus IS NULL` to include both low-bonus and no-bonus employees.
