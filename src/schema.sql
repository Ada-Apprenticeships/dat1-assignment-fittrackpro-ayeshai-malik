-- FitTrack Pro Database Schema

-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS class_schedule;
DROP TABLE IF EXISTS memberships;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS class_attendance;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS personal_training_sessions;
DROP TABLE IF EXISTS member_health_metrics;
DROP TABLE IF EXISTS equipment_maintenance_log;

-- Create your tables here
-- Example:
-- CREATE TABLE table_name (
--     column1 datatype,
--     column2 datatype,
--     ...
-- );

-- TODO: Create the following tables:
-- 1. locations
-- 2. members
-- 3. staff
-- 4. equipment
-- 5. classes
-- 6. class_schedule
-- 7. memberships
-- 8. attendance
-- 9. class_attendance
-- 10. payments
-- 11. personal_training_sessions
-- 12. member_health_metrics
-- 13. equipment_maintenance_log

-- locations table
CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL, 
    address TEXT NOT NULL,
    phone_number TEXT NOT NULL, 
    email TEXT NOT NULL UNIQUE,
    opening_hours TEXT NOT NULL
);

-- Test: locations table
-- INSERT INTO locations (name, address, phone_number, email, opening_hours)
-- VALUES 
-- ('Downtown Fitness', '123 Main St, Cityville', '555-1234', 'downtown@fittrackpro.com', '6:00-22:00'),
-- ('Suburb Gym', '456 Oak Rd, Townsburg', '555-5678', 'suburb@fittrackpro.com', '5:00-23:00');

-- members table
CREATE TABLE members (
    member_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    phone_number TEXT NOT NULL,
    date_of_birth DATE NOT NULL,
    join_date DATE NOT NULL,
    emergency_contact_name TEXT NOT NULL,
    emergency_contact_phone TEXT NOT NULL
);

-- Test: members table
INSERT INTO members (first_name, last_name, email, phone_number, date_of_birth, join_date, emergency_contact_name, emergency_contact_phone)
VALUES 
('Alice', 'Johnson', 'alice.j@email.com', '555-1111', '1990-05-15', '2024-11-10', 'Bob Johnson', '555-1112'),
('Bob', 'Smith', 'bob.s@email.com', '555-2222', '1985-09-22', '2024-12-15', 'Alice Smith', '555-2223'),
('Carol', 'Williams', 'carol.w@email.com', '555-3333', '1992-12-03', '2025-01-20', 'David Williams', '555-3334'),
('David', 'Brown', 'david.b@email.com', '555-4444', '1988-07-30', '2024-11-25', 'Emily Brown', '555-4445'),
('Emily', 'Jones', 'emily.j@email.com', '555-5555', '1995-03-12', '2024-12-30', 'Frank Jones', '555-5556'),
('Frank', 'Miller', 'frank.m@email.com', '555-6666', '1983-11-18', '2025-01-10', 'Grace Miller', '555-6667'),
('Grace', 'Davis', 'grace.d@email.com', '555-7777', '1993-01-25', '2024-11-20', 'Henry Davis', '555-7778'),
('Henry', 'Wilson', 'henry.w@email.com', '555-8888', '1987-08-05', '2024-12-15', 'Ivy Wilson', '555-8889'),
('Ivy', 'Moore', 'ivy.m@email.com', '555-9999', '1991-04-09', '2025-01-01', 'Jack Moore', '555-9990'),
('Jack', 'Taylor', 'jack.t@email.com', '555-0000', '1986-06-28', '2024-11-12', 'Kelly Taylor', '555-0001'),
('Karen', 'Lee', 'karen.l@email.com', '555-1313', '1989-02-14', '2024-12-05', 'Liam Lee', '555-1314'),
('Liam', 'Anderson', 'liam.a@email.com', '555-1515', '1994-07-19', '2025-01-01', 'Mia Anderson', '555-1516'),
('Mia', 'Thomas', 'mia.t@email.com', '555-1717', '1991-11-30', '2025-01-10', 'Noah Thomas', '555-1718'),
('Noah', 'Roberts', 'noah.r@email.com', '555-1919', '1987-04-25', '2025-01-15', 'Olivia Roberts', '555-1920'),
('Olivia', 'Clark', 'olivia.c@email.com', '555-2121', '1993-09-08', '2025-01-20', 'Peter Clark', '555-2122');





-- After creating the tables, you can import the sample data using:
-- `.read data/sample_data.sql` in a sql file or `npm run import` in the terminal