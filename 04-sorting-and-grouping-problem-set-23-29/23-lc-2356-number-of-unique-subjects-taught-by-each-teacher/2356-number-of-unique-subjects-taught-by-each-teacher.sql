/*
Problem 2356: Number of Unique Subjects Taught by Each Teacher

Table: Teacher
+-------------+------+
| Column Name | Type |
+-------------+------+
| teacher_id  | int  |
| subject_id  | int  |
| dept_id     | int  |
+-------------+------+
- (subject_id, dept_id) is the primary key for this table.
- Indicates that teacher_id teaches subject_id in dept_id.

Task:
Write a solution to calculate the number of unique subjects each teacher teaches in the university.
Return the result table in any order.

Example 1:
Input: 
Teacher table:
+------------+------------+---------+
| teacher_id | subject_id | dept_id |
+------------+------------+---------+
| 1          | 2          | 3       |
| 1          | 2          | 4       |
| 1          | 3          | 3       |
| 2          | 1          | 1       |
| 2          | 2          | 1       |
| 2          | 3          | 1       |
| 2          | 4          | 1       |
+------------+------------+---------+

Output: 
+------------+-----+
| teacher_id | cnt |
+------------+-----+
| 1          | 2   |
| 2          | 4   |
+------------+-----+

Explanation: 
- Teacher 1 teaches subjects 2 and 3 -> 2 unique subjects.
- Teacher 2 teaches subjects 1, 2, 3, and 4 -> 4 unique subjects.
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

SELECT teacher_id,
       COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id;