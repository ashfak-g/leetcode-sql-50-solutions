/*
Problem 197: Rising Temperature

Table: Weather
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
- id is the primary key for this table.
- There are no two rows with the same recordDate.
- This table contains information about the temperature on a certain day.

Task:
Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).
Return the result table in any order.

Example 1:
Input: 
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+

Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+

Explanation: 
- In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
- In 2015-01-04, the temperature was higher than the previous day (20 -> 30).
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

SELECT today.id
FROM Weather AS today
JOIN Weather AS previous_day
  ON today.recordDate = previous_day.recordDate + 1
WHERE today.temperature > previous_day.temperature;