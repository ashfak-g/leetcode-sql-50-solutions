/*
Problem 1729: Find Followers Count

Table: Followers
+-------------+------+
| Column Name | Type |
+-------------+------+
| user_id     | int  |
| follower_id | int  |
+-------------+------+
- (user_id, follower_id) is the primary key for this table.
- Contains the IDs of a user and a follower following that user.

Task:
Write a solution that will, for each user, return the number of followers.
Return the result table ordered by user_id in ascending order.

Example 1:
Input: 
Followers table:
+---------+-------------+
| user_id | follower_id |
+---------+-------------+
| 0       | 1           |
| 1       | 0           |
| 2       | 0           |
| 2       | 1           |
+---------+-------------+

Output: 
+---------+----------------+
| user_id | followers_count|
+---------+----------------+
| 0       | 1              |
| 1       | 1              |
| 2       | 2              |
+---------+----------------+

Explanation: 
- User 0 followed by {1} -> count = 1
- User 1 followed by {0} -> count = 1
- User 2 followed by {0, 1} -> count = 2
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

SELECT user_id,
       COUNT(follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id ASC;