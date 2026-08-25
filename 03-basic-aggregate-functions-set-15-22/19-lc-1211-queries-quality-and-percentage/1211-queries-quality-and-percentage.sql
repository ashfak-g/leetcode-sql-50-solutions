/*
Problem 1211: Queries Quality and Percentage

Table: Queries
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| query_name  | varchar |
| result      | varchar |
| position    | int     |
| rating      | int     |
+-------------+---------+
- Position value ranges from 1 to 500.
- Rating value ranges from 1 to 5. Rating < 3 is a poor query.

Task:
Write a solution to find each query_name, quality, and poor_query_percentage.
- Query quality: average of ratio between query rating and its position.
- Poor query percentage: percentage of all queries with rating < 3.
Round both metrics to 2 decimal places.
Return the result table in any order.

Example 1:
Input: 
Queries table:
+------------+-------------------+----------+--------+
| query_name | result            | position | rating |
+------------+-------------------+----------+--------+
| Dog        | Golden Retriever  | 1        | 5      |
| Dog        | German Shepherd   | 2        | 5      |
| Dog        | Mule              | 200      | 1      |
| Cat        | Shirazi           | 5        | 2      |
| Cat        | Siamese           | 3        | 3      |
| Cat        | Sphynx            | 7        | 4      |
+------------+-------------------+----------+--------+

Output: 
+------------+---------+-----------------------+
| query_name | quality | poor_query_percentage |
+------------+---------+-----------------------+
| Dog        | 2.50    | 33.33                 |
| Cat        | 0.66    | 33.33                 |
+------------+---------+-----------------------+

Explanation: 
- Dog quality: ((5/1) + (5/2) + (1/200)) / 3 = 2.50
- Dog poor%: (1/3) * 100 = 33.33%
- Cat quality: ((2/5) + (3/3) + (4/7)) / 3 = 0.66
- Cat poor%: (1/3) * 100 = 33.33%
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

SELECT query_name,
       ROUND(AVG(rating * 1.0 / position), 2) AS quality,
       ROUND(AVG(CASE WHEN rating < 3 THEN 1.0 ELSE 0.0 END) * 100, 2) AS poor_query_percentage
FROM Queries
WHERE query_name IS NOT NULL
GROUP BY query_name;