-- Сгенерировать базу данных (скрипт) на основании модели.
CREATE TABLE HospitalRooms (
  room_number INT PRIMARY KEY,
  bed_count INT,
  department VARCHAR(255),
  occupied_beds INT,
  last_update_date DATE,
  gender ENUM('male', 'female')
);

CREATE TABLE Doctors (
  doctor_id INT PRIMARY KEY,
  full_name VARCHAR(255),
  department VARCHAR(255)
);

CREATE TABLE Patients (
  patient_id INT PRIMARY KEY,
  full_name VARCHAR(255),
  gender ENUM('male', 'female'),
  insurance_number VARCHAR(255),
  admission_date DATE,
  room_number INT,
  treating_doctor INT,
  diagnosis VARCHAR(255),
  discharge_date DATE,
  FOREIGN KEY (room_number) REFERENCES HospitalRooms(room_number),
  FOREIGN KEY (treating_doctor) REFERENCES Doctors(doctor_id)
);