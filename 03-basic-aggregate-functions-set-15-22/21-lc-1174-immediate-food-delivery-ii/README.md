# 1174. Immediate Food Delivery II

**Difficulty:** Medium  
**Topic:** Basic Aggregate Functions  

---

## 📌 Problem Statement

Write a solution to find the **percentage of immediate orders** in the **first orders of all customers**, rounded to **2 decimal places**.

- An order is **immediate** if `customer_pref_delivery_date = order_date`; otherwise, it is **scheduled**.
- A customer's **first order** is the order with the earliest `order_date` that the customer made. (Each customer is guaranteed to have precisely one first order).

---

## 📊 Database Schema

### `Delivery` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `delivery_id` | int | Primary key (column with unique values) |
| `customer_id` | int | ID of the customer |
| `order_date` | date | Date order was placed |
| `customer_pref_delivery_date` | date | Preferred delivery date |

---

## 📝 Example

### Input: `Delivery` Table
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
| :--- | :--- | :--- | :--- |
| 1 | 1 | 2019-08-01 | 2019-08-02 |
| 2 | 2 | 2019-08-02 | 2019-08-02 |
| 3 | 1 | 2019-08-11 | 2019-08-12 |
| 4 | 3 | 2019-08-24 | 2019-08-24 |
| 5 | 3 | 2019-08-21 | 2019-08-22 |
| 6 | 2 | 2019-08-11 | 2019-08-13 |
| 7 | 4 | 2019-08-09 | 2019-08-09 |

### Output:
| immediate_percentage |
| :--- |
| 50.00 |

### Explanation:
First orders for each customer:
- **Customer 1**: First order is `delivery_id = 1` (`2019-08-01` vs `2019-08-02` -> Scheduled).
- **Customer 2**: First order is `delivery_id = 2` (`2019-08-02` vs `2019-08-02` -> Immediate).
- **Customer 3**: First order is `delivery_id = 5` (`2019-08-21` vs `2019-08-22` -> Scheduled).
- **Customer 4**: First order is `delivery_id = 7` (`2019-08-09` vs `2019-08-09` -> Immediate).
- Immediate first orders: `2` out of `4` customers = `(2 / 4) * 100 = 50.00%`.

---

## 💡 Solution Approach

Use a Subquery to filter for first orders combined with `AVG()` and `CASE`:
1. Use `WHERE (customer_id, order_date) IN (SELECT customer_id, MIN(order_date) FROM Delivery GROUP BY customer_id)` to select only first orders.
2. Map immediate orders (`order_date = customer_pref_delivery_date`) to `1.0` and scheduled orders to `0.0` using `CASE`.
3. Compute `ROUND(AVG(...) * 100, 2)` to calculate the final percentage.
