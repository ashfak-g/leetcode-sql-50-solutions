# 1341. Movie Rating

**Difficulty:** Medium  
**Topic:** Subqueries  

---

## 📌 Problem Statement

Write a solution to:

1. Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
2. Find the movie name with the highest average rating in **February 2020**. In case of a tie, return the lexicographically smaller movie name.

---

## 📊 Database Schema

### `Movies` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `movie_id` | int | Primary key (column with unique values) for this table |
| `title` | varchar | Name of the movie (each movie has a unique title) |

### `Users` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `user_id` | int | Primary key (column with unique values) for this table |
| `name` | varchar | Name of the user (unique values) |

### `MovieRating` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `movie_id` | int | Foreign key referencing `Movies` table |
| `user_id` | int | Foreign key referencing `Users` table |
| `rating` | int | Rating of the movie by the user in their review |
| `created_at` | date | Review date |

> Note: `(movie_id, user_id)` is the primary key for the `MovieRating` table.

---

## 📝 Example

### Input:

#### `Movies` Table
| movie_id | title |
| :--- | :--- |
| 1 | Avengers |
| 2 | Frozen 2 |
| 3 | Joker |

#### `Users` Table
| user_id | name |
| :--- | :--- |
| 1 | Daniel |
| 2 | Monica |
| 3 | Maria |
| 4 | James |

#### `MovieRating` Table
| movie_id | user_id | rating | created_at |
| :--- | :--- | :--- | :--- |
| 1 | 1 | 3 | 2020-01-12 |
| 1 | 2 | 4 | 2020-02-11 |
| 1 | 3 | 2 | 2020-02-12 |
| 1 | 4 | 1 | 2020-01-01 |
| 2 | 1 | 5 | 2020-02-17 |
| 2 | 2 | 2 | 2020-02-01 |
| 2 | 3 | 2 | 2020-03-01 |
| 3 | 1 | 3 | 2020-02-22 |
| 3 | 2 | 4 | 2020-02-25 |

### Output:
| results |
| :--- |
| Daniel |
| Frozen 2 |

### Explanation:
- Daniel and Monica have both rated 3 movies (`"Avengers"`, `"Frozen 2"`, and `"Joker"`), but Daniel is smaller lexicographically.
- `"Frozen 2"` and `"Joker"` both have an average rating of `3.5` in February 2020, but `"Frozen 2"` is smaller lexicographically.

---

## 💡 Solution Approach

Combine two subqueries with **`UNION ALL`**:

1. **Top User by Number of Reviews**:
   - `JOIN` the `Users` and `MovieRating` tables on `user_id`.
   - `GROUP BY` `user_id` and `name`.
   - `ORDER BY COUNT(*) DESC, u.name ASC` to pick the user with the most ratings, breaking ties alphabetically.
   - Use `LIMIT 1` to get the top user.

2. **Top Movie in February 2020 by Average Rating**:
   - `JOIN` the `Movies` and `MovieRating` tables on `movie_id`.
   - Filter records for February 2020 using `created_at >= '2020-02-01' AND created_at < '2020-03-01'`.
   - `GROUP BY` `movie_id` and `title`.
   - `ORDER BY AVG(rating) DESC, m.title ASC` to pick the highest rated movie, breaking ties alphabetically.
   - Use `LIMIT 1` to get the top movie.

3. **Combine Results**:
   - Enclose each query in parentheses and merge their outputs using `UNION ALL`.
