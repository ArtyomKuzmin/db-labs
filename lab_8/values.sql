-- Создать sql-скрипт для заполнения базы данных записями (минимум 3 записи на таблицу).

USE Hospital;

INSERT INTO Rooms (room_number, bed_count, department, occupied_beds, last_update_date, gender) VALUES
(101, 2, 'Cardiology', 1, '2023-10-01', 'male'),
(102, 3, 'Oncology', 2, '2023-09-15', 'female'),
(103, 1, 'Pediatrics', 1, '2023-09-30', 'male');

INSERT INTO Doctors (doctor_id, full_name, department) VALUES
(1, 'Dr. Smith', 'Cardiology'),
(2, 'Dr. Johnson', 'Oncology'),
(3, 'Dr. Lee', 'Pediatrics');

INSERT INTO Patients (patient_id, full_name, gender, insurance_number, admission_date, room_number, treating_doctor, diagnosis, discharge_date) VALUES
(1, 'John Doe', 'male', '12345', '2023-09-20', 101, 1, 'Arrhythmia', NULL),
(2, 'Jane Smith', 'female', '54321', '2023-09-25', 102, 2, 'Breast Cancer', NULL),
(3, 'Michael Johnson', 'male', '98765', '2023-09-28', 103, 3, 'Asthma', NULL);