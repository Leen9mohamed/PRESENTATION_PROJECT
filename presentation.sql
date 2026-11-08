-- 1. Create Universities Table
CREATE TABLE Universities (
    university_id SERIAL PRIMARY KEY,
    university_name VARCHAR(150) NOT NULL,
    location VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- 2. Create Departments Table
CREATE TABLE Departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    university_id INT REFERENCES Universities(university_id)
);

-- 3. Create Programs Table
CREATE TABLE Programs (
    program_id SERIAL PRIMARY KEY,
    program_name VARCHAR(150) NOT NULL,
    degree_level VARCHAR(50),
    department_id INT REFERENCES Departments(department_id)
);

-- 4. Create Students Table
CREATE TABLE Students (
    student_id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    nationality VARCHAR(50)
);

-- 5. Create Applications Table
CREATE TABLE Applications (
    application_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES Students(student_id),
    program_id INT REFERENCES Programs(program_id),
    application_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(30) DEFAULT 'Pending'
);

-- 6. Create Documents Table
CREATE TABLE Documents (
    document_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES Students(student_id),
    document_name VARCHAR(100) NOT NULL,
    submission_date DATE DEFAULT CURRENT_DATE
);

-- 7. Create Admissions Table
CREATE TABLE Admissions (
    admission_id SERIAL PRIMARY KEY,
    application_id INT REFERENCES Applications(application_id),
    decision VARCHAR(30) NOT NULL,
    decision_date DATE DEFAULT CURRENT_DATE
);

-- 8. Create Payments Table
CREATE TABLE Payments (
    payment_id SERIAL PRIMARY KEY,
    application_id INT REFERENCES Applications(application_id),
    amount NUMERIC(10,2) NOT NULL,
    payment_date DATE DEFAULT CURRENT_DATE,
    payment_status VARCHAR(30) DEFAULT 'Unpaid'
);

-- 1. Insert Universities
INSERT INTO Universities (university_name, location, email)
VALUES
('University of Rwanda', 'Kigali', 'info@ur.ac.rw'),
('Kigali Independent University', 'Kigali', 'info@ulk.ac.rw');

-- 2. Insert Departments
INSERT INTO Departments (department_name, university_id)
VALUES
('Computer Science', 1),
('Information Technology', 1),
('Business Administration', 2);

-- 3. Insert Programs
INSERT INTO Programs (program_name, degree_level, department_id)
VALUES
('Software Engineering', 'Bachelor', 1),
('Database Systems', 'Bachelor', 1),
('Business Management', 'Bachelor', 3);

-- 4. Insert Students
INSERT INTO Students (full_name, email, phone, nationality)
VALUES
('John Smith', 'john@gmail.com', '0780000001', 'Rwandan'),
('David Brown', 'david@gmail.com', '0780000002', 'Rwandan'),
('Sarah Ali', 'sarah@gmail.com', '0780000003', 'Sudanese');

-- 5. Insert Applications
INSERT INTO Applications (student_id, program_id, status)
VALUES
(1, 1, 'Pending'),
(2, 2, 'Accepted'),
(3, 1, 'Pending');

-- 6. Insert Documents
INSERT INTO Documents (student_id, document_name)
VALUES
(1, 'National ID'),
(2, 'Academic Certificate'),
(3, 'Passport');

-- 7. Insert Admissions
INSERT INTO Admissions (application_id, decision)
VALUES
(1, 'Pending'),
(2, 'Accepted');

-- 8. Insert Payments
INSERT INTO Payments (application_id, amount, payment_status)
VALUES
(1, 50.00, 'Paid'),
(2, 50.00, 'Paid'),
(3, 50.00, 'Unpaid');

SELECT
    Students.full_name,
    Programs.program_name,
    Applications.status
FROM Applications
JOIN Students
ON Applications.student_id = Students.student_id
JOIN Programs
ON Applications.program_id = Programs.program_id;

UPDATE Applications
SET status = 'Accepted'
WHERE application_id = 1;

DELETE FROM Documents
WHERE document_id = 3;

SELECT * FROM Applications;

SELECT * FROM Documents;

-- CTE: Display Student Applications

WITH StudentApplications AS (
    SELECT
        Students.full_name,
        Programs.program_name,
        Applications.status
    FROM Applications
    JOIN Students
        ON Applications.student_id = Students.student_id
    JOIN Programs
        ON Applications.program_id = Programs.program_id
)

SELECT *
FROM StudentApplications;

6-- Create Index on Student Email
CREATE INDEX idx_student_email
ON Students(email);

-- Create Index on Application Status
CREATE INDEX idx_application_status
ON Applications(status);

SELECT *
FROM Students
WHERE email = 'john@gmail.com';

0-- Create Student Applications View

CREATE VIEW Student_Applications_View AS
SELECT
    Students.student_id,
    Students.full_name,
    Students.email,
    Programs.program_name,
    Applications.status
FROM Students
JOIN Applications
    ON Students.student_id = Applications.student_id
JOIN Programs
    ON Applications.program_id = Programs.program_id;

SELECT * FROM student_applications_view;


CREATE VIEW Accepted_Applications_View AS
SELECT
    Students.full_name,
    Programs.program_name,
    Applications.status
FROM Applications
JOIN Students
    ON Applications.student_id = Students.student_id
JOIN Programs
    ON Applications.program_id = Programs.program_id
WHERE Applications.status = 'Accepted';





