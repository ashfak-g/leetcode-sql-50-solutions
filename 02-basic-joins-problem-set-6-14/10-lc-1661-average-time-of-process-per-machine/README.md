# 1661. Average Time of Process per Machine

**Difficulty:** Easy  
**Topic:** Basic Joins  

---

## 📌 Problem Statement

Write a solution to find the average time each machine takes to complete a process.

- The time to complete a process is the `'end'` timestamp minus the `'start'` timestamp.
- The average time is calculated by dividing the total processing time of all processes on the machine by the total number of processes run on that machine.
- The resulting table should report `machine_id` along with `processing_time`, rounded to **3 decimal places**.

Return the result table in **any order**.

---

## 📊 Database Schema

### `Activity` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `machine_id` | int | ID of the machine (part of primary key) |
| `process_id` | int | ID of the process (part of primary key) |
| `activity_type` | enum | `'start'` or `'end'` (part of primary key) |
| `timestamp` | float | Current time in seconds |

> **Note:** Each `(machine_id, process_id)` pair is guaranteed to have exactly one `'start'` and one `'end'` timestamp.

---

## 📝 Example

### Input: `Activity` Table
| machine_id | process_id | activity_type | timestamp |
| :--- | :--- | :--- | :--- |
| 0 | 0 | start | 0.712 |
| 0 | 0 | end | 1.520 |
| 0 | 1 | start | 3.140 |
| 0 | 1 | end | 4.120 |
| 1 | 0 | start | 0.550 |
| 1 | 0 | end | 1.550 |
| 1 | 1 | start | 0.430 |
| 1 | 1 | end | 1.420 |
| 2 | 0 | start | 4.100 |
| 2 | 0 | end | 4.512 |
| 2 | 1 | start | 2.500 |
| 2 | 1 | end | 5.000 |

### Output:
| machine_id | processing_time |
| :--- | :--- |
| 0 | 0.894 |
| 1 | 0.995 |
| 2 | 1.456 |

### Explanation:
- **Machine 0**: `((1.520 - 0.712) + (4.120 - 3.140)) / 2 = 0.894`
- **Machine 1**: `((1.550 - 0.550) + (1.420 - 0.430)) / 2 = 0.995`
- **Machine 2**: `((4.512 - 4.100) + (5.000 - 2.500)) / 2 = 1.456`

---

## 💡 Solution Approach

Use a **Self-Join** combined with **`AVG()`** and **`ROUND()`**:
1. Join `Activity a1` (where `activity_type = 'start'`) with `Activity a2` (where `activity_type = 'end'`) matching on `machine_id` and `process_id`.
2. Compute individual process durations using `(a2.timestamp - a1.timestamp)`.
3. Group by `machine_id` and calculate `ROUND(AVG(a2.timestamp - a1.timestamp), 3)` as `processing_time`.
