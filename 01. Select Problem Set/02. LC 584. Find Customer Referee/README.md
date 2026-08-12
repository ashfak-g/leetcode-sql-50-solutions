# 584. Find Customer Referee

**Difficulty:** Easy  
**Topic:** Select  

---

## 📌 Problem Statement

Find the names of the customers that are **not referred by the customer with `id = 2`**.

Return the result table in **any order**.

---

## 📊 Database Schema

### `Customer` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `id` | int | Primary key |
| `name` | varchar | Customer name |
| `referee_id` | int | ID of the customer who referred them |

---

## 📝 Example

### Input: `Customer` Table
| id | name | referee_id |
| :--- | :--- | :--- |
| 1 | Will | null |
| 2 | Jane | null |
| 3 | Alex | 2 |
| 4 | Bill | null |
| 5 | Zack | 1 |
| 6 | Mark | 2 |

### Output:
| name |
| :--- |
| Will |
| Jane |
| Bill |
| Zack |

---

## 💡 Solution Approach

Filter records from the `Customer` table using:
- `referee_id != 2`
- `referee_id IS NULL`
