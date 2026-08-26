/*
Problem 1174: Immediate Food Delivery II

Table: Delivery
+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
- delivery_id is the primary key for this table.
- An order is immediate if order_date = customer_pref_delivery_date; otherwise scheduled.
- First order of a customer is the order with earliest order_date.

Task:
Write a solution to find the percentage of immediate orders in the first orders of all customers, 
rounded to 2 decimal places.

Example 1:
Input: 
Delivery table:
+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 2           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-12                  |
| 4           | 3           | 2019-08-24 | 2019-08-24                  |
| 5           | 3           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
| 7           | 4           | 2019-08-09 | 2019-08-09                  |
+-------------+-------------+------------+-----------------------------+

Output: 
+----------------------+
| immediate_percentage |
+----------------------+
| 50.00                |
+----------------------+

Explanation: 
- Customer 1 first order: delivery 1 (scheduled)
- Customer 2 first order: delivery 2 (immediate)
- Customer 3 first order: delivery 5 (scheduled)
- Customer 4 first order: delivery 7 (immediate)
- Immediate first orders: 2 / 4 = 50.00%
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

SELECT ROUND(
         AVG(CASE WHEN order_date = customer_pref_delivery_date THEN 1.0 ELSE 0.0 END) * 100,
         2
       ) AS immediate_percentage
FROM Delivery
WHERE (customer_id, order_date) IN (
    SELECT customer_id, MIN(order_date)
    FROM Delivery
    GROUP BY customer_id
);