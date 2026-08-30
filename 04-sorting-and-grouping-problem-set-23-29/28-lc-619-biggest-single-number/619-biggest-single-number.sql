/*
Problem 619: Biggest Single Number

Table: MyNumbers
+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
+-------------+------+
- This table may contain duplicates.
- A single number is a number that appeared only once.

Task:
Find the largest single number. If there is no single number, report null.

Example 1:
Input: 
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 3   |
| 3   |
| 1   |
| 4   |
| 5   |
| 6   |
+-----+

Output: 
+-----+
| num |
+-----+
| 6   |
+-----+

Explanation: 
Single numbers are 1, 4, 5, and 6. Largest is 6.

Example 2:
Input: 
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 7   |
| 7   |
| 3   |
| 3   |
| 3   |
+-----+

Output: 
+------+
| num  |
+------+
| null |
+------+

Explanation: 
No single numbers, return null.
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

SELECT MAX(num) AS num
FROM (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(*) = 1
) AS single_numbers;