USE DATABASE healthcare_db;
USE SCHEMA raw;

CREATE OR REPLACE TABLE hospitals (

    hospital_id VARCHAR,

    hospital_name VARCHAR,

    hospital_type VARCHAR,

    city VARCHAR,

    state VARCHAR,

    phone VARCHAR,

    email VARCHAR,

    bed_count VARCHAR,

    established_date DATE,

    created_date DATE,

    updated_date DATE

);

--DOCTORS

CREATE OR REPLACE TABLE doctors (

doctor_id VARCHAR,

hospital_id VARCHAR,

first_name VARCHAR,

last_name VARCHAR,

gender VARCHAR,

specialization VARCHAR,

qualification VARCHAR,

experience_years VARCHAR,

consultation_fee VARCHAR,

phone VARCHAR,

email VARCHAR,

joining_date DATE,

created_date DATE,

updated_date DATE,

status VARCHAR

);


-- PATIENTS
CREATE OR REPLACE TABLE patients (

patient_id VARCHAR,

first_name VARCHAR,

last_name VARCHAR,

gender VARCHAR,

dob DATE,

phone VARCHAR,

email VARCHAR,

blood_group VARCHAR,

height_cm VARCHAR,

weight_kg VARCHAR,

city VARCHAR,

state VARCHAR,

pincode VARCHAR,

created_date DATE,

updated_date DATE

);

#INSURANCE
CREATE OR REPLACE TABLE insurance (

insurance_id VARCHAR,

patient_id VARCHAR,

provider VARCHAR,

policy_number VARCHAR,

coverage_amount VARCHAR,

start_date DATE,

end_date DATE,

created_date DATE,

updated_date DATE,

status VARCHAR

);


--APPOINTMENTS

CREATE OR REPLACE TABLE appointments (

appointment_id VARCHAR,

patient_id VARCHAR,

doctor_id VARCHAR,

hospital_id VARCHAR,

appointment_date DATE,

consultation_type VARCHAR,

consultation_fee VARCHAR,

waiting_time_minutes VARCHAR,

status VARCHAR,

created_date DATE,

updated_date DATE

);

--6 - PRESCRIPTIONS

CREATE OR REPLACE TABLE prescriptions (

prescription_id VARCHAR,

appointment_id VARCHAR,

patient_id VARCHAR,

doctor_id VARCHAR,

prescription_date DATE,

medicine_name VARCHAR,

dosage VARCHAR,

frequency VARCHAR,

duration_days VARCHAR,

quantity VARCHAR,

instructions VARCHAR

);
