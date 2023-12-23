-- Написать sql-скрипт, использующий созданные представления, и проверить его работоспособность.

USE Hospital;

-- Текущее количество пациентов-мужчин.
CREATE VIEW MalePatients AS
SELECT COUNT(*) AS male_patient_count
FROM Patients
WHERE gender = 'male';

-- Текущее количество пациентов-женщин.
CREATE VIEW FemalePatients AS
SELECT COUNT(*) AS female_patient_count
FROM Patients
WHERE gender = 'female';

-- Лечащиеся пациенты определенного отделения.
CREATE VIEW PatientsByDepartment AS
SELECT p.full_name, p.gender, r.department
FROM Patients p
JOIN Rooms r ON p.room_number = r.room_number;

-- Количество мест (отделение, общее кол-во мест (муж), общее кол-во мест (жен) , свободн.места (муж), свободные места (жен).
CREATE VIEW RoomOccupancy AS
SELECT department, SUM(bed_count) AS total_beds,
SUM(CASE WHEN gender = 'male' THEN bed_count ELSE 0 END) AS total_male_beds,
SUM(CASE WHEN gender = 'female' THEN bed_count ELSE 0 END) AS total_female_beds,
SUM(CASE WHEN gender = 'male' THEN bed_count - occupied_beds ELSE 0 END) AS free_male_beds,
SUM(CASE WHEN gender = 'female' THEN bed_count - occupied_beds ELSE 0 END) AS free_female_beds
FROM Rooms
GROUP BY department;

SELECT (SELECT * FROM MalePatients) AS male_patients,
       (SELECT * FROM FemalePatients) AS female_patients,
       (SELECT * FROM PatientsByDepartment WHERE department = 'Surgery') AS surgery_patients,
       (SELECT * FROM RoomOccupancy) AS room_occupancy;