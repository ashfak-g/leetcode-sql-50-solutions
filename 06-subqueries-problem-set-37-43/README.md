# 📌 Section 06: Subqueries Problem Set (LeetCode SQL 50)

Welcome to the **Subqueries Problem Set** section! This directory contains my personal solutions for problems 37 through 43 from the **LeetCode SQL 50** study plan.

This section covers core and advanced subquery paradigms in SQL, including correlated and uncorrelated subqueries, membership testing (`IN` / `NOT IN`), non-existence filtering (`LEFT JOIN ... IS NULL`), multi-criteria ranking combined via `UNION ALL`, rolling moving-window calculations (`ROWS BETWEEN 6 PRECEDING AND CURRENT ROW`), bidirectional graph aggregation via `UNION ALL`, tuple comparison subqueries `(lat, lon) IN (...)`, and top-N ranking per department using `DENSE_RANK()`.

---

## 📊 Summary of Problems

| # | Problem Name | Difficulty | Key Concepts Covered |
| :--- | :--- | :--- | :--- |
| **37** | [1978. Employees Whose Manager Left the Company](./37-lc-1978-employees-whose-manager-left-the-company) | Easy | `LEFT JOIN` / Subquery (`NOT IN`), `IS NULL` |
| **38** | [626. Exchange Seats](./38-lc-626-exchange-seats) | Medium | `CASE WHEN`, Modulo (`% 2`), Subquery (`MAX(id)`) |
| **39** | [1341. Movie Rating](./39-lc-1341-movie-rating) | Medium | `UNION ALL`, Subqueries, Date Filtering, `ORDER BY ... LIMIT 1` |
| **40** | [1321. Restaurant Growth](./40-lc-1321-restaurant-growth) | Medium | CTE, Window Functions (`ROWS BETWEEN 6 PRECEDING`), `ROW_NUMBER()` |
| **41** | [602. Friend Requests II: Who Has the Most Friends](./41-lc-602-friend-requests-ii-who-has-the-most-friends) | Medium | `UNION ALL`, Bidirectional Symmetry, `GROUP BY`, `COUNT(*)` |
| **42** | [585. Investments in 2016](./42-lc-585-investments-in-2016) | Medium | Tuple `IN` Subquery, `GROUP BY ... HAVING COUNT(*)`, `ROUND()` |
| **43** | [185. Department Top Three Salaries](./43-lc-185-department-top-three-salaries) | Hard | Window Function (`DENSE_RANK()`), `PARTITION BY`, Correlated Subquery |

---

## 📝 Detailed Solutions & Explanations

### 37. [LC 1978: Employees Whose Manager Left the Company](./37-lc-1978-employees-whose-manager-left-the-company)

#### 📋 Problem Statement:
Find the IDs of the employees whose salary is strictly less than `$30000` and whose manager left the company. When a manager leaves the company, their information is deleted from the `Employees` table, but their former reports still retain their `manager_id`. Return the result table ordered by `employee_id` in ascending order.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

-- Approach 1: LEFT JOIN
SELECT e.employee_id
FROM Employees AS e
LEFT JOIN Employees AS m
  ON e.manager_id = m.employee_id
WHERE e.salary < 30000
  AND e.manager_id IS NOT NULL
  AND m.employee_id IS NULL
ORDER BY e.employee_id ASC;
```

#### 💡 Explanation & Comment:
- Perform a `LEFT JOIN` on `Employees` with itself matching `e.manager_id = m.employee_id`.
- Filter employees earning strictly under $30,000 (`e.salary < 30000`).
- Ensure they actually have a manager assigned (`e.manager_id IS NOT NULL`).
- Check that the manager no longer exists in the table (`m.employee_id IS NULL`).
- *Alternative Subquery Approach*: `WHERE manager_id NOT IN (SELECT employee_id FROM Employees)`.

---

### 38. [LC 626: Exchange Seats](./38-lc-626-exchange-seats)

#### 📋 Problem Statement:
Write a solution to swap the seat id of every two consecutive students. If the total number of students is odd, the `id` of the last student is not swapped. Return the result table ordered by `id` in ascending order.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT CASE
           WHEN id % 2 = 1 AND id = (SELECT MAX(id) FROM Seat) THEN id
           WHEN id % 2 = 1 THEN id + 1
           ELSE id - 1
       END AS id,
       student
FROM Seat
ORDER BY id ASC;
```

#### 💡 Explanation & Comment:
- Use conditional `CASE WHEN` logic with modulo arithmetic:
  1. For the last student in an odd-sized table (`id % 2 = 1 AND id = (SELECT MAX(id) FROM Seat)`), keep `id` unchanged.
  2. For other odd seat IDs (`id % 2 = 1`), increment by 1 (`id + 1`) to swap forward.
  3. For even seat IDs, decrement by 1 (`id - 1`) to swap backward.
- Sort the resulting output by the swapped `id ASC`.

---

### 39. [LC 1341: Movie Rating](./39-lc-1341-movie-rating)

#### 📋 Problem Statement:
Write a solution to find the name of the user who has rated the greatest number of movies (in case of a tie, return the lexicographically smaller user name), and find the movie name with the highest average rating in February 2020 (in case of a tie, return the lexicographically smaller movie name). Return the combined results in a single column table.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

