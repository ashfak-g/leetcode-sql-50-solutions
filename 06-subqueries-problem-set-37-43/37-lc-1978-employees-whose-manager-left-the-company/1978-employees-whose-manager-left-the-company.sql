/*
Problem 1978: Employees Whose Manager Left the Company

Table: Employees
+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| manager_id  | int      |
| salary      | int      |
+-------------+----------+
- employee_id is the primary key for this table.
- Some employees do not have a manager (manager_id is null).

Task:
Find the IDs of the employees whose salary is strictly less than $30000 
and whose manager left the company.
When a manager leaves the company, their information is deleted from Employees table, 
but reports still have manager_id set to that manager.
Return the result table ordered by employee_id ASC.

Example 1:
Input: 
Employees table:
+-------------+-----------+------------+--------+
| employee_id | name      | manager_id | salary |
+-------------+-----------+------------+--------+
| 3           | Mila      | 9          | 60301  |
| 12          | Antonella | null       | 31000  |
| 13          | Emery     | null       | 67084  |
| 1           | Kalel     | 11         | 21241  |
| 9           | Mikaela   | null       | 50937  |
| 11          | Joziah    | 6          | 28485  |
+-------------+-----------+------------+--------+

Output: 
+-------------+
| employee_id |
+-------------+
| 11          |
+-------------+

Explanation: 
- Employees with salary < $30000 are 1 (Kalel) and 11 (Joziah).
- Kalel's manager is 11 (still in company).
- Joziah's manager is 6 (left company, deleted from table).
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

-- Approach 1: LEFT JOIN
SELECT e.employee_id
FROM Employees AS e
LEFT JOIN Employees AS m
  ON e.manager_id = m.employee_id
WHERE e.salary < 30000
  AND e.manager_id IS NOT NULL
  AND m.employee_id IS NULL
ORDER BY e.employee_id ASC;


-- Approach 2: Subquery (Alternative)
-- SELECT employee_id
-- FROM Employees
-- WHERE salary < 30000
--   AND manager_id IS NOT NULL
--   AND manager_id NOT IN (
--       SELECT employee_id
--       FROM Employees
--   )
-- ORDER BY employee_id ASC;