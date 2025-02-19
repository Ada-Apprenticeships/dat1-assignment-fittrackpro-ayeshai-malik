INSERT INTO personal_training_sessions (member_id, staff_id, session_date, start_time, end_time, notes)
VALUES 
(1, 1, '2025-02-21', '09:00:00', '10:00:00', 'Upper body strength'),
(2, 1, '2025-02-25', '11:00:00', '12:00:00', 'Cardio session'),
(3, 3, '2025-03-01', '14:00:00', '15:00:00', 'Flexibility training');

INSERT INTO staff (first_name, last_name, email, phone_number, position, hire_date, location_id)
VALUES 
(1, 'John', 'Doe', 'john.doe@fittrackpro.com', '555-1234', 'Trainer', '2024-11-15', 1),
(2, 'Jane', 'Smith', 'jane.smith@fittrackpro.com', '555-5678', 'Manager', '2024-12-01', 2),
(3, 'Tom', 'Brown', 'tom.brown@fittrackpro.com', '555-8765', 'Trainer', '2025-01-05', 1);
