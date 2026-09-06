# 585. Investments in 2016

**Difficulty:** Medium  
**Topic:** Subqueries  

---

## 📌 Problem Statement

Write a solution to report the sum of all total investment values in 2016 (`tiv_2016`), for all policyholders who:

1. Have the **same `tiv_2015` value as one or more other policyholders**, and
2. Are **not located in the same city as any other policyholder** (i.e., the `(lat, lon)` attribute pairs must be unique).

Round `tiv_2016` to **two decimal places**.

---

## 📊 Database Schema

### `Insurance` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `pid` | int | Primary key (column with unique values) |
| `tiv_2015` | float | Total investment value in 2015 |
| `tiv_2016` | float | Total investment value in 2016 |
| `lat` | float | Latitude of the policyholder's city (not NULL) |
| `lon` | float | Longitude of the policyholder's city (not NULL) |

---

## 📝 Example

### Input: `Insurance` Table

| pid | tiv_2015 | tiv_2016 | lat | lon |
| :--- | :--- | :--- | :--- | :--- |
| 1 | 10 | 5 | 10 | 10 |
| 2 | 20 | 20 | 20 | 20 |
| 3 | 10 | 30 | 20 | 20 |
| 4 | 10 | 40 | 40 | 40 |

### Output:

| tiv_2016 |
| :--- |
| 45.00 |

### Explanation:
- **Record 1 (`pid = 1`)**:
  - `tiv_2015 = 10` is shared with `pid` 3 and 4 (`COUNT > 1`) -> ✅
  - Location `(10, 10)` is unique (`COUNT = 1`) -> ✅
  - Meets both criteria!
- **Record 2 (`pid = 2`)**:
  - `tiv_2015 = 20` is unique (no other policyholder has 20) -> ❌
  - Location `(20, 20)` is shared with `pid` 3 -> ❌
- **Record 3 (`pid = 3`)**:
  - `tiv_2015 = 10` is shared -> ✅
  - Location `(20, 20)` is shared with `pid` 2 -> ❌
- **Record 4 (`pid = 4`)**:
  - `tiv_2015 = 10` is shared with `pid` 1 and 3 -> ✅
  - Location `(40, 40)` is unique -> ✅
  - Meets both criteria!

Sum of `tiv_2016` for qualifying records (`pid` 1 and 4): `5 + 40 = 45.00`.

---

## 💡 Solution Approaches

### Approach 1: Subqueries with `IN` and Tuple Comparison (Standard)

Filter policyholders using two subqueries in the `WHERE` clause:
1. **Shared `tiv_2015`**:
   ```sql
   tiv_2015 IN (
       SELECT tiv_2015
       FROM Insurance
       GROUP BY tiv_2015
       HAVING COUNT(*) > 1
   )
   ```
2. **Unique `(lat, lon)` Coordinates**:
   ```sql
   (lat, lon) IN (
       SELECT lat, lon
       FROM Insurance
       GROUP BY lat, lon
       HAVING COUNT(*) = 1
   )
   ```
3. Sum `tiv_2016` and round to 2 decimal places (`ROUND(SUM(tiv_2016), 2)` in MySQL, `ROUND(SUM(tiv_2016)::numeric, 2)` in PostgreSQL).

### Approach 2: Window Functions

Use `COUNT(*) OVER (PARTITION BY ...)` to calculate duplicate counts in a single pass without multiple table scans:
- `COUNT(*) OVER (PARTITION BY tiv_2015) > 1`
- `COUNT(*) OVER (PARTITION BY lat, lon) = 1`
