-- FitTrack Pro Database Schema

-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Drop existing tables  
DROP TABLE IF EXISTS memberships;
DROP TABLE IF EXISTS class_schedule;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS equipment;  
DROP TABLE IF EXISTS staff;  
DROP TABLE IF EXISTS members;  
DROP TABLE IF EXISTS locations;  


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

-- 1. locations table
CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL, 
    address TEXT NOT NULL,
    phone_number TEXT NOT NULL, 
    email TEXT NOT NULL UNIQUE,
    opening_hours TEXT NOT NULL
);

-- Test: locations table
INSERT INTO locations (name, address, phone_number, email, opening_hours)
VALUES 
('Downtown Fitness', '123 Main St, Cityville', '555-1234', 'downtown@fittrackpro.com', '6:00-22:00'),
('Suburb Gym', '456 Oak Rd, Townsburg', '555-5678', 'suburb@fittrackpro.com', '5:00-23:00');

-- 2. members table
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

-- Sample data for members
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


-- 3. staff table
CREATE TABLE staff (  
    staff_id INTEGER PRIMARY KEY AUTOINCREMENT,  
    first_name TEXT NOT NULL,  
    last_name TEXT NOT NULL,  
    email TEXT NOT NULL UNIQUE,  
    phone_number TEXT NOT NULL,  
    position TEXT CHECK(position IN ('Trainer', 'Manager', 'Receptionist', 'Maintenance')) NOT NULL,  
    hire_date DATE NOT NULL,  
    location_id INTEGER,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)  
);  


-- Sample data for staff
INSERT INTO staff (first_name, last_name, email, phone_number, position, hire_date, location_id)
VALUES 
('David', 'Brown', 'david.b@fittrackpro.com', '555-4444', 'Trainer', '2024-11-10', 1),
('Emma', 'Davis', 'emma.d@fittrackpro.com', '555-5555', 'Manager', '2024-11-15', 2),
('Frank', 'Evans', 'frank.e@fittrackpro.com', '555-6666', 'Receptionist', '2024-12-10', 1),
('Grace', 'Green', 'grace.g@fittrackpro.com', '555-7777', 'Trainer', '2024-12-20', 2),
('Henry', 'Harris', 'henry.h@fittrackpro.com', '555-8888', 'Maintenance', '2025-01-05', 1),
('Ivy', 'Irwin', 'ivy.i@fittrackpro.com', '555-9999', 'Trainer', '2025-01-01', 2),
('Jack', 'Johnson', 'jack.j@fittrackpro.com', '555-0000', 'Manager', '2024-11-15', 1),
('Karen', 'King', 'karen.k@fittrackpro.com', '555-1212', 'Trainer', '2024-12-01', 2);


-- 4. equipment table  
CREATE TABLE equipment (    
    equipment_id INTEGER PRIMARY KEY AUTOINCREMENT,    
    name TEXT NOT NULL,      
    type TEXT CHECK(type IN ('Cardio', 'Strength')) NOT NULL,    
    purchase_date DATE NOT NULL,    
    last_maintenance_date DATE NOT NULL,   
    next_maintenance_date DATE NOT NULL,   
    location_id INTEGER,  
    FOREIGN KEY (location_id) REFERENCES locations(location_id)    
); 
 
-- Sample data for equipment
INSERT INTO equipment (name, type, purchase_date, last_maintenance_date, next_maintenance_date, location_id)
VALUES 
('Treadmill 1', 'Cardio', '2024-11-01', '2024-11-15', '2025-02-15', 1),
('Treadmill 2', 'Cardio', '2024-11-02', '2024-11-20', '2025-02-20', 1),
('Treadmill 3', 'Cardio', '2024-11-03', '2024-11-25', '2025-02-25', 2),
('Treadmill 4', 'Cardio', '2024-11-04', '2024-11-30', '2025-02-28', 2),
('Bench Press 1', 'Strength', '2024-11-05', '2024-12-01', '2025-03-01', 1),
('Bench Press 2', 'Strength', '2024-11-06', '2024-12-05', '2025-03-05', 2),
('Elliptical 1', 'Cardio', '2024-11-07', '2024-12-10', '2025-03-10', 1),
('Elliptical 2', 'Cardio', '2024-11-08', '2024-12-15', '2025-03-15', 2),
('Squat Rack 1', 'Strength', '2024-11-09', '2024-12-20', '2025-03-20', 1),
('Squat Rack 2', 'Strength', '2024-11-10', '2024-12-25', '2025-03-25', 2),
('Rowing Machine 1', 'Cardio', '2024-11-11', '2024-12-30', '2025-03-30', 1),
('Rowing Machine 2', 'Cardio', '2024-11-12', '2025-01-01', '2025-04-01', 2),
('Leg Press 1', 'Strength', '2024-11-13', '2025-01-05', '2025-04-05', 1),
('Leg Press 2', 'Strength', '2024-11-14', '2025-01-10', '2025-04-10', 2),
('Stationary Bike 1', 'Cardio', '2024-11-15', '2025-01-15', '2025-04-15', 1),
('Stationary Bike 2', 'Cardio', '2024-11-16', '2025-01-20', '2025-04-20', 2);


-- 5. classes table 
CREATE TABLE classes (    
    class_id INTEGER PRIMARY KEY AUTOINCREMENT,    
    name TEXT NOT NULL,      
    description TEXT NOT NULL,    
    capacity TEXT NOT NULL,    
    duration TEXT NOT NULL,    
    location_id INTEGER,  
    FOREIGN KEY (location_id) REFERENCES locations(location_id)    
); 

