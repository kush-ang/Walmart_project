USE walmart_db;
SELECT COUNT(*) FROM walmart;
DESC walmart;

# TOTAL ROWS -: 10020

# CHECK THE NULL VALUES 
SELECT * FROM walmart
WHERE invoice_id IS NULL
 OR  Branch IS NULL
 OR City IS NULL
 OR category IS NULL
 OR unit_price IS NULL
 OR quantity IS NULL
 OR date IS NULL 
 OR time IS NULL
 OR payment_method IS NULL
 OR rating IS NULL
 OR profit_margin IS NULL ;
 
# RESULT : NULL VALUES = NOT FOUND 

# CHECK THE DUPLICATE 

SELECT 
invoice_id ,COUNT(*) AS duplicate_count
FROM walmart
GROUP BY invoice_id
HAVING COUNT(*)>1;

CREATE TABLE temp_walmart AS
SELECT DISTINCT * FROM walmart
ORDER BY invoice_id;

TRUNCATE TABLE walmart;

INSERT INTO walmart
SELECT * FROM temp_walmart;

DROP TABLE temp_walmart;

SELECT invoice_id ,COUNT(*) FROM 
walmart
GROUP BY invoice_id
HAVING COUNT(*) >1;

# REMOVE DUPLICATES SUCCESSFULLY !

SELECT * FROM walmart LIMIT 10;

# CHANGE THE DATA TYPE :
SET SQL_SAFE_UPDATES = 0;

UPDATE walmart
SET unit_price = REPLACE(unit_price,'$','');

ALTER TABLE walmart
MODIFY COLUMN unit_price FLOAT;

UPDATE walmart
SET date = CASE
 WHEN date LIKE  '%/_ _' THEN STR_TO_DATE(date,'%d/%m/%y')
 WHEN date LIKE  '%/_ _ _ _' THEN STR_TO_DATE(date,'%d/%m/%y')
 ELSE date
 END;
 
UPDATE walmart
SET time = STR_TO_DATE(time,'%H:%i:%s');

ALTER TABLE walmart 
MODIFY COLUMN date DATE;

ALTER TABLE walmart 
MODIFY COLUMN time TIME;

SET SQL_SAFE_UPDATES = 1;


# DATA CLEANING IS COMPLETED SUCCESSFULLY!




