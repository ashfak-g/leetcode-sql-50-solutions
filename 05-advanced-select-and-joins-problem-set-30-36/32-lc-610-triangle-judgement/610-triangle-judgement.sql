/*
Problem 610: Triangle Judgement

Table: Triangle
+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
| z           | int  |
+-------------+------+
- (x, y, z) is the primary key for this table.
- Contains lengths of three line segments.

Task:
Report for every three line segments whether they can form a triangle ('Yes' or 'No').
Triangle inequality theorem: x + y > z AND x + z > y AND y + z > x.
Return the result table in any order.

Example 1:
Input: 
Triangle table:
+----+----+----+
| x  | y  | z  |
+----+----+----+
| 13 | 15 | 30 |
| 10 | 20 | 15 |
+----+----+----+

Output: 
+----+----+----+----------+
| x  | y  | z  | triangle |
+----+----+----+----------+
| 13 | 15 | 30 | No       |
| 10 | 20 | 15 | Yes      |
+----+----+----+----------+

Explanation: 
- 13 + 15 = 28 < 30 -> No
- 10 + 20 > 15, 10 + 15 > 20, 20 + 15 > 10 -> Yes
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

SELECT x, y, z,
       CASE 
           WHEN x + y > z 
            AND x + z > y 
            AND z + y > x 
           THEN 'Yes'
           ELSE 'No'
       END AS triangle
FROM Triangle;