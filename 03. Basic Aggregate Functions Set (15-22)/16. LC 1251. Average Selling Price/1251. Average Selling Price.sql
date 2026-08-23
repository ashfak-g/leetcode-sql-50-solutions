/*
Problem 1251: Average Selling Price

Table: Prices
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| start_date    | date    |
| end_date      | date    |
| price         | int     |
+---------------+---------+
- (product_id, start_date, end_date) is the primary key for this table.
- Indicates the price of product_id in the period from start_date to end_date.

Table: UnitsSold
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| purchase_date | date    |
| units         | int     |
+---------------+---------+
- Indicates the date, units, and product_id of each product sold.

Task:
Write a solution to find the average selling price for each product rounded to 2 decimal places. 
If a product has no sold units, its average selling price is assumed to be 0.
Return the result table in any order.

Example 1:
Input: 
Prices table:
+------------+------------+------------+--------+
| product_id | start_date | end_date   | price  |
+------------+------------+------------+--------+
| 1          | 2019-02-17 | 2019-02-28 | 5      |
| 1          | 2019-03-01 | 2019-03-22 | 20     |
| 2          | 2019-02-01 | 2019-02-20 | 15     |
| 2          | 2019-02-21 | 2019-03-31 | 30     |
+------------+------------+------------+--------+

UnitsSold table:
+------------+---------------+-------+
| product_id | purchase_date | units |
+------------+---------------+-------+
| 1          | 2019-02-25    | 100   |
| 1          | 2019-03-01    | 15    |
| 2          | 2019-02-10    | 200   |
| 2          | 2019-03-22    | 30    |
+------------+---------------+-------+

Output: 
+------------+---------------+
| product_id | average_price |
+------------+---------------+
| 1          | 6.96          |
| 2          | 16.96         |
+------------+---------------+

Explanation: 
- Product 1: ((100 * 5) + (15 * 20)) / 115 = 6.96
- Product 2: ((200 * 15) + (30 * 30)) / 230 = 16.96
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

SELECT Prices.product_id,
       COALESCE(
         ROUND(
           SUM(units * price)::numeric / SUM(units),
           2
         ),
         0
       ) AS average_price
FROM Prices
LEFT JOIN UnitsSold
  ON Prices.product_id = UnitsSold.product_id
 AND UnitsSold.purchase_date BETWEEN Prices.start_date AND Prices.end_date
GROUP BY Prices.product_id;