(
    SELECT u.name AS results
    FROM Users AS u
    JOIN MovieRating AS mr
      ON u.user_id = mr.user_id
    GROUP BY u.user_id, u.name
    ORDER BY COUNT(*) DESC, u.name ASC
    LIMIT 1
)

UNION ALL

(
    SELECT m.title AS results
    FROM Movies AS m
    JOIN MovieRating AS mr
      ON m.movie_id = mr.movie_id
    WHERE mr.created_at >= '2020-02-01'
      AND mr.created_at < '2020-03-01'
    GROUP BY m.movie_id, m.title
    ORDER BY AVG(mr.rating) DESC, m.title ASC
    LIMIT 1
);
```

#### 💡 Explanation & Comment:
- **Top Reviewer**: Join `Users` and `MovieRating`, group by user, and order by `COUNT(*) DESC, u.name ASC LIMIT 1`.
- **Top Movie in Feb 2020**: Join `Movies` and `MovieRating`, filter for February 2020 (`created_at >= '2020-02-01' AND created_at < '2020-03-01'`), group by movie, and order by `AVG(mr.rating) DESC, m.title ASC LIMIT 1`.
- Combine both queries using `UNION ALL` to return a 2-row result under the column alias `results`.

---

### 40. [LC 1321: Restaurant Growth](./40-lc-1321-restaurant-growth)

#### 📋 Problem Statement:
Compute the moving average of how much the customers paid in a seven-day window (current day + 6 days before). Round `average_amount` to two decimal places. Return the result table ordered by `visited_on` in ascending order.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

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
```

#### 💡 Explanation & Comment:
- Aggregate daily total spending per date using `GROUP BY visited_on` in a CTE (`DailySpending`).
- Use window functions with a rolling window specification: `ROWS BETWEEN 6 PRECEDING AND CURRENT ROW` to calculate the 7-day rolling sum and average.
- Assign sequential row numbers using `ROW_NUMBER() OVER (ORDER BY visited_on)`.
- Since at least one customer visits every day, the first 6 days have fewer than 7 days of historical data. Filter them out using `WHERE row_num >= 7`.

---

### 41. [LC 602: Friend Requests II: Who Has the Most Friends](./41-lc-602-friend-requests-ii-who-has-the-most-friends)

#### 📋 Problem Statement:
Find the people who have the most friends and the most friends number. The test cases guarantee that only one person has the most friends.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

WITH AllFriends AS (
    SELECT requester_id AS id
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id
    FROM RequestAccepted
)
SELECT id,
       COUNT(*) AS num
FROM AllFriends
GROUP BY id
ORDER BY num DESC
LIMIT 1;
```

#### 💡 Explanation & Comment:
- Friendship is bidirectional: each accepted request counts as a friend for both the requester and the accepter.
- Stack both `requester_id` and `accepter_id` together using `UNION ALL`.
- Group by `id`, count friends using `COUNT(*)`, and order by `num DESC LIMIT 1`.

---

### 42. [LC 585: Investments in 2016](./42-lc-585-investments-in-2016)

#### 📋 Problem Statement:
Report the sum of all total investment values in 2016 (`tiv_2016`) for all policyholders who have the same `tiv_2015` value as one or more other policyholders, and are not located in the same city as any other policyholder (`(lat, lon)` pair is unique). Round `tiv_2016` to two decimal places.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

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
```

#### 💡 Explanation & Comment:
- Use subquery 1 to filter policyholders whose `tiv_2015` appears more than once (`HAVING COUNT(*) > 1`).
- Use subquery 2 with tuple comparison `(lat, lon) IN (...)` to ensure coordinates are completely unique (`HAVING COUNT(*) = 1`).
- Sum `tiv_2016` and round to 2 decimal places (`ROUND(..., 2)` in MySQL, `ROUND(...::numeric, 2)` in PostgreSQL).

---

### 43. [LC 185: Department Top Three Salaries](./43-lc-185-department-top-three-salaries)

#### 📋 Problem Statement:
Find the employees who are high earners in each department. A high earner in a department is an employee who has a salary in the top three unique salaries for that department. Return the result table in any order.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

WITH RankedSalaries AS (
    SELECT
        d.name AS Department,
        e.name AS Employee,
        e.salary AS Salary,
        DENSE_RANK() OVER (
            PARTITION BY e.departmentId
            ORDER BY e.salary DESC
        ) AS salary_rank
    FROM Employee AS e
    JOIN Department AS d
      ON e.departmentId = d.id
)
SELECT
    Department,
    Employee,
    Salary
FROM RankedSalaries
WHERE salary_rank <= 3;
```

#### 💡 Explanation & Comment:
- Join `Employee` with `Department` to retrieve department names.
- Use `DENSE_RANK()` partitioned by `departmentId` and ordered by `salary DESC`. `DENSE_RANK()` is essential because multiple employees with the same salary share the same rank without skipping subsequent ranks (top 3 unique salaries).
- Filter rows where `salary_rank <= 3`.

---

## 🚀 Technologies Used
- **SQL (Structured Query Language)**
- Supported Databases: **MySQL**, **PostgreSQL**

---
*All solutions written and verified by [Ashfak](https://github.com/ashfak-g).*
