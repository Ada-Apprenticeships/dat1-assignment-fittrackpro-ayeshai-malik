-- Initial SQLite setup
.open fittrackpro.db
.mode column
.mode box 

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Membership Management Queries

-- 1. List all active memberships
-- TODO: Write a query to list all active memberships

SELECT 
    m.member_id,
    m.first_name,
    m.last_name,
    ms.type AS membership_type,
    m.join_date
FROM 
    memberships ms
JOIN 
    members m ON ms.member_id = m.member_id -- Link each membership with corresponing member details using unique identifier 'member_id'
WHERE 
    ms.status = 'Active';

-- 2. Calculate the average duration of gym visits for each membership type
-- TODO: Write a query to calculate the average duration of gym visits for each membership type

SELECT 
    m.type AS membership_type,
    ROUND(AVG(
        (strftime('%s', a.check_out_time) - strftime('%s', a.check_in_time)) / 60.0 -- Calculate total visit duration in seconds, convert to minutes (/60)
    ), 2) AS avg_visit_duration_minutes
FROM 
    attendance a
JOIN 
    memberships m ON a.member_id = m.member_id -- Join memberships to link each visit to its membership type
WHERE
    a.check_out_time IS NOT NULL -- Only consider a visit where check-out time is recorded 
GROUP BY 
    m.type; -- Group results by the membership type to calculate averages
    
-- 3. Identify members with expiring memberships this year
-- TODO: Write a query to identify members with expiring memberships this year
-- Interpreted as identifying memberships expiring in 2025/ current year

SELECT
    m.member_id,
    m.first_name,
    m.last_name,
    m.email,
    ms.end_date
FROM
    memberships ms
JOIN
    members m ON ms.member_id = m.member_id -- Join membership table with members table to get members details
WHERE
    strftime('%Y', ms.end_date) = strftime('%Y', 'now') -- Filter results to only include memberships expiring in current year
AND
    ms.status = 'Active'; -- Only include active memberships

-- Note: strftime('%Y', ms.end_date) = strftime('%Y', 'now')
--       Extracts the year from 'end_date'
--       '%Y' returns only the year component