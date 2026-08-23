# 📌 Section 02: Basic Joins Problem Set (LeetCode SQL 50)

Welcome to the **Basic Joins Problem Set** section! This directory contains my personal solutions for problems 6 through 14 from the **LeetCode SQL 50** study plan.

This section covers essential relational database join techniques including `INNER JOIN`, `LEFT JOIN`, `CROSS JOIN`, `Self-Join`, conditional joins, and combining join operations with aggregation functions like `COUNT()`, `AVG()`, `GROUP BY`, `HAVING`, `CASE`, and `ROUND()`.

---

## 📊 Summary of Problems

| # | Problem Name | Difficulty | Key Concepts Covered |
| :--- | :--- | :--- | :--- |
| **06** | [1378. Replace Employee ID With The Unique Identifier](./06-lc-1378-replace-employee-id-with-the-unique-identifier) | Easy | `LEFT JOIN`, `NULL` handling |
| **07** | [1068. Product Sales Analysis I](./07-lc-1068-product-sales-analysis-i) | Easy | `LEFT JOIN`, multi-table projection |
| **08** | [1581. Customer Who Visited but Did Not Make Any Transactions](./08-lc-1581-customer-who-visited-but-did-not-make-any-transactions) | Easy | `LEFT JOIN`, `IS NULL`, `GROUP BY`, `COUNT()` |
| **09** | [197. Rising Temperature](./09-lc-197-rising-temperature) | Easy | `Self-Join`, date comparison (`recordDate + 1`) |
| **10** | [1661. Average Time of Process per Machine](./10-lc-1661-average-time-of-process-per-machine) | Easy | `Self-Join`, `AVG()`, `ROUND()` |
| **11** | [577. Employee Bonus](./11-lc-577-employee-bonus) | Easy | `LEFT JOIN`, `IS NULL`, `OR` filter |
| **12** | [1280. Students and Examinations](./12-lc-1280-students-and-examinations) | Easy | `CROSS JOIN`, `LEFT JOIN`, `GROUP BY`, `COUNT()` |
| **13** | [570. Managers with at Least 5 Direct Reports](./13-lc-570-managers-with-at-least-5-direct-reports) | Medium | `Self-Join`, `GROUP BY`, `HAVING COUNT() >= 5` |
| **14** | [1934. Confirmation Rate](./14-lc-1934-confirmation-rate) | Medium | `LEFT JOIN`, `AVG()`, `CASE`, `ROUND()`, `COALESCE()` |

---

## 📝 Detailed Solutions & Explanations

### 6. [LC 1378: Replace Employee ID With The Unique Identifier](./06-lc-1378-replace-employee-id-with-the-unique-identifier)

#### 📋 Problem Statement:
Show the **unique ID** of each user from the `Employees` table. If a user does not have a unique ID, display `null` instead.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT EmployeeUNI.unique_id, Employees.name
FROM Employees
LEFT JOIN EmployeeUNI
  ON Employees.id = EmployeeUNI.id;
```

#### 💡 Explanation & Comment:
- A `LEFT JOIN` preserves all rows from the left table (`Employees`), matching them with `EmployeeUNI` on `id`.
- For employees who do not exist in `EmployeeUNI`, SQL automatically populates `unique_id` as `null`.

---

### 7. [LC 1068: Product Sales Analysis I](./07-lc-1068-product-sales-analysis-i)

#### 📋 Problem Statement:
Report the **`product_name`**, **`year`**, and **`price`** for each `sale_id` in the `Sales` table.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT Product.product_name, Sales.year, Sales.price
FROM Sales
LEFT JOIN Product
  ON Sales.product_id = Product.product_id;
```

#### 💡 Explanation & Comment:
- We perform a `LEFT JOIN` between `Sales` and `Product` matching on `product_id`.
- This attaches the corresponding `product_name` to each sales record without losing sales information.

---

### 8. [LC 1581: Customer Who Visited but Did Not Make Any Transactions](./08-lc-1581-customer-who-visited-but-did-not-make-any-transactions)

#### 📋 Problem Statement:
Find the IDs of users who visited the mall without making any transactions, and count the total number of such visits (`count_no_trans`).

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT Visits.customer_id, 
       COUNT(*) AS count_no_trans
FROM Visits
LEFT JOIN Transactions
  ON Visits.visit_id = Transactions.visit_id
WHERE Transactions.transaction_id IS NULL
GROUP BY Visits.customer_id;
```

#### 💡 Explanation & Comment:
- We `LEFT JOIN` `Visits` with `Transactions` on `visit_id`.
- `WHERE Transactions.transaction_id IS NULL` filters for visits that generated no purchase.
- We group by `customer_id` and count these visits using `COUNT(*)`.

---

### 9. [LC 197: Rising Temperature](./09-lc-197-rising-temperature)

#### 📋 Problem Statement:
Find all dates' `id` with higher temperatures compared to their previous dates (yesterday).

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT today.id
FROM Weather AS today
JOIN Weather AS previous_day
  ON today.recordDate = previous_day.recordDate + 1
WHERE today.temperature > previous_day.temperature;
```

