SELECT transaction_qty*unit_price AS revenue
FROM transaction.sales.coffee_shop;

SELECT MIN(transaction_time)
FROM transaction.sales.coffee_shop;

SELECT MAX(transaction_time)
FROM transaction.sales.coffee_shop;

SELECT
--AGGREGATE
    COUNT(DISTINCT transaction_id) AS number_of_sales,
    SUM(transaction_qty*unit_price) AS total_revenue,
    SUM(transaction_qty) AS number_of_unuts_sold,

    --DATES
    TO_DATE(transaction_date) AS purchase_date,
    TO_CHAR(TO_DATE(transaction_date), 'YYYYMM') AS month_id,
    DAYNAME(TO_DATE(transaction_date)) AS day_of_week,

        CASE
            WHEN SUM(transaction_qty*unit_price) BETWEEN 0 AND 10 THEN 'low'
            WHEN SUM(transaction_qty*unit_price) BETWEEN 11 AND 49 THEN 'medium'
        ELSE 'high'
        END AS spender_bucket,
      
    -- GROUPS
    store_location,
    product_category,
    product_detail,
    product_type
FROM transaction.sales.coffee_shop
    GROUP BY
        purchase_date,
        month_id,
        day_of_week,
        store_location,
        product_category,
        product_detail,
        product_type
HAVING total_revenue >0;
