/*
Problem 1661: Average Time of Process per Machine

Table: Activity
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| machine_id     | int     |
| process_id     | int     |
| activity_type  | enum    |
| timestamp      | float   |
+----------------+---------+
- (machine_id, process_id, activity_type) is the primary key for this table.
- activity_type is an ENUM ('start', 'end').
- timestamp represents current time in seconds.
- Each (machine_id, process_id) pair has a 'start' and 'end' timestamp.

Task:
Write a solution to find the average time each machine takes to complete a process.
The time to complete a process is 'end' timestamp minus 'start' timestamp.
The average time is total processing time divided by number of processes.
Round processing_time to 3 decimal places.
Return the result table in any order.

Example 1:
Input: 
Activity table:
+------------+------------+---------------+-----------+
| machine_id | process_id | activity_type | timestamp |
+------------+------------+---------------+-----------+
| 0          | 0          | start         | 0.712     |
| 0          | 0          | end           | 1.520     |
| 0          | 1          | start         | 3.140     |
| 0          | 1          | end           | 4.120     |
| 1          | 0          | start         | 0.550     |
| 1          | 0          | end           | 1.550     |
| 1          | 1          | start         | 0.430     |
| 1          | 1          | end           | 1.420     |
| 2          | 0          | start         | 4.100     |
| 2          | 0          | end           | 4.512     |
| 2          | 1          | start         | 2.500     |
| 2          | 1          | end           | 5.000     |
+------------+------------+---------------+-----------+

Output: 
+------------+-----------------+
| machine_id | processing_time |
+------------+-----------------+
| 0          | 0.894           |
| 1          | 0.995           |
| 2          | 1.456           |
+------------+-----------------+

Explanation: 
- Machine 0: ((1.520 - 0.712) + (4.120 - 3.140)) / 2 = 0.894
- Machine 1: ((1.550 - 0.550) + (1.420 - 0.430)) / 2 = 0.995
- Machine 2: ((4.512 - 4.100) + (5.000 - 2.500)) / 2 = 1.456
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

SELECT a1.machine_id,
       ROUND(AVG(a2.timestamp - a1.timestamp)::numeric, 3) AS processing_time
FROM Activity AS a1
JOIN Activity AS a2
  ON a1.machine_id = a2.machine_id
 AND a1.process_id = a2.process_id
WHERE a1.activity_type = 'start'
  AND a2.activity_type = 'end'
GROUP BY a1.machine_id;