# 595. Big Countries

**Difficulty:** Easy  
**Topic:** Select  

---

## 📌 Problem Statement

A country is considered **big** if:
1. It has an **area** of at least **3,000,000 km²**, OR
2. It has a **population** of at least **25,000,000**.

Write a solution to find the **name**, **population**, and **area** of all big countries.

Return the result table in **any order**.

---

## 📊 Database Schema

### `World` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `name` | varchar | Primary key (country name) |
| `continent` | varchar | Continent name |
| `area` | int | Total land area |
| `population` | int | Total population |
| `gdp` | bigint | Gross Domestic Product |

---

## 📝 Example

### Input: `World` Table
| name | continent | area | population | gdp |
| :--- | :--- | :--- | :--- | :--- |
| Afghanistan | Asia | 652230 | 25500100 | 20343000000 |
| Albania | Europe | 28748 | 2831741 | 12960000000 |
| Algeria | Africa | 2381741 | 37100000 | 188681000000 |
| Andorra | Europe | 468 | 78115 | 3712000000 |
| Angola | Africa | 1246700 | 20609294 | 100990000000 |

### Output:
| name | population | area |
| :--- | :--- | :--- |
| Afghanistan | 25500100 | 652230 |
| Algeria | 37100000 | 2381741 |

---

## 💡 Solution Approach

Filter records from the `World` table matching either:
- `area >= 3000000`
- `population >= 25000000`
