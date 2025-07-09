-- 019-queries-quality-and-percentage.sql
-- Link: https://leetcode.com/problems/queries-quality-and-percentage/

SELECT
Q.QUERY_NAME,

-- Average Quality = AVG(RATING / POSITION)
ROUND(AVG(Q.RATING * 1.0 / Q.POSITION), 2) AS QUALITY,

-- Poor Query Percentage = (COUNT of ratings < 3) / (TOTAL ratings) * 100
ROUND(
    100.0 * SUM(CASE WHEN Q.RATING < 3 THEN 1 ELSE 0 END) / COUNT(*),
    2
) AS POOR_QUERY_PERCENTAGE

FROM QUERIES Q
GROUP BY Q.QUERY_NAME;
