/*
Problem 570: Managers with at Least 5 Direct Reports

Table: Employee
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
- id is the primary key for this table.
- Each row indicates the name, department, and manager ID of an employee.
- No employee will be the manager of themselves.

Task:
Write a solution to find managers with at least five direct reports.
Return the result table in any order.

Example 1:
Input: 
Employee table:
+-----+-------+------------+-----------+
| id  | name  | department | managerId |
+-----+-------+------------+-----------+
| 101 | John  | A          | null      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |
+-----+-------+------------+-----------+

Output: 
+------+
| name |
+------+
| John |
+------+

Explanation: 
- John (id = 101) has 5 direct reports (Dan, James, Amy, Anne, Ron).
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

SELECT manager.name
FROM Employee AS manager
JOIN Employee AS employee
  ON employee.managerId = manager.id
GROUP BY manager.id, manager.name
HAVING COUNT(employee.id) >= 5;