# 619. Biggest Single Number

**Difficulty:** Easy  
**Topic:** Sorting and Grouping  

---

## 📌 Problem Statement

Write a solution to find the **largest single number** in the `MyNumbers` table. 

- A **single number** is a number that appears **only once** in the table.
- If there is no single number, report `null`.

---

## 📊 Database Schema

### `MyNumbers` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `num` | int | Integer value (table may contain duplicate rows) |

---

## 📝 Examples

### Example 1:

#### Input: `MyNumbers` Table
| num |
| :--- |
| 8 |
| 8 |
| 3 |
| 3 |
| 1 |
| 4 |
| 5 |
| 6 |

#### Output:
| num |
| :--- |
| 6 |

#### Explanation:
The single numbers are `1`, `4`, `5`, and `6`. The largest single number is **`6`**.

---

### Example 2:

#### Input: `MyNumbers` Table
| num |
| :--- |
| 8 |
| 8 |
| 7 |
| 7 |
| 3 |
| 3 |
| 3 |

#### Output:
| num |
| :--- |
| null |

#### Explanation:
There are no single numbers in the input table, so output is `null`.

---

## 💡 Solution Approach

Use a Subquery with **`GROUP BY`** and **`HAVING`** combined with **`MAX()`**:
1. Inner Subquery: Group numbers by `num` and filter for numbers that appear exactly once using `HAVING COUNT(*) = 1`.
2. Outer Query: Compute `MAX(num)` over the subquery. If the subquery is empty, `MAX()` automatically evaluates to `null`.
