# 1148. Article Views I

**Difficulty:** Easy  
**Topic:** Select  

---

## 📌 Problem Statement

Write a solution to find all the authors that viewed at least one of their own articles.

Return the result table sorted by **`id`** in ascending order.

---

## 📊 Database Schema

### `Views` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `article_id` | int | ID of the article |
| `author_id` | int | ID of the author |
| `viewer_id` | int | ID of the viewer |
| `view_date` | date | Date of the view |

> **Note:** There is no primary key for this table; it may contain duplicate rows. Equal `author_id` and `viewer_id` indicate that the author viewed their own article.

---

## 📝 Example

### Input: `Views` Table
| article_id | author_id | viewer_id | view_date |
| :--- | :--- | :--- | :--- |
| 1 | 3 | 5 | 2019-08-01 |
| 1 | 3 | 6 | 2019-08-02 |
| 2 | 7 | 7 | 2019-08-01 |
| 2 | 7 | 6 | 2019-08-02 |
| 4 | 7 | 1 | 2019-07-22 |
| 3 | 4 | 4 | 2019-07-21 |
| 3 | 4 | 4 | 2019-07-21 |

### Output:
| id |
| :--- |
| 4 |
| 7 |

---

## 💡 Solution Approach

Filter records from the `Views` table where `author_id = viewer_id`, select unique (`DISTINCT`) author IDs aliased as `id`, and sort by `id` in ascending order.
