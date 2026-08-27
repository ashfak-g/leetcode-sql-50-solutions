# 550. Game Play Analysis IV

**Difficulty:** Medium  
**Topic:** Basic Aggregate Functions  

---

## 📌 Problem Statement

Write a solution to report the **fraction of players that logged in again on the day after the day they first logged in**, rounded to **2 decimal places**.

In other words, determine the number of players who logged in on the day immediately following their initial login, divided by the total number of distinct players.

---

## 📊 Database Schema

### `Activity` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `player_id` | int | Player ID (part of primary key) |
| `device_id` | int | Device ID |
| `event_date` | date | Date of login event (part of primary key) |
| `games_played` | int | Number of games played |

---

## 📝 Example

### Input: `Activity` Table
| player_id | device_id | event_date | games_played |
| :--- | :--- | :--- | :--- |
| 1 | 2 | 2016-03-01 | 5 |
| 1 | 2 | 2016-03-02 | 6 |
| 2 | 3 | 2017-06-25 | 1 |
| 3 | 1 | 2016-03-02 | 0 |
| 3 | 4 | 2018-07-03 | 5 |

### Output:
| fraction |
| :--- |
| 0.33 |

### Explanation:
- Total distinct players = 3 (`1`, `2`, `3`).
- **Player 1**: First login date = `2016-03-01`. Logged in next day `2016-03-02` -> **Yes**.
- **Player 2**: First login date = `2017-06-25`. No login next day `2017-06-26` -> No.
- **Player 3**: First login date = `2016-03-02`. No login next day `2016-03-03` -> No.
- Fraction = `1 / 3 = 0.33`.

---

## 💡 Solution Approach

Use a Subquery to find initial login dates combined with a **`JOIN`** and **`ROUND()`**:
1. Create a subquery `f` to find the first login date for each player (`MIN(event_date) AS first_date`).
2. Join `Activity a` with subquery `f` on `a.player_id = f.player_id` AND `a.event_date = f.first_date + 1`.
3. Divide the count of matched players by total distinct players `(SELECT COUNT(DISTINCT player_id) FROM Activity)`.
4. Round the fraction to 2 decimal places using `ROUND(..., 2)`.
