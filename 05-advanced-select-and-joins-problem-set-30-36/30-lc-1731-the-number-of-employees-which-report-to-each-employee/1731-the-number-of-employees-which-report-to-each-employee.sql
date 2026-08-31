/*
Problem 1731: The Number of Employees Which Report to Each Employee

Table: Employees
+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| reports_to  | int      |
| age         | int      |
+-------------+----------+
- employee_id is the primary key for this table.
- Contains information about employees and manager IDs they report to.

Task:
Write a solution to report the ids and names of all managers, 
the number of employees who report directly to them (reports_count), 
and the average age of the reports rounded to the nearest integer (average_age).
Return the result table ordered by employee_id ASC.

Example 1:
Input: 
Employees table:
+-------------+---------+------------+-----+
| employee_id | name    | reports_to | age |
+-------------+---------+------------+-----+
| 9           | Hercy   | null       | 43  |
| 6           | Alice   | 9          | 41  |
| 4           | Bob     | 9          | 36  |
| 2           | Winston | null       | 37  |
+-------------+---------+------------+-----+

Output: 
+-------------+-------+---------------+-------------+
| employee_id | name  | reports_count | average_age |
+-------------+-------+---------------+-------------+
| 9           | Hercy | 2             | 39          |
+-------------+-------+---------------+-------------+

Explanation: 
Hercy has 2 direct reports (Alice & Bob). Avg age = (41 + 36) / 2 = 38.5 -> 39.
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

SELECT manager.employee_id,
       manager.name,
       COUNT(employee.employee_id) AS reports_count,
       ROUND(AVG(employee.age)) AS average_age
FROM Employees AS manager
JOIN Employees AS employee
  ON manager.employee_id = employee.reports_to
GROUP BY manager.employee_id,
         manager.name
ORDER BY manager.employee_id ASC;