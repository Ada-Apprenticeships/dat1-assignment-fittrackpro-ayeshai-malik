-- FitTrack Pro Database Schema

-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Drop existing tables  
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

-- Test: members table
INSERT INTO members (first_name, last_name, email, phone_number, date_of_birth, join_date, emergency_contact_name, emergency_contact_phone)
VALUES 
('Alice', 'Johnson', 'alice.j@email.com', '555-1111', '1990-05-15', '2024-11-10', 'Bob Johnson', '555-1112'),
('Bob', 'Smith', 'bob.s@email.com', '555-2222', '1985-09-22', '2024-12-15', 'Alice Smith', '555-2223'),
('Carol', 'Williams', 'carol.w@email.com', '555-3333', '1992-12-03', '2025-01-20', 'David Williams', '555-3334');


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


-- Test: staff table
INSERT INTO staff (first_name, last_name, email, phone_number, position, hire_date, location_id)
VALUES 
('David', 'Brown', 'david.b@fittrackpro.com', '555-4444', 'Trainer', '2024-11-10', 1),
('Emma', 'Davis', 'emma.d@fittrackpro.com', '555-5555', 'Manager', '2024-11-15', 2),
('Frank', 'Evans', 'frank.e@fittrackpro.com', '555-6666', 'Receptionist', '2024-12-10', 1);


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
 
-- Test: equipment table
INSERT INTO equipment (name, type, purchase_date, last_maintenance_date, next_maintenance_date, location_id)
VALUES 
('Treadmill 1', 'Cardio', '2024-11-01', '2024-11-15', '2025-02-15', 1),
('Treadmill 2', 'Cardio', '2024-11-02', '2024-11-20', '2025-02-20', 1),
('Treadmill 3', 'Cardio', '2024-11-03', '2024-11-25', '2025-02-25', 2);


-- 5. classes
-- 6. class_schedule
-- 7. memberships
-- 8. attendance
-- 9. class_attendance
-- 10. payments
-- 11. personal_training_sessions
-- 12. member_health_metrics
-- 13. equipment_maintenance_log



-- After creating the tables, you can import the sample data using:
-- `.read data/sample_data.sql` in a sql file or `npm run import` in the terminal


-- -- TESTING
.mode column 
.mode box

-- -- Query retrievs first name, last name, staff position from the staff table and the associated location from the 'locations' table using the foreign key
-- SELECT staff.first_name firstname, staff.last_name lastname, staff.position, locations.name AS location  
-- FROM staff  
-- JOIN locations ON staff.location_id = locations.location_id;  

-- -- Lists all equipment with associated location names to verify FK relationship
-- SELECT equipment.name AS equipment, equipment.type, locations.name AS location 
-- FROM equipment  
-- JOIN locations ON equipment.location_id = locations.location_id;  
