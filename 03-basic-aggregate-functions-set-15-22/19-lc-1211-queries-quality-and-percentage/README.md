# 1211. Queries Quality and Percentage

**Difficulty:** Easy  
**Topic:** Basic Aggregate Functions  

---

## 📌 Problem Statement

Write a solution to find each `query_name`, its **`quality`**, and its **`poor_query_percentage`**.

- **Query Quality**: The average of the ratio between query rating and its position (`rating / position`).
- **Poor Query Percentage**: The percentage of all queries with a rating strictly less than 3 (`rating < 3`).
- Both `quality` and `poor_query_percentage` should be rounded to **2 decimal places**.

Return the result table in **any order**.

---

## 📊 Database Schema

### `Queries` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `query_name` | varchar | Name of the query |
| `result` | varchar | Result returned by query |
| `position` | int | Position in result list (1 to 500) |
| `rating` | int | Rating score (1 to 5) |

> **Note:** A query with `rating < 3` is considered a poor query.

---

## 📝 Example

### Input: `Queries` Table
| query_name | result | position | rating |
| :--- | :--- | :--- | :--- |
| Dog | Golden Retriever | 1 | 5 |
| Dog | German Shepherd | 2 | 5 |
| Dog | Mule | 200 | 1 |
| Cat | Shirazi | 5 | 2 |
| Cat | Siamese | 3 | 3 |
| Cat | Sphynx | 7 | 4 |

### Output:
| query_name | quality | poor_query_percentage |
| :--- | :--- | :--- |
| Dog | 2.50 | 33.33 |
| Cat | 0.66 | 33.33 |

### Explanation:
- **Dog Queries**:
  - Quality = `((5 / 1) + (5 / 2) + (1 / 200)) / 3 = (5 + 2.5 + 0.005) / 3 = 2.50`
  - Poor Query Percentage = `(1 / 3) * 100 = 33.33%`
- **Cat Queries**:
  - Quality = `((2 / 5) + (3 / 3) + (4 / 7)) / 3 = (0.4 + 1.0 + 0.5714) / 3 = 0.66`
  - Poor Query Percentage = `(1 / 3) * 100 = 33.33%`

---

## 💡 Solution Approach

Use **`GROUP BY`** along with aggregate functions (`AVG`, `CASE`, `ROUND`):
1. `WHERE query_name IS NOT NULL` filters out any rows with missing query names.
2. Group records by `query_name`.
3. Calculate `quality` using `ROUND(AVG(rating * 1.0 / position), 2)`.
4. Calculate `poor_query_percentage` using `ROUND(AVG(CASE WHEN rating < 3 THEN 1.0 ELSE 0.0 END) * 100, 2)`.
