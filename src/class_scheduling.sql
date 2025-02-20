-- Initial SQLite setup
.open fittrackpro.db
.mode column
.mode box

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Class Scheduling Queries

-- 1. List all classes with their instructors
-- TODO: Write a query to list all classes with their instructors

SELECT 
    c.class_id,
    c.name AS class_name,
    s.first_name || ' ' || s.last_name AS instructor_name -- Concatenate first and last name for the 'instructor_name'
FROM 
    class_schedule cs -- Scheduling table used as primary link between classes and instructors
JOIN 
    classes c ON cs.class_id = c.class_id -- Join with classes for the class details
JOIN 
    staff s ON cs.staff_id = s.staff_id -- Join with staff for instrcutor details
ORDER BY 
    c.class_id; -- Logically group the classes

-- 2. Find available classes for a specific date
-- TODO: Write a query to find available classes for a specific date

SELECT 
    cs.schedule_id AS class_id,
    c.name AS class_name,
    cs.start_time,
    cs.end_time,
    (c.capacity - COUNT(ca.class_attendance_id)) AS available_spots 
FROM 
    class_schedule cs
JOIN 
    classes c ON cs.class_id = c.class_id
LEFT JOIN 
    -- Include all schedules (even without registrations) so all classes appears in result
    class_attendance ca ON cs.schedule_id = ca.schedule_id AND ca.attendance_status = 'Registered' 
WHERE 
    DATE(cs.start_time) = '2025-02-01' -- Filter based on date required from README
GROUP BY 
    cs.schedule_id, c.name
ORDER BY 
    cs.start_time;

-- 3. Register a member for a class
-- TODO: Write a query to register a member for a class

-- -- Check the schedule_id on the spin class' for '2025-02-01'
-- SELECT 
--     schedule_id 
-- FROM 
--     class_schedule
-- WHERE 
--     class_id = 3 -- Assuming '3' is the class_id for Spin Class
--     AND DATE(start_time) = '2025-02-01'; -- Filter for the date

-- Insert a new registration into the class_attendance table
INSERT INTO class_attendance (schedule_id, member_id, attendance_status)
VALUES (
    (SELECT schedule_id 
     FROM class_schedule
     WHERE class_id = 3 
       AND DATE(start_time) = '2025-02-01'), 
    11,
    'Registered'); -- Attendance status showing successed registration

-- 4. Cancel a class registration
-- TODO: Write a query to cancel a class registration for member with ID 2 and schedule_id 7

DELETE FROM class_attendance
WHERE 
    member_id = 2 
    AND schedule_id = 7;

-- 5. List top 5 most popular classes
-- TODO: Write a query to list top 5 most popular classes
-- Only showing top 3 popular classes as stated in the README

SELECT 
    c.class_id,
    c.name AS class_name,
    COUNT(ca.class_attendance_id) AS registration_count -- Counts number of registration per class
FROM 
    class_attendance ca -- Primary table with class registration records
JOIN 
    class_schedule cs ON ca.schedule_id = cs.schedule_id -- Join attendance records to schedules
JOIN 
    classes c ON cs.class_id = c.class_id -- Link schedules to class data 
GROUP BY 
    c.class_id, c.name
ORDER BY 
    registration_count DESC -- Order classes in descending order so most popular is first
LIMIT 3; -- Limit output to show top 3 classes 

-- 6. Calculate average number of classes per member
-- TODO: Write a query to calculate average number of classes per member

SELECT
    ROUND(AVG(class_count), 2) AS average_classes_per_member -- Calculate and round the average number of distince classes
FROM (
    SELECT
        COUNT(DISTINCT ca.schedule_id) AS class_count -- Count of unique classes per member so only counted once per member
    FROM
        members m
    LEFT JOIN
        class_attendance ca ON m.member_id = ca.member_id -- Include all members even if they have no class records
    WHERE
        ca.attendance_status IN ('Registered', 'Attended') -- Filter to include statuses that are active in classes
    GROUP BY
        m.member_id 
);