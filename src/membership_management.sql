-- -- Initial SQLite setup
-- .open fittrackpro.db
-- .mode column
-- .mode box 

-- -- Enable foreign key support
-- PRAGMA foreign_keys = ON;

-- -- Membership Management Queries

-- -- 1. List all active memberships
-- -- TODO: Write a query to list all active memberships

-- SELECT 
--     m.member_id,
--     m.first_name,
--     m.last_name,
--     ms.type AS membership_type,
--     m.join_date
-- FROM 
--     memberships ms
-- JOIN 
--     members m ON ms.member_id = m.member_id
-- WHERE 
--     ms.status = 'Active';

-- -- 2. Calculate the average duration of gym visits for each membership type
-- -- TODO: Write a query to calculate the average duration of gym visits for each membership type

-- SELECT 
--     m.type AS membership_type,
--     ROUND(AVG(
--         (strftime('%H', a.check_out_time) - strftime('%H', a.check_in_time)) * 60 +
--         (strftime('%M', a.check_out_time) - strftime('%M', a.check_in_time)) +
--         (strftime('%S', a.check_out_time) - strftime('%S', a.check_in_time)) / 60.0
--     ), 2) AS avg_visit_duration_minutes
-- FROM 
--     attendance a
-- JOIN 
--     memberships m ON a.member_id = m.member_id
-- WHERE
--     a.check_out_time IS NOT NULL 
-- GROUP BY 
--     m.type;


-- SELECT 
--     m.type AS membership_type,
--     ROUND(AVG(
--         (strftime('%s', a.check_out_time) - strftime('%s', a.check_in_time)) / 60.0
--     ), 2) AS avg_visit_duration_minutes
-- FROM 
--     attendance a
-- JOIN 
--     memberships m ON a.member_id = m.member_id
-- WHERE
--     a.check_out_time IS NOT NULL
-- GROUP BY 
--     m.type;
    
-- -- 3. Identify members with expiring memberships this year
-- -- TODO: Write a query to identify members with expiring memberships this year

-- SELECT 
--     m.member_id,
--     m.first_name,
--     m.last_name,
--     m.email,
--     ms.end_date
-- FROM 
--     memberships ms
-- JOIN 
--     members m ON ms.member_id = m.member_id
-- WHERE 
--     ms.end_date BETWEEN date('now') AND date('now', '+1 year');


-- SELECT
--     m.member_id,
--     m.first_name,
--     m.last_name,
--     m.email,
--     ms.end_date
-- FROM
--     memberships ms
-- JOIN
--     members m ON ms.member_id = m.member_id
-- WHERE
--     strftime('%Y', ms.end_date) = strftime('%Y', 'now')
-- AND
--     ms.status = 'Active';  