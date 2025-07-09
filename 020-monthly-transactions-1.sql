-- 020-monthly-transactions-1.sql
-- Link: https://leetcode.com/problems/monthly-transactions-i/description/

SELECT

-- Format transaction date as 'YYYY-MM' for monthly grouping
TO_CHAR(T.TRANS_DATE, 'yyyy-mm') AS "MONTH",

-- Country of the transaction
T.COUNTRY,

-- Total number of transactions
COUNT(*) AS "TRANS_COUNT",

-- Number of approved transactions
SUM(CASE WHEN T.STATE = 'approved' THEN 1 ELSE 0 END) AS "APPROVED_COUNT",

-- Total dollar amount of all transactions
SUM(T.AMOUNT) AS "TRANS_TOTAL_AMOUNT",

-- Total dollar amount of approved transactions only
SUM(CASE WHEN T.STATE = 'approved' THEN T.AMOUNT ELSE 0 END) AS "APPROVED_TOTAL_AMOUNT"

FROM TRANSACTIONS T

-- Group by month and country for roll-up
GROUP BY 
TO_CHAR(T.TRANS_DATE, 'yyyy-mm'),
T.COUNTRY

-- Sort results by country in descending order
ORDER BY 
T.COUNTRY DESC;

