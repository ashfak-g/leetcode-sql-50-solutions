# 176. Second Highest Salary

**Difficulty:** Medium  
**Topic:** Advanced String Functions / Regex / Clause  

---

## 📌 Problem Statement

Write a solution to find the **second highest distinct salary** from the `Employee` table. 

- If there is **no second highest salary**, return **`null`**.

---

## 📊 Database Schema

### `Employee` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `id` | int | Primary key (column with unique values) |
| `salary` | int | Employee salary |

---

## 📝 Examples

### Example 1:

#### Input: `Employee` Table
| id | salary |
| :--- | :--- |
| 1 | 100 |
| 2 | 200 |
| 3 | 300 |

#### Output:
| SecondHighestSalary |
| :--- |
| 200 |

---

### Example 2:

#### Input: `Employee` Table
| id | salary |
| :--- | :--- |
| 1 | 100 |

#### Output:
| SecondHighestSalary |
| :--- |
| null |

#### Explanation:
There is only 1 distinct salary in the table (`100`), so no second highest salary exists, returning `null`.

---

## 💡 Solution Approaches

### Approach 1: Scalar Subquery with `LIMIT 1 OFFSET 1` (Recommended)

1. **Sort Unique Salaries**:
   - `SELECT DISTINCT salary FROM Employee ORDER BY salary DESC LIMIT 1 OFFSET 1` fetches the second distinct highest salary.
2. **Handle Missing Row (Returning `NULL`)**:
   - If there are fewer than 2 distinct salaries, the inner query returns an **empty set (0 rows)**.
   - Wrapping it in a scalar subquery `SELECT ( ... ) AS SecondHighestSalary` automatically evaluates an empty result to a single row containing `NULL`.

```sql
SELECT (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
) AS SecondHighestSalary;
```

---

### Approach 2: Subquery with `MAX()` (Classic ANSI SQL)

1. Find the highest salary: `(SELECT MAX(salary) FROM Employee)`.
2. Filter for salaries strictly less than the highest salary: `WHERE salary < (SELECT MAX(salary) FROM Employee)`.
3. Take the maximum among remaining salaries: `SELECT MAX(salary)`.
4. If no rows remain (e.g., only 1 unique salary), the aggregate function `MAX()` naturally returns `NULL`.

```sql
SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (
    SELECT MAX(salary)
    FROM Employee
);
```
