# 602. Friend Requests II: Who Has the Most Friends

**Difficulty:** Medium  
**Topic:** Subqueries  

---

## 📌 Problem Statement

Write a solution to find the people who have the most friends and the most friends number.

The test cases are generated so that **only one person** has the most friends.

---

## 📊 Database Schema

### `RequestAccepted` Table

| Column Name | Type | Description |
| :--- | :--- | :--- |
| `requester_id` | int | User ID who sent the request |
| `accepter_id` | int | User ID who accepted the request |
| `accept_date` | date | Date when the request was accepted |

> Note: `(requester_id, accepter_id)` is the primary key for the `RequestAccepted` table.

---

## 📝 Example

### Input: `RequestAccepted` Table

| requester_id | accepter_id | accept_date |
| :--- | :--- | :--- |
| 1 | 2 | 2016/06/03 |
| 1 | 3 | 2016/06/08 |
| 2 | 3 | 2016/06/08 |
| 3 | 4 | 2016/06/09 |

### Output:

| id | num |
| :--- | :--- |
| 3 | 3 |

### Explanation:
- Person `1` is friends with `2` and `3` (Total: **2** friends).
- Person `2` is friends with `1` and `3` (Total: **2** friends).
- Person `3` is friends with `1`, `2`, and `4` (Total: **3** friends).
- Person `4` is friends with `3` (Total: **1** friend).

Person `3` has the highest count of **3** friends.

---

## 💡 Solution Approach

### 1. Understanding Friendship Symmetry
Friendship is bidirectional. If user `A` sends a request to user `B` and it is accepted:
- User `A` gained a friend (`B`).
- User `B` gained a friend (`A`).

Therefore, every row in `RequestAccepted` contributes to the friend count of **both** `requester_id` and `accepter_id`.

### 2. Implementation Steps
1. **Combine IDs using `UNION ALL`**:
   - Select all `requester_id` as `id`.
   - Select all `accepter_id` as `id`.
   - Use `UNION ALL` (not `UNION`) to keep all occurrences because each occurrence represents an established friendship.
2. **Count Friends per Person**:
   - `GROUP BY id` and calculate `COUNT(*) AS num`.
3. **Select the Top Person**:
   - Sort in descending order by friend count (`ORDER BY num DESC`).
   - Pick the highest with `LIMIT 1`.

---

## 🚀 Follow-Up: Handling Ties

In real-world scenarios, multiple users may tie for the most friends. To return all tied users instead of just one, use **`DENSE_RANK()`**:

```sql
WITH FriendCounts AS (
    SELECT id,
           COUNT(*) AS num,
           DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
    FROM (
        SELECT requester_id AS id FROM RequestAccepted
        UNION ALL
        SELECT accepter_id AS id FROM RequestAccepted
    ) AS AllFriends
    GROUP BY id
)
SELECT id, num
FROM FriendCounts
WHERE rnk = 1;
```
