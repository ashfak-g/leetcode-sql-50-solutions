# 196. Delete Duplicate Emails

**Difficulty:** Easy  
**Topic:** Advanced String Functions / Regex / Clause  

---

## 📌 Problem Statement

Write a solution to **delete all duplicate emails**, keeping only one unique email with the **smallest `id`**.

- For SQL users, you must write a **`DELETE`** statement, not a `SELECT` query.
- The result is evaluated by inspecting the `Person` table after your query runs.
- The order of rows in the final table does not matter.

---

## 📊 Database Schema

### `Person` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `id` | int | Primary key (column with unique values) |
| `email` | varchar | User email (all lowercase letters) |

---

## 📝 Example

### Input: `Person` Table

| id | email |
| :--- | :--- |
| 1 | john@example.com |
| 2 | bob@example.com |
| 3 | john@example.com |

### Output:

| id | email |
| :--- | :--- |
| 1 | john@example.com |
| 2 | bob@example.com |

### Explanation:
- `john@example.com` appears twice (with `id = 1` and `id = 3`).
- We keep `id = 1` because it is the smallest ID, and delete `id = 3`.
- `bob@example.com` appears only once (`id = 2`), so it remains untouched.

---

## 💡 Solution Approaches

### Approach 1: Self-Join `DELETE` (Recommended)

Match each record `p1` with another record `p2` that shares the same email (`p1.email = p2.email`) but has a strictly smaller ID (`p1.id > p2.id`). Any row `p1` satisfying this condition is a duplicate with a larger ID and must be deleted.

#### PostgreSQL Syntax (`USING` clause):
```sql
DELETE FROM Person AS p1
USING Person AS p2
WHERE p1.email = p2.email
  AND p1.id > p2.id;
```

#### MySQL Syntax (`JOIN` in `DELETE`):
```sql
DELETE p1
FROM Person AS p1
JOIN Person AS p2
  ON p1.email = p2.email
 AND p1.id > p2.id;
```

---

### Approach 2: Subquery with `NOT IN (MIN(id))`

Find the minimum ID for each email group (`SELECT MIN(id) FROM Person GROUP BY email`), and delete all rows whose `id` is not in this minimum set.

```sql
DELETE FROM Person
WHERE id NOT IN (
    SELECT min_id FROM (
        SELECT MIN(id) AS min_id
        FROM Person
        GROUP BY email
    ) AS temp
);
```

> ⚠️ **Note for MySQL**: Wrapping the subquery in `(SELECT min_id FROM (...) AS temp)` is required in MySQL to avoid error `1093: You can't specify target table 'Person' for update in FROM clause`.
