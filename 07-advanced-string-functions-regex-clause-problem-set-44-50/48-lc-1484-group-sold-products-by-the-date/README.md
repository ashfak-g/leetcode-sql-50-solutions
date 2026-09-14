# 1484. Group Sold Products By The Date

**Difficulty:** Easy  
**Topic:** Advanced String Functions / Regex / Clause  

---

## 📌 Problem Statement

Write a solution to find for each date the **number of different products sold** and their **names**.

- The sold product names for each date must be **sorted lexicographically**.
- Separate the product names by a comma (`','`).
- Return the result table ordered by **`sell_date` in ascending order**.

---

## 📊 Database Schema

### `Activities` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `sell_date` | date | Date on which the product was sold |
| `product` | varchar | Name of the product sold (may contain duplicates) |

---

## 📝 Example

### Input: `Activities` Table

| sell_date | product |
| :--- | :--- |
| 2020-05-30 | Headphone |
| 2020-06-01 | Pencil |
| 2020-06-02 | Mask |
| 2020-05-30 | Basketball |
| 2020-06-01 | Bible |
| 2020-06-02 | Mask |
| 2020-05-30 | T-Shirt |

### Output:

| sell_date | num_sold | products |
| :--- | :--- | :--- |
| 2020-05-30 | 3 | Basketball,Headphone,T-Shirt |
| 2020-06-01 | 2 | Bible,Pencil |
| 2020-06-02 | 1 | Mask |

### Explanation:
- On `2020-05-30`: Items sold were `Headphone`, `Basketball`, `T-Shirt`. There are **3** distinct products. Sorted lexicographically: `Basketball,Headphone,T-Shirt`.
- On `2020-06-01`: Items sold were `Pencil`, `Bible`. There are **2** distinct products. Sorted lexicographically: `Bible,Pencil`.
- On `2020-06-02`: `Mask` was recorded twice, but only represents **1** distinct product: `Mask`.

---

## 💡 Solution Approaches

### 1. Distinct Count
Use `COUNT(DISTINCT product)` grouped by `sell_date` to get the count of unique products sold per day.

### 2. Group Aggregated Strings
Depending on the SQL dialect, the string aggregation function and its internal sorting syntax differ:

#### PostgreSQL (`STRING_AGG`):
```sql
SELECT sell_date,
       COUNT(DISTINCT product) AS num_sold,
       STRING_AGG(DISTINCT product, ',' ORDER BY product ASC) AS products
FROM Activities
GROUP BY sell_date
ORDER BY sell_date ASC;
```

#### MySQL (`GROUP_CONCAT`):
```sql
SELECT sell_date,
       COUNT(DISTINCT product) AS num_sold,
       GROUP_CONCAT(DISTINCT product ORDER BY product ASC SEPARATOR ',') AS products
FROM Activities
GROUP BY sell_date
ORDER BY sell_date ASC;
```
