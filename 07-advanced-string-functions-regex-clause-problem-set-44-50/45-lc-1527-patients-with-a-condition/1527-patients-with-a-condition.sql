/*
Problem 1527: Patients With a Condition

Table: Patients
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| patient_id   | int     |
| patient_name | varchar |
| conditions   | varchar |
+--------------+---------+
- patient_id is the primary key (column with unique values) for this table.
- 'conditions' contains 0 or more codes separated by spaces. 
- This table contains information about the patients in the hospital.

Task:
Write a solution to find the patient_id, patient_name, and conditions of the patients 
who have Type I Diabetes. 
Type I Diabetes always starts with the DIAB1 prefix.
Return the result table in any order.

Example 1:
Input: 
Patients table:
+------------+--------------+--------------+
| patient_id | patient_name | conditions   |
+------------+--------------+--------------+
| 1          | Daniel       | YFEV COUGH   |
| 2          | Alice        |              |
| 3          | Bob          | DIAB100 MYOP |
| 4          | George       | ACNE DIAB100 |
| 5          | Alain        | DIAB201      |
+------------+--------------+--------------+

Output: 
+------------+--------------+--------------+
| patient_id | patient_name | conditions   |
+------------+--------------+--------------+
| 3          | Bob          | DIAB100 MYOP |
| 4          | George       | ACNE DIAB100 | 
+------------+--------------+--------------+

Explanation: 
Bob and George both have a condition that starts with DIAB1.
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

-- Approach 1: Using LIKE with Wildcards (Cross-Platform & Optimal)
SELECT patient_id,
       patient_name,
       conditions
FROM Patients
WHERE conditions LIKE 'DIAB1%'
   OR conditions LIKE '% DIAB1%';


-- Approach 2: Using Regular Expression (Alternative)
-- MySQL:
-- SELECT patient_id, patient_name, conditions
-- FROM Patients
-- WHERE conditions REGEXP '(^|[[:space:]])DIAB1';
--
-- PostgreSQL:
-- SELECT patient_id, patient_name, conditions
-- FROM Patients
-- WHERE conditions ~ '(^|\\s)DIAB1';
