/*
Problem 550: Game Play Analysis IV

Table: Activity
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
- (player_id, event_date) is the primary key for this table.

Task:
Write a solution to report the fraction of players that logged in again on the day after 
the day they first logged in, rounded to 2 decimal places.

Example 1:
Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Output: 
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+

Explanation: 
- Player 1 logged in on 2016-03-01 (first date) and next day 2016-03-02 (YES).
- Player 2 & 3 did not log in the day after their first login.
- Fraction = 1 / 3 = 0.33
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

SELECT ROUND(
         COUNT(a.player_id) * 1.0 / (SELECT COUNT(DISTINCT player_id) FROM Activity),
         2
       ) AS fraction
FROM Activity AS a
JOIN (
    SELECT player_id,
           MIN(event_date) AS first_date
    FROM Activity
    GROUP BY player_id
) AS f
  ON a.player_id = f.player_id
 AND a.event_date = f.first_date + 1;