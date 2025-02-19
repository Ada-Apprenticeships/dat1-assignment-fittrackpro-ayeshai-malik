-- FitTrack Pro Database Schema

-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Drop existing tables  
DROP TABLE IF EXISTS equipment_maintenance_log;
DROP TABLE IF EXISTS member_health_metrics;
DROP TABLE IF EXISTS personal_training_sessions;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS class_attendance;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS memberships;
DROP TABLE IF EXISTS class_schedule;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS equipment;  
DROP TABLE IF EXISTS staff;  
DROP TABLE IF EXISTS members;  
DROP TABLE IF EXISTS locations;  


-- 1. locations table
CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL, 
    address TEXT NOT NULL,
    phone_number TEXT NOT NULL, 
    email TEXT NOT NULL UNIQUE,
    opening_hours TEXT NOT NULL
);

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
 
-- 5. classes table 
CREATE TABLE classes (    
    class_id INTEGER PRIMARY KEY AUTOINCREMENT,    
    name TEXT NOT NULL,      
    description TEXT NOT NULL,    
    capacity INTEGER NOT NULL CHECK(capacity > 0), 
    duration INTEGER NOT NULL CHECK(duration > 0),    
    location_id INTEGER,  
    FOREIGN KEY (location_id) REFERENCES locations(location_id)    
); 

-- 6. class_schedule table  
CREATE TABLE class_schedule (  
    schedule_id INTEGER PRIMARY KEY AUTOINCREMENT,  
    class_id INTEGER,
    staff_id INTEGER, 
    start_time DATETIME NOT NULL,  
    end_time DATETIME NOT NULL CHECK (end_time > start_time),  
    FOREIGN KEY (class_id) REFERENCES classes(class_id),  
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)  
);   

-- 7. memberships table
CREATE TABLE memberships (  
    membership_id INTEGER PRIMARY KEY AUTOINCREMENT,  
    member_id INTEGER,
    type TEXT CHECK (type IN ('Basic', 'Premium')) NOT NULL, 
    start_date DATE NOT NULL,  
    end_date DATE NOT NULL CHECK(end_date > start_date),   
    status TEXT CHECK(status IN ('Active', 'Inactive')) NOT NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);   

-- 8. attendance table   
CREATE TABLE attendance (  
    attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,  
    member_id INTEGER,  
    location_id INTEGER,  
    check_in_time DATETIME NOT NULL,  
    check_out_time DATETIME,
    FOREIGN KEY (member_id) REFERENCES members(member_id),  
    FOREIGN KEY (location_id) REFERENCES locations(location_id)  
);  
-- Modified check_out_time to allow Nulls  

-- 9. class_attendance table  
CREATE TABLE class_attendance (  
    class_attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,  
    schedule_id INTEGER,  
    member_id INTEGER,  
    attendance_status TEXT CHECK (attendance_status IN ('Registered', 'Attended', 'Unattended')) NOT NULL,  
    FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id),  
    FOREIGN KEY (member_id) REFERENCES members(member_id)  
);  
  
-- 10. payments table
CREATE TABLE payments (    
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,   
    member_id INTEGER,   
    amount REAL NOT NULL,
    payment_date DATE NOT NULL,   
    payment_method TEXT CHECK (payment_method IN ('Credit Card', 'Bank Transfer', 'PayPal', 'Cash')) NOT NULL,    
    payment_type TEXT CHECK (payment_type IN ('Monthly membership fee', 'Day pass')) NOT NULL,     
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    UNIQUE(member_id, payment_date, payment_method, payment_type)
);

-- 11. personal_training_sessions
CREATE TABLE personal_training_sessions (    
    session_id INTEGER PRIMARY KEY AUTOINCREMENT,   
    member_id INTEGER,   
    staff_id INTEGER, 
    session_date REAL NOT NULL,
    start_time DATETIME NOT NULL,  
    end_time DATETIME NOT NULL, 
    notes TEXT NOT NULL,   
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (staff_id) REFERENCES staff (staff_id)
);  

-- 12. member_health_metrics
CREATE TABLE member_health_metrics (  
    metric_id INTEGER PRIMARY KEY AUTOINCREMENT,  
    member_id INTEGER NOT NULL,  
    measurement_date DATE NOT NULL,  
    weight REAL NOT NULL,  
    body_fat_percentage REAL NOT NULL,  
    muscle_mass REAL CHECK(muscle_mass >= 0),
    bmi REAL CHECK(bmi >= 0), 
    FOREIGN KEY (member_id) REFERENCES members(member_id)  
);  

-- 13. equipment_maintenance_log
CREATE TABLE equipment_maintenance_log (  
    log_id INTEGER PRIMARY KEY AUTOINCREMENT,  
    equipment_id INTEGER NOT NULL,  
    maintenance_date DATE NOT NULL,  
    description TEXT NOT NULL,  
    staff_id INTEGER,  
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)  
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)    
); 


-- After creating the tables, you can import the sample data using:
-- `.read data/sample_data.sql` in a sql file or `npm run import` in the terminal

.read scripts/sample_data.sql

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

-- -- Retrieve all attendance records with members' full names and locations
-- SELECT attendance.attendance_id, members.first_name || ' ' || members.last_name AS full_name, locations.name AS location_name, attendance.check_in_time, attendance.check_out_time  
-- FROM attendance  
-- JOIN members ON attendance.member_id = members.member_id  
-- JOIN locations ON attendance.location_id = locations.location_id;  

-- -- Test to retrieve the corresponding class name and members names using foreign keys
-- SELECT class_attendance.class_attendance_id, classes.name AS class_name, members.first_name || ' ' || members.last_name AS member_name, class_attendance.attendance_status  
-- FROM class_attendance  
-- JOIN class_schedule ON class_attendance.schedule_id = class_schedule.schedule_id  
-- JOIN classes ON class_schedule.class_id = classes.class_id  
-- JOIN members ON class_attendance.member_id = members.member_id;  
