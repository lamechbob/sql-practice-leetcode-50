-- Calculate the percentage of customers whose first order was delivered on their preferred delivery date
SELECT
    ROUND(
        (
            -- Count how many first orders were delivered on the customer's preferred delivery date
            SUM(
                CASE 
                    WHEN TO_DATE(ORDER_DATE) = TO_DATE(CUSTOMER_PREF_DELIVERY_DATE)
                        THEN 1
                    ELSE 0
                END
            )
            / COUNT(*)  -- Total number of first orders
        ) * 100,        -- Convert to percentage
        2               -- Round to 2 decimal places
    ) AS "IMMEDIATE_PERCENTAGE"

FROM (
    -- Subquery to isolate the *first* order per customer
    SELECT
        CUSTOMER_ID,
        ORDER_DATE,
        CUSTOMER_PREF_DELIVERY_DATE,
        ROW_NUMBER() OVER (
            PARTITION BY CUSTOMER_ID 
            ORDER BY ORDER_DATE ASC
        ) AS RN
    FROM DELIVERY
)

-- Only keep the first order for each customer
WHERE RN = 1;
