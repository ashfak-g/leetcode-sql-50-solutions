# 1204. Last Person to Fit in the Bus

**Difficulty:** Medium  
**Topic:** Advanced Select and Joins  

---

## 📌 Problem Statement

Write a solution to find the **`person_name`** of the **last person that can fit on the bus** without exceeding the weight limit of **`1000` kilograms**.

- People board the bus in the order of **`turn`** (`turn = 1` is first).
- The total cumulative weight of all boarded passengers cannot exceed `1000` kg.

---

## 📊 Database Schema

### `Queue` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `person_id` | int | Primary key (column with unique values) |
| `person_name` | varchar | Name of person |
| `weight` | int | Weight in kg |
| `turn` | int | Boarding order (1 to n) |

---

## 📝 Example

### Input: `Queue` Table
| person_id | person_name | weight | turn |
| :--- | :--- | :--- | :--- |
| 5 | Alice | 250 | 1 |
| 4 | Bob | 175 | 5 |
| 3 | Alex | 350 | 2 |
| 6 | John Cena | 400 | 3 |
| 1 | Winston | 500 | 6 |
| 2 | Marie | 200 | 4 |

### Output:
| person_name |
| :--- |
| John Cena |

### Boarding Progression:
| Turn | Person | Weight | Cumulative Weight | Status |
| :--- | :--- | :--- | :--- | :--- |
| 1 | Alice | 250 | 250 | Boards |
| 2 | Alex | 350 | 600 | Boards |
| 3 | **John Cena** | **400** | **1000** | **Last Person to Board** |
| 4 | Marie | 200 | 1200 | Cannot Board (> 1000 kg) |
| 5 | Bob | 175 | 1375 | Cannot Board |
| 6 | Winston | 500 | 1875 | Cannot Board |

---

## 💡 Solution Approach

Use Window Function **`SUM() OVER (ORDER BY turn)`**:
1. Compute the running total weight for each passenger ordered by `turn` using `SUM(weight) OVER (ORDER BY turn) AS total_weight`.
2. Filter for passengers where `total_weight <= 1000`.
3. Order by `total_weight DESC` (or `turn DESC`) and return the first row using `LIMIT 1`.
