/*
Problem 585: Investments in 2016

Table: Insurance
+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| pid         | int   |
| tiv_2015    | float |
| tiv_2016    | float |
| lat         | float |
| lon         | float |
+-------------+-------+
- pid is the primary key (column with unique values) for this table.
- Each row contains information about one policy:
  - pid: policyholder's policy ID.
  - tiv_2015: total investment value in 2015.
  - tiv_2016: total investment value in 2016.
  - lat: latitude of the policyholder's city (not NULL).
  - lon: longitude of the policyholder's city (not NULL).

Task:
Write a solution to report the sum of all total investment values in 2016 (tiv_2016) 
for all policyholders who:
1. Have the same tiv_2015 value as one or more other policyholders, and
2. Are not located in the same city as any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).

Round tiv_2016 to two decimal places.

Example 1:
Input: 
Insurance table:
+-----+----------+----------+-----+-----+
| pid | tiv_2015 | tiv_2016 | lat | lon |
+-----+----------+----------+-----+-----+
| 1   | 10       | 5        | 10  | 10  |
| 2   | 20       | 20       | 20  | 20  |
| 3   | 10       | 30       | 20  | 20  |
| 4   | 10       | 40       | 40  | 40  |
+-----+----------+----------+-----+-----+

Output: 
+----------+
| tiv_2016 |
+----------+
| 45.00    |
+----------+

Explanation: 
- 1st record (pid 1): tiv_2015 is 10 (shared with pid 3 and 4), and location (10, 10) is unique -> Valid.
- 2nd record (pid 2): tiv_2015 is 20 (unique, not shared), and location (20, 20) is shared with pid 3 -> Invalid.
- 3rd record (pid 3): tiv_2015 is 10 (shared), but location (20, 20) is shared with pid 2 -> Invalid.
- 4th record (pid 4): tiv_2015 is 10 (shared with pid 1 and 3), and location (40, 40) is unique -> Valid.
- Result = 5 + 40 = 45.00.
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

-- Approach 1: Subqueries with IN (Standard Subquery Method)
-- MySQL:
-- SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
-- PostgreSQL:
SELECT ROUND(SUM(tiv_2016)::numeric, 2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN (
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1
)
AND (lat, lon) IN (
    SELECT lat, lon
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1
);


-- Approach 2: Window Functions (Alternative)
-- SELECT ROUND(SUM(tiv_2016)::numeric, 2) AS tiv_2016
-- FROM (
--     SELECT tiv_2016,
--            COUNT(*) OVER (PARTITION BY tiv_2015) AS count_tiv_2015,
--            COUNT(*) OVER (PARTITION BY lat, lon) AS count_lat_lon
--     FROM Insurance
-- ) AS FilteredInsurance
-- WHERE count_tiv_2015 > 1
--   AND count_lat_lon = 1;
