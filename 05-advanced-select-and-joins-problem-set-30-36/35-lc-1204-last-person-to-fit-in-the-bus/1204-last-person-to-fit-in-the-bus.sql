/*
Problem 1204: Last Person to Fit in the Bus

Table: Queue
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| person_id   | int     |
| person_name | varchar |
| weight      | int     |
| turn        | int     |
+-------------+---------+
- person_id contains unique values.
- turn determines the boarding order (1 = first, n = last).
- Bus weight limit is 1000 kg.

Task:
Find the person_name of the last person that can fit on the bus without exceeding 1000 kg.

Example 1:
Input: 
Queue table:
+-----------+-------------+--------+------+
| person_id | person_name | weight | turn |
+-----------+-------------+--------+------+
| 5         | Alice       | 250    | 1    |
| 4         | Bob         | 175    | 5    |
| 3         | Alex        | 350    | 2    |
| 6         | John Cena   | 400    | 3    |
| 1         | Winston     | 500    | 6    |
| 2         | Marie       | 200    | 4    |
+-----------+-------------+--------+------+

Output: 
+-------------+
| person_name |
+-------------+
| John Cena   |
+-------------+

Explanation: 
- Turn 1 (Alice): 250 kg
- Turn 2 (Alex): 600 kg
- Turn 3 (John Cena): 1000 kg (last to fit)
- Turn 4 (Marie): 1200 kg (exceeds limit)
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

SELECT person_name
FROM (
    SELECT person_name,
           turn,
           SUM(weight) OVER (ORDER BY turn) AS total_weight
    FROM Queue
) AS q
WHERE total_weight <= 1000
ORDER BY turn DESC
LIMIT 1;