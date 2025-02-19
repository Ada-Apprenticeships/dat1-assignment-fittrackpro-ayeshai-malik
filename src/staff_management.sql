-- -- Initial SQLite setup
-- .open fittrackpro.db
-- .mode column
-- .mode box

-- -- Enable foreign key support
-- PRAGMA foreign_keys = ON;

-- -- Staff Management Queries

-- -- 1. List all staff members by role
-- -- TODO: Write a query to list all staff members by role
-- SELECT 
--     staff_id,
--     first_name,
--     last_name,
--     position AS role
-- FROM 
--     staff
-- ORDER BY 
--     position;

-- -- 2. Find trainers with one or more personal training session in the next 30 days
-- -- TODO: Write a query to find trainers with one or more personal training session in the next 30 days

-- SELECT 
--     s.staff_id AS trainer_id,
--     s.first_name || ' ' || s.last_name AS trainer_name,
--     COUNT(pts.session_id) AS session_count
-- FROM 
--     personal_training_sessions pts
-- JOIN 
--     staff s ON pts.staff_id = s.staff_id
-- WHERE 
--     s.position = 'Trainer' 
--     AND pts.session_date BETWEEN date('now') AND date('now', '+30 days')
-- GROUP BY 
--     s.staff_id, s.first_name, s.last_name
-- HAVING 
--     COUNT(pts.session_id) > 0 
-- ORDER BY 
--     session_count;