#### 💡 Explanation & Comment:
- We perform a **Self-Join** on the `Weather` table, aliasing instances as `today` and `previous_day`.
- We match `today.recordDate` to yesterday (`previous_day.recordDate + 1`).
- The `WHERE` clause selects records where `today.temperature > previous_day.temperature`.

---

### 10. [LC 1661: Average Time of Process per Machine](./10-lc-1661-average-time-of-process-per-machine)

#### 📋 Problem Statement:
Calculate the average processing time for each machine (`end` timestamp minus `start` timestamp), rounded to **3 decimal places** as `processing_time`.

#### 💻 My SQL Solution:
```sql
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
```

#### 💡 Explanation & Comment:
- We self-join `Activity a1` (`'start'`) and `Activity a2` (`'end'`) matching both `machine_id` and `process_id`.
- The process duration is `(a2.timestamp - a1.timestamp)`.
- We group by `machine_id` and calculate the rounded average duration using `ROUND(AVG(...), 3)`.

---

### 11. [LC 577: Employee Bonus](./11-lc-577-employee-bonus)

#### 📋 Problem Statement:
Report the `name` and `bonus` amount of employees who have a bonus **less than 1000** or did not receive any bonus (`null`).

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT Employee.name, Bonus.bonus
FROM Employee
LEFT JOIN Bonus
  ON Employee.empId = Bonus.empId
WHERE Bonus.bonus < 1000
   OR Bonus.bonus IS NULL;
```

#### 💡 Explanation & Comment:
- We perform a `LEFT JOIN` between `Employee` and `Bonus` on `empId` so employees without bonuses are preserved.
- `WHERE Bonus.bonus < 1000 OR Bonus.bonus IS NULL` includes both low-bonus employees and those with no bonus record.

---

### 12. [LC 1280: Students and Examinations](./12-lc-1280-students-and-examinations)

#### 📋 Problem Statement:
Find the number of times each student attended each exam, sorted by `student_id` and `subject_name`.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT Students.student_id,
       Students.student_name,
       Subjects.subject_name,
       COUNT(Examinations.student_id) AS attended_exams
FROM Students
CROSS JOIN Subjects
LEFT JOIN Examinations
  ON Students.student_id = Examinations.student_id
 AND Subjects.subject_name = Examinations.subject_name
GROUP BY Students.student_id, Students.student_name, Subjects.subject_name
ORDER BY Students.student_id, Subjects.subject_name;
```

#### 💡 Explanation & Comment:
- A `CROSS JOIN` between `Students` and `Subjects` creates all possible student-subject combinations.
- A `LEFT JOIN` with `Examinations` matches attended exams. `COUNT(Examinations.student_id)` counts actual attendances (returning `0` if none were attended).

---

### 13. [LC 570: Managers with at Least 5 Direct Reports](./13-lc-570-managers-with-at-least-5-direct-reports)

#### 📋 Problem Statement:
Find all managers who have at least **five direct reports**.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT manager.name
FROM Employee AS manager
JOIN Employee AS employee
  ON employee.managerId = manager.id
GROUP BY manager.id, manager.name
HAVING COUNT(employee.id) >= 5;
```

#### 💡 Explanation & Comment:
- We self-join `Employee manager` and `Employee employee` on `employee.managerId = manager.id`.
- We group by `manager.id` and filter for managers supervising 5 or more employees using `HAVING COUNT(employee.id) >= 5`.

---

### 14. [LC 1934: Confirmation Rate](./14-lc-1934-confirmation-rate)

#### 📋 Problem Statement:
Find the **confirmation rate** of each user (ratio of `'confirmed'` requests to total requests), rounded to **2 decimal places**. Users with 0 requests must show `0.00`.

#### 💻 My SQL Solution:
```sql
-- Supported DB: MySQL & PostgreSQL

SELECT s.user_id,
       ROUND(
         COALESCE(
           AVG(CASE WHEN c.action = 'confirmed' THEN 1.0 ELSE 0.0 END), 
           0
         ), 
         2
       ) AS confirmation_rate
FROM Signups AS s
LEFT JOIN Confirmations AS c
  ON s.user_id = c.user_id
GROUP BY s.user_id;
```

#### 💡 Explanation & Comment:
- We `LEFT JOIN` `Signups` with `Confirmations` on `user_id`.
- We map `'confirmed'` to `1.0` and `'timeout'`/missing to `0.0` inside `AVG()`.
- `COALESCE(..., 0)` handles users with zero confirmation requests, and `ROUND(..., 2)` formats the final rate.

---

## 🚀 Technologies Used
- **SQL (Structured Query Language)**
- Supported Databases: **MySQL**, **PostgreSQL**

---
*All solutions written and verified by [Ashfak](https://github.com/ashfak-g).*
