-- Initial SQLite setup
.open fittrackpro.db
.mode column
.mode box

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Payment Management Queries

-- 1. Record a payment for a membership
-- TODO: Write a query to record a payment for a membership

-- Insert a new payment record for member with Id 11
-- Assuming a UNIQUE constraint exists on (member_id, payment_method, payment_type)

INSERT OR IGNORE INTO payments (member_id, amount, payment_date, payment_method, payment_type) -- Prevents duplicate entries
VALUES (11, 50.00, datetime('now'), 'Credit Card', 'Monthly membership fee');

-- Validate the inserted payment record
SELECT * 
FROM payments 
WHERE member_id = 11 
ORDER BY payment_date DESC 
LIMIT 1;

-- 2. Calculate total revenue from membership fees for each month of the last year
-- TODO: Write a query to calculate total revenue from membership fees for each month of the current year

SELECT 
  -- Extract month from 'payment_date' and convert to a month name for readability
  CASE strftime('%m', payment_date)
        WHEN '01' THEN 'January'
        WHEN '02' THEN 'February'
        WHEN '03' THEN 'March'
        WHEN '04' THEN 'April'
        WHEN '05' THEN 'May'
        WHEN '06' THEN 'June'
        WHEN '07' THEN 'July'
        WHEN '08' THEN 'August'
        WHEN '09' THEN 'September'
        WHEN '10' THEN 'October'
        WHEN '11' THEN 'November'
        WHEN '12' THEN 'December'
    -- Retrieve the payment year from payment_date to show concise months and year
    END || ' ' || strftime('%Y', payment_date) AS month, -- Concatenate with year for full Month Year
    -- Calculate the total revenue of payments
    SUM(amount) AS total_revenue
FROM 
    payments
WHERE 
    -- Restrict payments to 'Monthly membership fee' over the past year
    payment_type = 'Monthly membership fee'
    AND payment_date >= date('now', '-1 year')
GROUP BY 
    -- Group the records by year and month
    strftime('%Y', payment_date), strftime('%m', payment_date)
ORDER BY 
    -- Order by the month and year
    strftime('%Y', payment_date), strftime('%m', payment_date);

-- 3. Find all day pass purchases
-- TODO: Write a query to find all day pass purchases

SELECT 
    payment_id,
    amount,
    payment_date,
    payment_method
FROM 
    payments
WHERE 
    payment_type = 'Day pass'
ORDER BY 
    payment_date;













-- -- Test to see if only one new row is added into payments which should be the case if the member_id, payment_method, payment_type is unique 
-- SELECT * 
-- FROM payments;