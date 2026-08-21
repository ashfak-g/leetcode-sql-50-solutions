/*
Problem 1934: Confirmation Rate

Table: Signups
+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
+----------------+----------+
- user_id is the primary key for this table.
- Each row contains signup time for user_id.

Table: Confirmations
+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
| action         | ENUM     |
+----------------+----------+
- (user_id, time_stamp) is the primary key for this table.
- action is an ENUM ('confirmed', 'timeout').

Task:
The confirmation rate of a user is the number of 'confirmed' messages divided by the total number 
of requested confirmation messages. The rate of a user that did not request any messages is 0. 
Round confirmation rate to 2 decimal places.
Return the result table in any order.

Example 1:
Input: 
Signups table:
+---------+---------------------+
| user_id | time_stamp          |
+---------+---------------------+
| 3       | 2020-03-21 10:16:13 |
| 7       | 2020-01-04 13:57:59 |
| 2       | 2020-07-29 23:09:44 |
| 6       | 2020-12-09 10:39:37 |
+---------+---------------------+

Confirmations table:
+---------+---------------------+-----------+
| user_id | time_stamp          | action    |
+---------+---------------------+-----------+
| 3       | 2021-01-06 03:30:46 | timeout   |
| 3       | 2021-07-14 14:00:00 | timeout   |
| 7       | 2021-06-12 11:57:29 | confirmed |
| 7       | 2021-06-13 12:58:28 | confirmed |
| 7       | 2021-06-14 13:59:27 | confirmed |
| 2       | 2021-01-22 00:00:00 | confirmed |
| 2       | 2021-02-28 23:59:59 | timeout   |
+---------+---------------------+-----------+

Output: 
+---------+-------------------+
| user_id | confirmation_rate |
+---------+-------------------+
| 6       | 0.00              |
| 3       | 0.00              |
| 7       | 1.00              |
| 2       | 0.50              |
+---------+-------------------+

Explanation: 
- User 6 requested 0 messages -> rate = 0.00
- User 3 requested 2 messages, 0 confirmed -> rate = 0.00
- User 7 requested 3 messages, 3 confirmed -> rate = 1.00
- User 2 requested 2 messages, 1 confirmed -> rate = 0.50
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

SELECT s.user_id,
       ROUND(
         COALESCE(
           AVG(CASE WHEN c.action = 'confirmed' THEN 1.0 ELSE 0.0 END), 
           0
         ), 
         2
       ) AS confirmation_rate
FROM Signups AS s
LEFT JOIN Confirmations AS c
  ON s.user_id = c.user_id
GROUP BY s.user_id;