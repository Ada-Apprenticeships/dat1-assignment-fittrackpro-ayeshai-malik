-- Initial SQLite setup
.open fittrackpro.db
.mode column
-- Display results in a boxed formatting
.mode box 

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- User Management Queries

-- 1. Retrieve all members
-- TODO: Write a query to retrieve all members
SELECT 
    member_id,
    first_name,
    last_name,
    email,
    join_date
FROM 
    members;

-- 2. Update a member's contact information
-- TODO: Write a query to update a member's contact information
-- Update the phone number and email for member with ID 5

UPDATE members
SET
    phone_number = '555-9876',
    email = 'emily.jones.updated@email.com'
WHERE
    member_id = 5;

-- 3. Count total number of members
-- TODO: Write a query to count the total number of members

SELECT COUNT(*) AS total_members 
FROM members;

-- 4. Find member with the most class registrations
-- TODO: Write a query to find the member with the most class registrations
-- This query assumes that 'registration' is represented within the 'attendance_status' of 'Registered'
-- Temporary result set (named subquery)

WITH registration_summary AS (
    SELECT
        m.member_id,
        m.first_name,
        m.last_name,
        -- Count of registered classes per member
        COUNT(ca.schedule_id) AS registration_count
    FROM
        members m
    LEFT JOIN -- All members considered even with zero registrations
        -- Join with class attendance and match the members with their class attendance only in 'Registered' status
        class_attendance ca ON m.member_id = ca.member_id AND ca.attendance_status = 'Registered'
    GROUP BY
        -- Group by member Id to count the registration for each member
        m.member_id
)
SELECT 
    member_id, 
    first_name, 
    last_name, 
    registration_count
FROM 
    -- Previous summarised data 
    registration_summary
WHERE 
    -- Select members with the max number of registrations
    registration_count = (SELECT MAX(registration_count) FROM registration_summary);


-- 5. Find member with the least class registrations
-- TODO: Write a query to find the member with the least class registrations

WITH registration_summary AS (
    SELECT
        m.member_id,
        m.first_name,
        m.last_name,
        COUNT(ca.schedule_id) AS registration_count
    FROM
        members m
    LEFT JOIN
        class_attendance ca ON m.member_id = ca.member_id AND ca.attendance_status = 'Registered'
    GROUP BY
        m.member_id
)
SELECT 
    member_id, 
    first_name, 
    last_name, 
    registration_count
FROM 
    registration_summary
WHERE 
    -- Select members with the lowest number of registrations
    registration_count = (SELECT MIN(registration_count) FROM registration_summary);


-- 6. Calculate the percentage of members who have attended at least one class
-- TODO: Write a query to calculate the percentage of members who have attended at least one class

SELECT 
    -- Calculate the ratio of members who have attended a class and the number of members
    COUNT(DISTINCT ca.member_id) * 100.0 / COUNT(DISTINCT m.member_id) AS percentage_attended 
FROM 
    members m
LEFT JOIN 
    class_attendance ca ON m.member_id = ca.member_id AND ca.attendance_status = 'Attended'; 


