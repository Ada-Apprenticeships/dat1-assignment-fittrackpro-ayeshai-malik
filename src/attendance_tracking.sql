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

-- Test: Retrieve the most recent attendance record for member 7
SELECT * 
FROM attendance
WHERE member_id = 7;

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


-- 4. Calculate the average daily attendance for each location
-- TODO: Write a query to calculate the average daily attendance for each location

-- Calculate average daily attendance for each location
SELECT 
    loc.name AS location_name,
    AVG(visit_count) AS avg_daily_attendance
FROM (
    SELECT 
        location_id,
        date(check_in_time) AS visit_date,
        COUNT(*) AS visit_count
    FROM 
        attendance
    GROUP BY 
        location_id, visit_date
) AS daily_visits
JOIN 
    locations AS loc ON daily_visits.location_id = loc.location_id
GROUP BY 
    loc.location_id, location_name;