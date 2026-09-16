# 1517. Find Users With Valid E-Mails

**Difficulty:** Easy  
**Topic:** Advanced String Functions / Regex / Clause  

---

## 📌 Problem Statement

Write a solution to find the users who have **valid emails**.

A valid e-mail has a **prefix name** and a **domain** where:
1. **Prefix name**: A string that may contain letters (upper or lower case), digits, underscore (`'_'`), period (`'.'`), and/or dash (`'-'`). The prefix name **must start with a letter**.
2. **Domain**: Must be exactly **`@leetcode.com`** in lowercase.

Return the result table in **any order**.

---

## 📊 Database Schema

### `Users` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `user_id` | int | Primary key (column with unique values) |
| `name` | varchar | Name of the user |
| `mail` | varchar | Email address of the user |

---

## 📝 Example

### Input: `Users` Table

| user_id | name | mail |
| :--- | :--- | :--- |
| 1 | Winston | winston@leetcode.com |
| 2 | Jonathan | jonathanisgreat |
| 3 | Annabelle | bella-@leetcode.com |
| 4 | Sally | sally.come@leetcode.com |
| 5 | Marwan | quarz#2020@leetcode.com |
| 6 | David | david69@gmail.com |
| 7 | Shapiro | .shapo@leetcode.com |

### Output:

| user_id | name | mail |
| :--- | :--- | :--- |
| 1 | Winston | winston@leetcode.com |
| 3 | Annabelle | bella-@leetcode.com |
| 4 | Sally | sally.come@leetcode.com |

### Explanation:
- `winston@leetcode.com`: Valid prefix (`winston`), starts with `'w'`, domain is `@leetcode.com` -> ✅
- `jonathanisgreat`: Missing domain -> ❌
- `bella-@leetcode.com`: Valid prefix ending with dash `'-'`, starts with `'b'`, domain is `@leetcode.com` -> ✅
- `sally.come@leetcode.com`: Valid prefix with dot `'.' `, starts with `'s'`, domain is `@leetcode.com` -> ✅
- `quarz#2020@leetcode.com`: Prefix contains `#` which is invalid -> ❌
- `david69@gmail.com`: Domain is `@gmail.com` instead of `@leetcode.com` -> ❌
- `.shapo@leetcode.com`: Prefix starts with `.` instead of a letter -> ❌

---

## 💡 Solution Approaches

### Regular Expression Breakdown

The regular expression pattern is:
`^[A-Za-z][A-Za-z0-9_.-]*@leetcode\.com$`

- `^`: Asserts the beginning of the string.
- `[A-Za-z]`: The first character must be an alphabetic letter (case-insensitive).
- `[A-Za-z0-9_.-]*`: Subsequent characters in prefix can be zero or more letters, digits, underscores (`_`), dots (`.`), or dashes (`-`).
- `@leetcode\.com`: Literal `@leetcode` followed by an escaped period `\.` and `com`.
- `$`: Asserts the end of the string.

---

### Implementation

#### PostgreSQL (`~` operator):
```sql
SELECT user_id,
       name,
       mail
FROM Users
WHERE mail ~ '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\.com$';
```

#### MySQL (`REGEXP`):
```sql
SELECT user_id,
       name,
       mail
FROM Users
WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\\.com$';
```