-- Sample data for classes
INSERT INTO classes (name, description, capacity, duration, location_id)
VALUES 
('Yoga Basics', 'Introductory yoga class', 20, 60, 1),
('HIIT Workout', 'High-intensity interval training', 15, 45, 2),
('Spin Class', 'Indoor cycling workout', 20, 50, 1),
('Pilates', 'Core-strengthening exercises', 15, 55, 2),
('Zumba', 'Dance-based cardio workout', 25, 60, 1),
('Strength Training', 'Weight-based resistance training', 12, 45, 2);


-- 6. class_schedule table  
CREATE TABLE class_schedule (  
    schedule_id INTEGER PRIMARY KEY AUTOINCREMENT,  
    class_id INTEGER,
    staff_id INTEGER, 
    start_time DATETIME NOT NULL,  
    end_time DATETIME NOT NULL,  
    FOREIGN KEY (class_id) REFERENCES classes(class_id),  
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)  
);   

-- Sample data for class_schedule
INSERT INTO class_schedule (class_id, staff_id, start_time, end_time)
VALUES 
(1, 1, '2024-11-01 10:00:00', '2024-11-01 11:00:00'),
(2, 2, '2024-11-15 18:00:00', '2024-11-15 18:45:00'),
(3, 6, '2024-12-03 07:00:00', '2024-12-03 07:50:00'),
(4, 4, '2024-12-20 09:00:00', '2024-12-20 09:55:00'),
(5, 8, '2025-01-05 19:00:00', '2025-01-05 20:00:00'),
(6, 1, '2025-01-20 12:00:00', '2025-01-20 12:45:00'),
(3, 6, '2025-02-01 14:00:00', '2025-02-01 14:50:00'),
(5, 8, '2025-02-01 19:00:00', '2025-02-01 20:00:00'),
(5, 4, '2025-02-15 09:00:00', '2025-02-15 10:00:00');

-- 7. memberships table
CREATE TABLE memberships (  
    membership_id INTEGER PRIMARY KEY AUTOINCREMENT,  
    member_id INTEGER,
    type TEXT CHECK (type IN ('Basic', 'Premium')) NOT NULL, 
    start_date DATE NOT NULL,  
    end_date DATE NOT NULL,   
    status TEXT CHECK(status IN ('Active', 'Inactive')) NOT NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);   

-- Sample data for memberships
INSERT INTO memberships (member_id, type, start_date, end_date, status)
VALUES
(1, 'Premium', '2024-11-01', '2025-10-31', 'Active'),
(2, 'Basic', '2024-11-05', '2025-11-04', 'Active'),
(3, 'Premium', '2024-11-10', '2025-11-09', 'Active'),
(4, 'Basic', '2024-11-15', '2025-11-14', 'Active'),
(5, 'Premium', '2024-11-20', '2025-11-19', 'Active'),
(6, 'Basic', '2024-11-25', '2025-11-24', 'Inactive'),
(7, 'Premium', '2024-12-01', '2025-11-30', 'Active'),
(8, 'Basic', '2024-12-05', '2025-12-04', 'Active'),
(9, 'Premium', '2024-12-10', '2025-12-09', 'Active'),
(10, 'Basic', '2024-12-15', '2025-12-14', 'Inactive'),
(11, 'Premium', '2024-12-20', '2025-12-19', 'Active'),
(12, 'Basic', '2024-12-25', '2025-12-24', 'Active'),
(13, 'Premium', '2025-01-01', '2025-12-31', 'Active'),
(14, 'Basic', '2025-01-05', '2026-01-04', 'Inactive'),
(15, 'Premium', '2025-01-10', '2026-01-09', 'Active');

-- 9. class_attendance
-- 10. payments
-- 11. personal_training_sessions
-- 12. member_health_metrics
-- 13. equipment_maintenance_log



-- After creating the tables, you can import the sample data using:
-- `.read data/sample_data.sql` in a sql file or `npm run import` in the terminal


-- -- TESTING
-- .mode column 
-- .mode box

-- -- Query retrievs first name, last name, staff position from the staff table and the associated location from the 'locations' table using the foreign key
-- SELECT staff.first_name firstname, staff.last_name lastname, staff.position, locations.name AS location  
-- FROM staff  
-- JOIN locations ON staff.location_id = locations.location_id;  

-- -- Lists all equipment with associated location names to verify FK relationship
-- SELECT equipment.name AS equipment, equipment.type, locations.name AS location 
-- FROM equipment  
-- JOIN locations ON equipment.location_id = locations.location_id;  

-- -- Verify FK relationship between classes and locations
-- SELECT classes.name AS class_name, classes.description, locations.name AS location_name  
-- FROM classes  
-- JOIN locations ON classes.location_id = locations.location_id;  

-- -- Retrieves schedule details using Foreign Key 
-- SELECT class_schedule.schedule_id, classes.name AS class, staff.first_name || ' ' || staff.last_name AS staff_name, class_schedule.start_time, class_schedule.end_time
-- FROM class_schedule
-- JOIN classes ON class_schedule.class_id = classes.class_id
-- JOIN staff ON class_schedule.staff_id = staff.staff_id; 

-- Test the foreign key relationship between the memberships and members tables
-- SELECT memberships.membership_id, members.first_name || ' ' || members.last_name AS member_name, memberships.type, memberships.start_date, memberships.end_date, memberships.status 
-- FROM memberships 
-- JOIN members 
--     ON memberships.member_id = members.member_id;  
