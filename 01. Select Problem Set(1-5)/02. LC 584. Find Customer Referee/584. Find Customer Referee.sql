/*
Problem 584: Find Customer Referee

Table: Customer
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| referee_id  | int     |
+-------------+---------+
- id is the primary key column for this table.
- Each row indicates the customer ID, name, and referee ID.

Task:
Find the names of the customer that are either:
- referred by any customer with id != 2
- not referred by any customer (referee_id IS NULL)
Return the result table in any order.

Example 1:
Input: 
Customer table:
+----+------+------------+
| id | name | referee_id |
+----+------+------------+
| 1  | Will | null       |
| 2  | Jane | null       |
| 3  | Alex | 2          |
| 4  | Bill | null       |
| 5  | Zack | 1          |
| 6  | Mark | 2          |
+----+------+------------+

Output: 
+------+
| name |
+------+
| Will |
| Jane |
| Bill |
| Zack |
+------+
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

SELECT name
FROM Customer
WHERE referee_id != 2
   OR referee_id IS NULL;
