/*
Problem 1667: Fix Names in a Table

Table: Users
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| name           | varchar |
+----------------+---------+
- user_id is the primary key (column with unique values) for this table.
- This table contains the ID and the name of the user. 
- The name consists of only lowercase and uppercase characters.

Task:
Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.
Return the result table ordered by user_id.

Example 1:
Input: 
Users table:
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | aLice |
| 2       | bOB   |
+---------+-------+

Output: 
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | Alice |
| 2       | Bob   |
+---------+-------+
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

-- Approach 1: Using CONCAT(), UPPER(), and LOWER() (Cross-Platform)
SELECT user_id,
       CONCAT(UPPER(LEFT(name, 1)), LOWER(SUBSTR(name, 2))) AS name
FROM Users
ORDER BY user_id ASC;


-- Approach 2: PostgreSQL (Using || concatenation operator)
-- SELECT user_id,
--        UPPER(LEFT(name, 1)) || LOWER(SUBSTRING(name FROM 2)) AS name
-- FROM Users
-- ORDER BY user_id ASC;
