# 1667. Fix Names in a Table

**Difficulty:** Easy  
**Topic:** Advanced String Functions / Regex / Clause  

---

## 📌 Problem Statement

Write a solution to fix the names so that **only the first character is uppercase** and the **rest are lowercase**.

Return the result table ordered by **`user_id` in ascending order**.

---

## 📊 Database Schema

### `Users` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `user_id` | int | Primary key (column with unique values) |
| `name` | varchar | Name of the user (consists of uppercase and lowercase letters) |

---

## 📝 Example

### Input: `Users` Table

| user_id | name |
| :--- | :--- |
| 1 | aLice |
| 2 | bOB |

### Output:

| user_id | name |
| :--- | :--- |
| 1 | Alice |
| 2 | Bob |

### Explanation:
- `aLice`: First letter `'a'` becomes `'A'`, and `'Lice'` becomes `'lice'` -> `'Alice'`.
- `bOB`: First letter `'b'` becomes `'B'`, and `'OB'` becomes `'ob'` -> `'Bob'`.

---

## 💡 Solution Approaches

### Approach 1: String Functions with `CONCAT()` (MySQL & PostgreSQL)

1. **Extract and Capitalize First Character**:
   - `LEFT(name, 1)` or `SUBSTR(name, 1, 1)` gets the initial letter.
   - `UPPER(...)` converts it to uppercase.

2. **Extract and Lowercase the Remainder**:
   - `SUBSTR(name, 2)` extracts the substring starting from the 2nd character to the end.
   - `LOWER(...)` converts all remaining characters to lowercase.

3. **Concatenate**:
   - `CONCAT(UPPER(LEFT(name, 1)), LOWER(SUBSTR(name, 2)))` combines both parts into properly formatted title-case names.

4. **Order by `user_id ASC`**.

```sql
SELECT user_id,
       CONCAT(UPPER(LEFT(name, 1)), LOWER(SUBSTR(name, 2))) AS name
FROM Users
ORDER BY user_id ASC;
```

---

### Approach 2: Concatenation Operator `||` (PostgreSQL)

In PostgreSQL, strings can also be concatenated using the standard SQL `||` operator:

```sql
SELECT user_id,
       UPPER(LEFT(name, 1)) || LOWER(SUBSTRING(name FROM 2)) AS name
FROM Users
ORDER BY user_id ASC;
```
