# 1683. Invalid Tweets

**Difficulty:** Easy  
**Topic:** Select  

---

## 📌 Problem Statement

Write a solution to find the IDs of the invalid tweets. A tweet is **invalid** if the number of characters used in the content of the tweet is **strictly greater than 15**.

Return the result table in **any order**.

---

## 📊 Database Schema

### `Tweets` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `tweet_id` | int | Primary key (column with unique values) |
| `content` | varchar | Content of the tweet |

> **Note:** `content` consists of alphanumeric characters, `'!'`, or `' '` and no other special characters.

---

## 📝 Example

### Input: `Tweets` Table
| tweet_id | content |
| :--- | :--- |
| 1 | Let us Code |
| 2 | More than fifteen chars are here! |

### Output:
| tweet_id |
| :--- |
| 2 |

### Explanation:
- **Tweet 1** has length = 11. It is a valid tweet.
- **Tweet 2** has length = 33. It is an invalid tweet (`length > 15`).

---

## 💡 Solution Approach

Filter records from the `Tweets` table where the character length of `content` is strictly greater than 15:
- `LENGTH(content) > 15`
