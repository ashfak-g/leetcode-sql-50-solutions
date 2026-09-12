/*
Problem 196: Delete Duplicate Emails

Table: Person
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
- id is the primary key (column with unique values) for this table.
- Each row of this table contains an email. The emails will not contain uppercase letters.

Task:
Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.
For SQL users, please note that you are supposed to write a DELETE statement and not a SELECT one.
After running your script, the answer shown is the Person table.

Example 1:
Input: 
Person table:
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+

Output: 
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+

Explanation: 
john@example.com is repeated two times. We keep the row with the smallest id = 1.
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

-- Approach 1: Self-Join DELETE

-- For PostgreSQL:
DELETE FROM Person AS p1
USING Person AS p2
WHERE p1.email = p2.email
  AND p1.id > p2.id;


-- For MySQL:
-- DELETE p1
-- FROM Person AS p1
-- JOIN Person AS p2
--   ON p1.email = p2.email
--  AND p1.id > p2.id;


-- Approach 2: Subquery with MIN(id)
-- DELETE FROM Person
-- WHERE id NOT IN (
--     SELECT min_id FROM (
--         SELECT MIN(id) AS min_id
--         FROM Person
--         GROUP BY email
--     ) AS temp
-- );
