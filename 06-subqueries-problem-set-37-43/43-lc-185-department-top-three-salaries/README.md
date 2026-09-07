# 185. Department Top Three Salaries

**Difficulty:** Hard  
**Topic:** Subqueries  

---

## 📌 Problem Statement

A company's executives are interested in seeing who earns the most money in each of the company's departments. A **high earner** in a department is an employee who has a salary in the **top three unique salaries** for that department.

Write a solution to find the employees who are high earners in each of the departments.

Return the result table in **any order**.

---

## 📊 Database Schema

### `Employee` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `id` | int | Primary key (column with unique values) |
| `name` | varchar | Name of the employee |
| `salary` | int | Salary of the employee |
| `departmentId` | int | Foreign key referencing `Department(id)` |

### `Department` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `id` | int | Primary key (column with unique values) |
| `name` | varchar | Name of the department |

---

## 📝 Example

### Input:

#### `Employee` Table
| id | name | salary | departmentId |
| :--- | :--- | :--- | :--- |
| 1 | Joe | 85000 | 1 |
| 2 | Henry | 80000 | 2 |
| 3 | Sam | 60000 | 2 |
| 4 | Max | 90000 | 1 |
| 5 | Janet | 69000 | 1 |
| 6 | Randy | 85000 | 1 |
| 7 | Will | 70000 | 1 |

#### `Department` Table
| id | name |
| :--- | :--- |
| 1 | IT |
| 2 | Sales |

### Output:

| Department | Employee | Salary |
| :--- | :--- | :--- |
| IT | Max | 90000 |
| IT | Joe | 85000 |
| IT | Randy | 85000 |
| IT | Will | 70000 |
| Sales | Henry | 80000 |
| Sales | Sam | 60000 |

### Explanation:
- **IT Department**:
  - Max earns `90000` (1st unique salary).
  - Both Randy and Joe earn `85000` (2nd unique salary).
  - Will earns `70000` (3rd unique salary).
  - Janet earns `69000` (4th unique salary, excluded).
- **Sales Department**:
  - Henry earns `80000` (1st unique salary).
  - Sam earns `60000` (2nd unique salary).
  - No 3rd employee exists.

---

## 💡 Solution Approaches

### Approach 1: Window Function with `DENSE_RANK()` (Recommended)

1. **Why `DENSE_RANK()`**:
   - The requirement is **top three unique salaries**.
   - `ROW_NUMBER()` assigns strictly unique numbers without handling ties.
   - `RANK()` skips ranks after ties (e.g., 1, 2, 2, 4 — skipping 3).
   - `DENSE_RANK()` maintains sequential ranks with ties (e.g., 1, 2, 2, 3), ensuring all employees with the top 3 distinct salaries are included.

2. **Partition & Rank**:
   - Partition by `departmentId` and order by `salary DESC`.
   - Filter rows where `salary_rank <= 3`.

```sql
WITH RankedSalaries AS (
    SELECT
        d.name AS Department,
        e.name AS Employee,
        e.salary AS Salary,
        DENSE_RANK() OVER (
            PARTITION BY e.departmentId
            ORDER BY e.salary DESC
        ) AS salary_rank
    FROM Employee e
    JOIN Department d
      ON e.departmentId = d.id
)
SELECT Department, Employee, Salary
FROM RankedSalaries
WHERE salary_rank <= 3;
```

---

### Approach 2: Correlated Subquery (Classic Subquery Method)

Count how many distinct salaries in the same department are strictly greater than the current employee's salary:
- If fewer than 3 distinct salaries are higher (`COUNT(DISTINCT e2.salary) < 3`), the current employee's salary must be in the top 3 unique salaries!

```sql
SELECT
    d.name AS Department,
    e1.name AS Employee,
    e1.salary AS Salary
FROM Employee e1
JOIN Department d
  ON e1.departmentId = d.id
WHERE 3 > (
    SELECT COUNT(DISTINCT e2.salary)
    FROM Employee e2
    WHERE e2.departmentId = e1.departmentId
      AND e2.salary > e1.salary
);
```
