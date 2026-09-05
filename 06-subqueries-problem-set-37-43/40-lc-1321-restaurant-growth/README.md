# 1321. Restaurant Growth

**Difficulty:** Medium  
**Topic:** Subqueries  

---

## 📌 Problem Statement

You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).

Compute the **moving average** of how much the customer paid in a **seven days window** (i.e., current day + 6 days before). 

- `average_amount` should be rounded to **two decimal places**.
- Return the result table ordered by **`visited_on` in ascending order**.

---

## 📊 Database Schema

### `Customer` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `customer_id` | int | ID of the customer |
| `name` | varchar | Name of the customer |
| `visited_on` | date | Date on which the customer visited the restaurant |
| `amount` | int | Total amount paid by the customer |

> Note: `(customer_id, visited_on)` is the primary key for the `Customer` table.

---

## 📝 Example

### Input: `Customer` Table

| customer_id | name | visited_on | amount |
| :--- | :--- | :--- | :--- |
| 1 | Jhon | 2019-01-01 | 100 |
| 2 | Daniel | 2019-01-02 | 110 |
| 3 | Jade | 2019-01-03 | 120 |
| 4 | Khaled | 2019-01-04 | 130 |
| 5 | Winston | 2019-01-05 | 110 |
| 6 | Elvis | 2019-01-06 | 140 |
| 7 | Anna | 2019-01-07 | 150 |
| 8 | Maria | 2019-01-08 | 80 |
| 9 | Jaze | 2019-01-09 | 110 |
| 1 | Jhon | 2019-01-10 | 130 |
| 3 | Jade | 2019-01-10 | 150 |

### Output:

| visited_on | amount | average_amount |
| :--- | :--- | :--- |
| 2019-01-07 | 860 | 122.86 |
| 2019-01-08 | 840 | 120 |
| 2019-01-09 | 840 | 120 |
| 2019-01-10 | 1000 | 142.86 |

### Explanation:
- **1st 7-day moving window (2019-01-01 to 2019-01-07)**:
  - Total amount = `100 + 110 + 120 + 130 + 110 + 140 + 150 = 860`
  - Average amount = `860 / 7 = 122.86`
- **2nd 7-day moving window (2019-01-02 to 2019-01-08)**:
  - Total amount = `110 + 120 + 130 + 110 + 140 + 150 + 80 = 840`
  - Average amount = `840 / 7 = 120`
- **3rd 7-day moving window (2019-01-03 to 2019-01-09)**:
  - Total amount = `120 + 130 + 110 + 140 + 150 + 80 + 110 = 840`
  - Average amount = `840 / 7 = 120`
- **4th 7-day moving window (2019-01-04 to 2019-01-10)**:
  - Total amount = `130 + 110 + 140 + 150 + 80 + 110 + (130 + 150) = 1000`
  - Average amount = `1000 / 7 = 142.86`

---

## 💡 Solution Approach

### Window Functions with CTE (Recommended)

1. **Aggregate Daily Totals (`DailySpending`)**:
   - Multiple customers can visit on the same day. Use `SUM(amount)` grouped by `visited_on` so there is exactly one row per day.

2. **Calculate 7-Day Rolling Metrics (`MovingMetrics`)**:
   - Rolling 7-day sum: `SUM(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)`.
   - Rolling 7-day average: `ROUND(SUM(amount) OVER (...) / 7.0, 2)`.
   - Assign sequential index: `ROW_NUMBER() OVER (ORDER BY visited_on) AS row_num`.

3. **Filter Incomplete Windows**:
   - Since the problem guarantees at least one customer every day, the days are strictly consecutive.
   - The first 6 days have fewer than 7 days of historical data. Filter them out using `WHERE row_num >= 7`.

4. **Order Output**:
   - Order results by `visited_on ASC`.
