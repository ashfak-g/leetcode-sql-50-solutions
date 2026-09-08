# 1527. Patients With a Condition

**Difficulty:** Easy  
**Topic:** Advanced String Functions / Regex / Clause  

---

## 📌 Problem Statement

Write a solution to find the `patient_id`, `patient_name`, and `conditions` of the patients who have **Type I Diabetes**. 

- **Type I Diabetes** always starts with the **`DIAB1`** prefix.
- `conditions` contains zero or more diagnosis codes separated by spaces.
- Return the result table in **any order**.

---

## 📊 Database Schema

### `Patients` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `patient_id` | int | Primary key (column with unique values) |
| `patient_name` | varchar | Name of the patient |
| `conditions` | varchar | 0 or more medical diagnosis codes separated by spaces |

---

## 📝 Example

### Input: `Patients` Table

| patient_id | patient_name | conditions |
| :--- | :--- | :--- |
| 1 | Daniel | YFEV COUGH |
| 2 | Alice | |
| 3 | Bob | DIAB100 MYOP |
| 4 | George | ACNE DIAB100 |
| 5 | Alain | DIAB201 |

### Output:

| patient_id | patient_name | conditions |
| :--- | :--- | :--- |
| 3 | Bob | DIAB100 MYOP |
| 4 | George | ACNE DIAB100 |

### Explanation:
- Patient `1` (`YFEV COUGH`): Does not have a condition starting with `DIAB1`.
- Patient `2` (empty): No conditions.
- Patient `3` (`DIAB100 MYOP`): First condition `DIAB100` starts with `DIAB1` -> ✅
- Patient `4` (`ACNE DIAB100`): Second condition `DIAB100` starts with `DIAB1` -> ✅
- Patient `5` (`DIAB201`): Starts with `DIAB2`, not `DIAB1` -> ❌

---

## 💡 Solution Approaches

### Approach 1: Pattern Matching using `LIKE` (Optimal & Universal)

Because conditions are space-separated, a condition with prefix `DIAB1` can only appear in two positions:
1. **At the very beginning of the string**: `conditions LIKE 'DIAB1%'`
2. **Preceded by a space anywhere later in the string**: `conditions LIKE '% DIAB1%'`

> ⚠️ **Common Pitfall**: Using only `LIKE '%DIAB1%'` is incorrect because it would erroneously match conditions like `SADIAB100` where `DIAB1` is in the middle of a code rather than a prefix.

```sql
SELECT patient_id,
       patient_name,
       conditions
FROM Patients
WHERE conditions LIKE 'DIAB1%'
   OR conditions LIKE '% DIAB1%';
```

---

### Approach 2: Regular Expressions (`REGEXP` / `~`)

Use word boundary or start-of-word regex patterns:
- In **MySQL**: `WHERE conditions REGEXP '(^|[[:space:]])DIAB1'` or `WHERE conditions REGEXP '\\bDIAB1'`
- In **PostgreSQL**: `WHERE conditions ~ '(^|\\s)DIAB1'` or `WHERE conditions ~ '\\mDIAB1'`
