-- Initial SQLite setup
.open fittrackpro.db
.mode column
.mode box

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Equipment Management Queries

-- 1. Find equipment due for maintenance
-- TODO: Write a query to find equipment due for maintenance

SELECT 
    equipment_id,
    name,
    next_maintenance_date
FROM 
    equipment
WHERE 
    next_maintenance_date BETWEEN date('now') AND date('now', '+30 days');

-- 2. Count equipment types in stock
-- TODO: Write a query to count equipment types in stock

SELECT 
    type AS equipment_type,
    COUNT(*) AS count
FROM 
    equipment
GROUP BY 
    type;

-- 3. Calculate average age of equipment by type (in days)
-- TODO: Write a query to calculate average age of equipment by type (in days)

WITH equipment_age AS (
    SELECT 
        type,
        JULIANDAY('now') - JULIANDAY(purchase_date) AS days_old
    FROM 
        equipment
)
SELECT 
    type AS equipment_type,
    ROUND(AVG(days_old), 2) AS avg_age_days
FROM 
    equipment_age
GROUP BY 
    type
ORDER BY 
    type;