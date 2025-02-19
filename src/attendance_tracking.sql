-- Initial SQLite setup
.open fittrackpro.db
.mode column
.mode box 

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Attendance Tracking Queries

-- 1. Record a member's gym visit
-- TODO: Write a query to record a member's gym visit

-- Insert a new attendance record for member 7 at Downtown Fitness
INSERT INTO attendance (member_id, location_id, check_in_time, check_out_time)
VALUES 
    (7, 1, datetime('now'), NULL);

-- -- Retrieve the most recent attendance record for member 7
-- SELECT * 
-- FROM attendance
-- WHERE member_id = 7;

-- 2. Retrieve a member's attendance history
-- TODO: Write a query to retrieve a member's attendance history
SELECT
    date(check_in_time) AS visit_date,
    time(check_in_time) AS check_in_time,
    time(check_out_time) AS check_out_time
FROM 
    attendance
WHERE 
    member_id = 5
ORDER BY check_in_time;

-- 3. Find the busiest day of the week based on gym visits
-- TODO: Write a query to find the busiest day of the week based on gym visits
SELECT
    CASE strftime('%w', a.check_in_time)
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
    END AS day_of_week, -- Map the numeric day to its name for better readability
    COUNT(*) AS visit_count -- Count the number of visits per day
FROM
    attendance a
GROUP BY
    strftime('%w', a.check_in_time) -- Group by the numeric day of the week
ORDER BY
    visit_count DESC -- Order in descending order to get the busiest day
LIMIT 1; -- Limit to the most visits

-- 4. Calculate the average daily attendance for each location
-- TODO: Write a query to calculate the average daily attendance for each location


SELECT 
    locations.name AS location_name,
    AVG(visit_count) AS avg_daily_attendance -- Calculate the average daily attendance for each location
FROM (
    SELECT 
        location_id,
        date(check_in_time) AS visit_date, -- Convert check-in time to a date and extract the date
        COUNT(*) AS visit_count -- Count the number of visits on each date for each location
    FROM 
        attendance
    GROUP BY 
        location_id, visit_date -- Group by location and visit date to calculate daily visit counts
) AS daily_visits
JOIN 
    locations ON daily_visits.location_id = locations.location_id
GROUP BY 
    locations.location_id, locations.name; -- Group by location identifier and name to calculate average attendance per location