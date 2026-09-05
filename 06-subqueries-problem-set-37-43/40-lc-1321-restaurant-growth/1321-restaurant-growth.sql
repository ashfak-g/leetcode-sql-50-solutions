/*
Problem 1321: Restaurant Growth

Table: Customer
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| visited_on    | date    |
| amount        | int     |
+---------------+---------+
- (customer_id, visited_on) is the primary key for this table.
- This table contains data about customer transactions in a restaurant.
- visited_on is the date on which the customer with ID (customer_id) visited the restaurant.
- amount is the total paid by a customer.

Task:
Compute the moving average of how much the customer paid in a seven days window 
(i.e., current day + 6 days before). 
average_amount should be rounded to two decimal places.
Return the result table ordered by visited_on in ascending order.

Example 1:
Input: 
Customer table:
+-------------+--------------+--------------+-------------+
| customer_id | name         | visited_on   | amount      |
+-------------+--------------+--------------+-------------+
| 1           | Jhon         | 2019-01-01   | 100         |
| 2           | Daniel       | 2019-01-02   | 110         |
| 3           | Jade         | 2019-01-03   | 120         |
| 4           | Khaled       | 2019-01-04   | 130         |
| 5           | Winston      | 2019-01-05   | 110         | 
| 6           | Elvis        | 2019-01-06   | 140         | 
| 7           | Anna         | 2019-01-07   | 150         |
| 8           | Maria        | 2019-01-08   | 80          |
| 9           | Jaze         | 2019-01-09   | 110         | 
| 1           | Jhon         | 2019-01-10   | 130         | 
| 3           | Jade         | 2019-01-10   | 150         | 
+-------------+--------------+--------------+-------------+

Output: 
+--------------+--------------+----------------+
| visited_on   | amount       | average_amount |
+--------------+--------------+----------------+
| 2019-01-07   | 860          | 122.86         |
| 2019-01-08   | 840          | 120            |
| 2019-01-09   | 840          | 120            |
| 2019-01-10   | 1000         | 142.86         |
+--------------+--------------+----------------+

Explanation: 
- 1st moving average (2019-01-01 to 2019-01-07): amount = (100+110+120+130+110+140+150) = 860, avg = 860/7 = 122.86
- 2nd moving average (2019-01-02 to 2019-01-08): amount = (110+120+130+110+140+150+80) = 840, avg = 840/7 = 120
- 3rd moving average (2019-01-03 to 2019-01-09): amount = (120+130+110+140+150+80+110) = 840, avg = 840/7 = 120
- 4th moving average (2019-01-04 to 2019-01-10): amount = (130+110+140+150+80+110+130+150) = 1000, avg = 1000/7 = 142.86
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

-- Approach 1: Window Functions (Cross-Platform)
WITH DailySpending AS (
    SELECT
        visited_on,
        SUM(amount) AS amount
    FROM Customer
    GROUP BY visited_on
),
MovingMetrics AS (
    SELECT
        visited_on,
        SUM(amount) OVER (
            ORDER BY visited_on
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS amount,
        ROUND(
            SUM(amount) OVER (
                ORDER BY visited_on
                ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
            ) / 7.0,
            2
        ) AS average_amount,
        ROW_NUMBER() OVER (ORDER BY visited_on) AS row_num
    FROM DailySpending
)
SELECT
    visited_on,
    amount,
    average_amount
FROM MovingMetrics
WHERE row_num >= 7
ORDER BY visited_on ASC;


-- Approach 2: PostgreSQL (Using INTERVAL filter)
-- WITH daily AS (
--     SELECT
--         visited_on,
--         SUM(amount) AS amount
--     FROM Customer
--     GROUP BY visited_on
-- ),
-- result AS (
--     SELECT
--         visited_on,
--         SUM(amount) OVER (
--             ORDER BY visited_on
--             ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
--         ) AS amount,
--         ROUND(
--             SUM(amount) OVER (
--                 ORDER BY visited_on
--                 ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
--             ) / 7.0,
--             2
--         ) AS average_amount
--     FROM daily
-- )
-- SELECT
--     visited_on,
--     amount,
--     average_amount
-- FROM result
-- WHERE visited_on >= (
--     SELECT MIN(visited_on) + INTERVAL '6 days'
--     FROM Customer
-- )
-- ORDER BY visited_on;
