# 1581. Customer Who Visited but Did Not Make Any Transactions

**Difficulty:** Easy  
**Topic:** Basic Joins  

---

## 📌 Problem Statement

Write a solution to find the IDs of users who visited the mall without making any transactions, and the number of times they made these types of visits (`count_no_trans`).

Return the result table in **any order**.

---

## 📊 Database Schema

### `Visits` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `visit_id` | int | Primary key (column with unique values) |
| `customer_id` | int | ID of the customer visiting the mall |

### `Transactions` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `transaction_id` | int | Primary key (column with unique values) |
| `visit_id` | int | Foreign key referencing `Visits` table |
| `amount` | int | Transaction amount |

---

## 📝 Example

### Input:

#### `Visits` Table
| visit_id | customer_id |
| :--- | :--- |
| 1 | 23 |
| 2 | 9 |
| 4 | 30 |
| 5 | 54 |
| 6 | 96 |
| 7 | 54 |
| 8 | 54 |

#### `Transactions` Table
| transaction_id | visit_id | amount |
| :--- | :--- | :--- |
| 2 | 5 | 310 |
| 3 | 5 | 300 |
| 9 | 5 | 200 |
| 12 | 1 | 910 |
| 13 | 2 | 970 |

### Output:
| customer_id | count_no_trans |
| :--- | :--- |
| 54 | 2 |
| 30 | 1 |
| 96 | 1 |

### Explanation:
- Customer **23**: visited once (`visit_id = 1`) and made a transaction (`transaction_id = 12`).
- Customer **9**: visited once (`visit_id = 2`) and made a transaction (`transaction_id = 13`).
- Customer **30**: visited once (`visit_id = 4`) without making any transaction (1 no-transaction visit).
- Customer **54**: visited 3 times (`visit_id = 5, 7, 8`). Made transactions during `visit_id = 5`, but no transactions during `visit_id = 7` and `8` (2 no-transaction visits).
- Customer **96**: visited once (`visit_id = 6`) without making any transaction (1 no-transaction visit).

---

## 💡 Solution Approach

Use a **`LEFT JOIN`** combined with **`GROUP BY`** and **`COUNT(*)`**:
1. Perform a `LEFT JOIN` between `Visits` and `Transactions` on `Visits.visit_id = Transactions.visit_id`.
2. Filter for visits without any matching transaction by checking `WHERE Transactions.transaction_id IS NULL`.
3. Group the result by `customer_id` and count the occurrences using `COUNT(*) AS count_no_trans`.
