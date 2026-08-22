# 620. Not Boring Movies

**Difficulty:** Easy  
**Topic:** Basic Aggregate Functions / Basic Filtering  

---

## 📌 Problem Statement

Write a solution to report the movies with an **odd-numbered ID** and a description that is **not `"boring"`**.

Return the result table ordered by **`rating` in descending order**.

---

## 📊 Database Schema

### `Cinema` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `id` | int | Primary key (column with unique values) |
| `movie` | varchar | Name of the movie |
| `description` | varchar | Description / genre of the movie |
| `rating` | float | Rating in the range [0, 10] |

---

## 📝 Example

### Input: `Cinema` Table
| id | movie | description | rating |
| :--- | :--- | :--- | :--- |
| 1 | War | great 3D | 8.9 |
| 2 | Science | fiction | 8.5 |
| 3 | irish | boring | 6.2 |
| 4 | Ice song | Fantacy | 8.6 |
| 5 | House card | Interesting | 9.1 |

### Output:
| id | movie | description | rating |
| :--- | :--- | :--- | :--- |
| 5 | House card | Interesting | 9.1 |
| 1 | War | great 3D | 8.9 |

### Explanation:
- Movies with odd-numbered IDs are `1`, `3`, and `5`.
- Movie `3` has description `'boring'`, so it is excluded.
- Remaining movies `5` (`rating = 9.1`) and `1` (`rating = 8.9`) are selected and sorted by `rating` in descending order.

---

## 💡 Solution Approach

Filter records from the `Cinema` table using modulus and string comparison:
- `id % 2 = 1` filters for odd IDs.
- `description != 'boring'` excludes movies described as boring.
- `ORDER BY rating DESC` orders the output from highest rating to lowest.
