-- Initial SQLite setup
.open fittrackpro.db
.mode column
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
    phone_number,
    date_of_birth,
    join_date
FROM 
    members;

-- 2. Update a member's contact information
-- TODO: Write a query to update a member's contact information
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

WITH registration_counts AS (
    SELECT
        m.member_id,
        m.first_name,
        m.last_name,
        COUNT(ca.schedule_id) AS registration_count
    FROM members m
    JOIN class_attendance ca
        ON m.member_id = ca.member_id
    WHERE ca.attendance_status = 'Registered'
    GROUP BY m.member_id
)
SELECT *
FROM registration_counts
WHERE registration_count = (SELECT MAX(registration_count) FROM registration_counts);

-- SELECT 
--     ca.member_id,
--     m.first_name,
--     m.last_name,
--     COUNT(ca.schedule_id) AS registration_count
-- FROM
--     class_attendance ca
-- JOIN
--     members m ON ca.member_id = m.member_id
-- WHERE
--     ca.attendance_status = 'Registered'
-- GROUP BY
--     ca.member_id
-- ORDER BY
--     registration_count;

-- 5. Find member with the least class registrations
-- TODO: Write a query to find the member with the least class registrations

WITH registration_counts AS (
    SELECT
        m.member_id,
        m.first_name,
        m.last_name,
        COUNT(ca.schedule_id) AS registration_count
    FROM members m
    JOIN class_attendance ca
        ON m.member_id = ca.member_id
    WHERE ca.attendance_status = 'Registered'
    GROUP BY m.member_id
)
SELECT *
FROM registration_counts
WHERE registration_count = (SELECT MIN(registration_count) FROM registration_counts);


-- 6. Calculate the percentage of members who have attended at least one class
-- TODO: Write a query to calculate the percentage of members who have attended at least one class

SELECT 
    -- Calculate the ratio of members who have attended a class and the number of members
    COUNT(DISTINCT ca.member_id) * 100.0 / COUNT(DISTINCT m.member_id) AS percentage_attended 
FROM 
    members m
LEFT JOIN 
    class_attendance ca ON m.member_id = ca.member_id AND ca.attendance_status = 'Attended'; 