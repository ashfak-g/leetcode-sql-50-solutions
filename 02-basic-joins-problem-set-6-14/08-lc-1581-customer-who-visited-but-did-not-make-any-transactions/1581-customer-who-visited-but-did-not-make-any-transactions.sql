/*
Problem 1581: Customer Who Visited but Did Not Make Any Transactions

Table: Visits
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| visit_id    | int     |
| customer_id | int     |
+-------------+---------+
- visit_id is the primary key for this table.
- This table contains information about customers who visited the mall.

Table: Transactions
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| transaction_id | int     |
| visit_id       | int     |
| amount         | int     |
+----------------+---------+
- transaction_id is the primary key for this table.
- This table contains information about transactions made during visit_id.

Task:
Write a solution to find the IDs of users who visited without making any transactions 
and the number of times they made these types of visits.
Return the result table in any order.

Example 1:
Input: 
Visits table:
+----------+-------------+
| visit_id | customer_id |
+----------+-------------+
| 1        | 23          |
| 2        | 9           |
| 4        | 30          |
| 5        | 54          |
| 6        | 96          |
| 7        | 54          |
| 8        | 54          |
+----------+-------------+

Transactions table:
+----------------+----------+--------+
| transaction_id | visit_id | amount |
+----------------+----------+--------+
| 2              | 5        | 310    |
| 3              | 5        | 300    |
| 9              | 5        | 200    |
| 12             | 1        | 910    |
| 13             | 2        | 970    |
+----------------+----------+--------+

Output: 
+-------------+----------------+
| customer_id | count_no_trans |
+-------------+----------------+
| 54          | 2              |
| 30          | 1              |
| 96          | 1              |
+-------------+----------------+

Explanation: 
- Customer 23 visited once and made 1 transaction.
- Customer 9 visited once and made 1 transaction.
- Customer 30 visited once and made 0 transactions.
- Customer 54 visited 3 times, made transactions during 1 visit, and 0 transactions during 2 visits.
- Customer 96 visited once and made 0 transactions.
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

SELECT Visits.customer_id, 
       COUNT(*) AS count_no_trans
FROM Visits
LEFT JOIN Transactions
  ON Visits.visit_id = Transactions.visit_id
WHERE Transactions.transaction_id IS NULL
GROUP BY Visits.customer_id;