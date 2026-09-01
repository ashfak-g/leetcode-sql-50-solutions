/*
Problem 1164: Product Price at a Given Date

Table: Products
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
- (product_id, change_date) is the primary key for this table.
- Initially, all products have price 10.

Task:
Write a solution to find the prices of all products on the date 2019-08-16.
Return the result table in any order.

Example 1:
Input: 
Products table:
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |
+------------+-----------+-------------+

Output: 
+------------+-------+
| product_id | price |
+------------+-------+
| 2          | 50    |
| 1          | 35    |
| 3          | 10    |
+------------+-------+

Explanation: 
- Product 1 price on 2019-08-16 = 35
- Product 2 price on 2019-08-16 = 50 (change on 17th ignored)
- Product 3 price on 2019-08-16 = 10 (default initial price)
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

SELECT p.product_id,
       COALESCE(x.new_price, 10) AS price
FROM (
    SELECT DISTINCT product_id
    FROM Products
) AS p
LEFT JOIN (
    SELECT product_id,
           new_price
    FROM Products
    WHERE (product_id, change_date) IN (
        SELECT product_id,
               MAX(change_date)
        FROM Products
        WHERE change_date <= '2019-08-16'
        GROUP BY product_id
    )
) AS x
  ON p.product_id = x.product_id;