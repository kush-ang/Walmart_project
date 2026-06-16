USE walmart_db;

SELECT * FROM walmart;

# ------- BUSINESS QUERIES --------

# ------- EXECUTIVE OVERVIEW -------

# TOTAL RECORDS :- 9969
SELECT COUNT(*) FROM walmart;

# TOTAL REVENUE :- 1209726.38
SELECT ROUND(SUM(unit_price*quantity),2) AS total_revenue FROM walmart;

# TOTAL PROFIT :- 476139.43
SELECT ROUND(SUM(profit_margin*(unit_price*quantity)),2) AS total_profit FROM walmart;

# -------- REVENUE ANALYSIS--------

# HIGHEST REVENUE CATEGORY :- Fashion accessories
SELECT category, ROUND(SUM(unit_price*quantity),2) AS REVENUE FROM walmart
GROUP BY category
ORDER BY REVENUE DESC
LIMIT 3;

# HIGHEST REVENUE CITY :- Weslaco
SELECT City, ROUND(SUM(unit_price*quantity),2) AS REVENUE FROM walmart
GROUP BY City 
ORDER BY REVENUE DESC
LIMIT 5;

# TOP 3 BRANCHES BY REVENUE :- WALM009, WALM074, WALM003
SELECT Branch, ROUND(SUM(unit_price*quantity),2) AS REVENUE FROM  walmart
GROUP BY Branch 
ORDER BY REVENUE DESC
LIMIT 3;

# REVENUE CONTRIBUTION (%) BY CATEGORY :-Fashion accessories (40.46 %)
SELECT category,
    ROUND(SUM(unit_price * quantity), 2) AS revenue,
    ROUND(
        (SUM(unit_price * quantity) /
        (SELECT SUM(unit_price * quantity) FROM walmart)) * 100,
        2
    ) AS revenue_percentage
FROM walmart
GROUP BY category
ORDER BY revenue_percentage DESC;

# -------- CUSTOMER BEHAVIOUR ANALYSIS ---------

# HIGHEST RATED CATEGORY :- Food and beverages

SELECT category ,ROUND(AVG(rating),1) AS AVG_RATINGS FROM walmart
GROUP BY category
ORDER BY AVG_RATINGS DESC;

# OVERALL AVERAGE  RATINGS :- 5.8
SELECT ROUND(AVG(rating),1) AS avg_rating FROM walmart ;

# AVERAGE QUANTITY  :- 2.4
SELECT ROUND(AVG(quantity),1) AS AVERAGE_QUANTITY FROM walmart;

# AVERAGE SPEND :- 121.35
SELECT ROUND(AVG(unit_price*quantity),2) AS AVERAGE_SPEND FROM walmart;

# MOST PREFERRED PAYMENT METHOD :- CREDIT CARD
SELECT payment_method,COUNT(payment_method) AS PAYMENT_COUNT FROM walmart
GROUP BY payment_method
ORDER BY PAYMENT_COUNT DESC;

# ------- PROFIT ANALYSIS -------

# MOST PROFITABLE CATEGORY :- Fashion accessories (192314.89)

SELECT category, ROUND(SUM((unit_price*quantity)*profit_margin),2) AS TOTAL_PROFIT FROM walmart
GROUP BY category
ORDER BY TOTAL_PROFIT DESC;

# MOST PROFITABLE CITY :- Weslaco(15296.09)
SELECT City, ROUND(SUM((unit_price*quantity)*profit_margin),2) AS TOTAL_PROFIT FROM walmart
GROUP BY City
ORDER BY TOTAL_PROFIT DESC
LIMIT 5 ;

#------ TIME ANALYSIS---------

# HIGHEST REVENUE MONTH :- DECEMBER

SELECT MONTHNAME(date) AS MONTHS,
ROUND(SUM(unit_price*quantity)) AS TOTAL_REVENUE FROM walmart
GROUP BY MONTHS
ORDER BY TOTAL_REVENUE DESC;

# BEST SELLING TIME :- EVENING (3PM-8:59PM)

SELECT 
CASE 
    WHEN HOUR(time) >=3 AND HOUR(time) <12 THEN 'MORNING'
    WHEN HOUR(time) >=12 AND HOUR(time) <15 THEN 'AFTERNOON'
    WHEN HOUR(time) >=15 AND HOUR(time) <21 THEN 'EVENING'
ELSE  
'NIGHT'
END AS TIME_SLOT,
ROUND(SUM(unit_price*quantity),2) AS revenue
FROM walmart    
GROUP BY TIME_SLOT
ORDER BY revenue DESC ;


