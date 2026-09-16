/*
Problem 1517: Find Users With Valid E-Mails

Table: Users
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
| mail          | varchar |
+---------------+---------+
- user_id is the primary key (column with unique values) for this table.
- This table contains information of the users signed up in a website. Some e-mails are invalid.

Task:
Write a solution to find the users who have valid emails.
A valid e-mail has a prefix name and a domain where:
1. The prefix name is a string that may contain letters (upper or lower case), digits, 
   underscore '_', period '.', and/or dash '-'. The prefix name must start with a letter.
2. The domain must be exactly '@leetcode.com' in lowercase.
Return the result table in any order.

Example 1:
Input: 
Users table:
+---------+-----------+-------------------------+
| user_id | name      | mail                    |
+---------+-----------+-------------------------+
| 1       | Winston   | winston@leetcode.com    |
| 2       | Jonathan  | jonathanisgreat         |
| 3       | Annabelle | bella-@leetcode.com     |
| 4       | Sally     | sally.come@leetcode.com |
| 5       | Marwan    | quarz#2020@leetcode.com |
| 6       | David     | david69@gmail.com       |
| 7       | Shapiro   | .shapo@leetcode.com     |
+---------+-----------+-------------------------+

Output: 
+---------+-----------+-------------------------+
| user_id | name      | mail                    |
+---------+-----------+-------------------------+
| 1       | Winston   | winston@leetcode.com    |
| 3       | Annabelle | bella-@leetcode.com     |
| 4       | Sally     | sally.come@leetcode.com |
+---------+-----------+-------------------------+

Explanation: 
- User 2: Does not have a domain -> Invalid.
- User 5: Contains '#' which is not allowed -> Invalid.
- User 6: Domain is '@gmail.com' instead of '@leetcode.com' -> Invalid.
- User 7: Starts with '.' instead of a letter -> Invalid.
*/


--------------------------------------------------------------------------------
----------------------------------- SQL CODE -----------------------------------
--------------------------------------------------------------------------------

-- Supported DB: MySQL & PostgreSQL

-- Approach 1: PostgreSQL (Using ~ regex match operator)
SELECT user_id,
       name,
       mail
FROM Users
WHERE mail ~ '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\.com$';


-- Approach 2: MySQL (Using REGEXP)
-- SELECT user_id,
--        name,
--        mail
-- FROM Users
-- WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\\.com$';