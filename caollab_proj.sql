CREATE DATABASE PROJECT_K;
USE PROJECT_K;

CREATE TABLE User_role (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE User (
    user_id VARCHAR(255) PRIMARY KEY, 
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    role_id INT,  
    house_no VARCHAR(255),
    state VARCHAR(255),
    country VARCHAR(255),
    zipcode INT,
    phone_number VARCHAR(20),
    date_of_birth DATETIME,
    travel_preference TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES User_role(role_id) 
);

ALTER TABLE User 
ADD COLUMN qualification VARCHAR(255),
ADD COLUMN awards VARCHAR(255),
ADD COLUMN skill_id INT;

ALTER TABLE User
ADD CONSTRAINT FK_User_Skill_set FOREIGN KEY (skill_id) REFERENCES Skill_set(skill_id);

ALTER TABLE User 
MODIFY COLUMN user_id INT; 


CREATE TABLE Skill_set (
    skill_id INT PRIMARY KEY AUTO_INCREMENT,
    skill_name VARCHAR(255) NOT NULL,
    skill_level VARCHAR(255)
);


CREATE TABLE Institute (
    institute_id VARCHAR(255) PRIMARY KEY,  
    institute_name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    zipcode INT
);

CREATE TABLE Payments (
    payment_id BIGINT PRIMARY KEY AUTO_INCREMENT,  
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Cash', 'Card', 'Online'),
    payment_date DATETIME NOT NULL,
    discount DECIMAL(5,2),
    transaction_id VARCHAR(255)
);
 
 
-- Pay_type
CREATE TABLE Pay_type (
    method_id INT PRIMARY KEY AUTO_INCREMENT,
    method_name VARCHAR(255) NOT NULL
);


-- Review
CREATE TABLE Review (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    student_id INT, 
    rating INT,
    comments VARCHAR(255),
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (student_id) REFERENCES User(user_id) 
);

-- Course
CREATE TABLE Course (
  course_id INT PRIMARY KEY AUTO_INCREMENT,
  tutor_id INT,  
  course_title VARCHAR(255) NOT NULL,
  description VARCHAR(255),
  class_mode_id INT,
  level_id INT,
  start_date DATE,
  end_date DATE,
  seats_availability INT,
  FOREIGN KEY (tutor_id) REFERENCES User(user_id), 
  FOREIGN KEY (class_mode_id) REFERENCES Class_Mode(class_mode_id),
  FOREIGN KEY (level_id) REFERENCES Course_Level(level_id)  
);


-- Student_schedule
CREATE TABLE Student_schedule (
    student_id INT,
    tutor_id INT,
    course_id INT,
    PRIMARY KEY (student_id, tutor_id, course_id), 
    FOREIGN KEY (student_id) REFERENCES User(user_id),
    FOREIGN KEY (tutor_id) REFERENCES User(user_id), 
    FOREIGN KEY (course_id) REFERENCES Course(course_id) 
);

-- Attendance
CREATE TABLE Attendance (
    course_id INT,
    student_id INT,
    attendance_date DATE, 
    status_id INT, 
    PRIMARY KEY (course_id, student_id, attendance_date), 
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (student_id) REFERENCES User(user_id),
    FOREIGN KEY (status_id) REFERENCES Status(status_id) 
);

-- Status
CREATE TABLE Status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(255) NOT NULL
);

-- Assignment
CREATE TABLE Assignment (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    description TEXT,
    due_date DATETIME,
    max_marks INT,
    field_type VARCHAR(255),  
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

-- Submissions
CREATE TABLE Submissions (
    submission_id INT PRIMARY KEY AUTO_INCREMENT,
    assignment_id INT,
    student_id INT,
    submission_date DATETIME,
    content VARCHAR(255),  
    grade VARCHAR(255), 
    feedback TEXT,
    FOREIGN KEY (assignment_id) REFERENCES Assignment(assignment_id),
    FOREIGN KEY (student_id) REFERENCES User(user_id) 
);

-- Course_Schedule
CREATE TABLE Course_Schedule (
    course_id INT,
    day_id INT,
    start_time DATETIME,
    end_time DATETIME,
    PRIMARY KEY (course_id, day_id, start_time),  
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (day_id) REFERENCES Day_Static(day_id)
);

-- Day_Static
CREATE TABLE Day_Static (
    day_id INT PRIMARY KEY AUTO_INCREMENT,
    day VARCHAR(255)
);

-- Course_Level
CREATE TABLE Course_Level (
    level_id INT PRIMARY KEY AUTO_INCREMENT,
    level_name VARCHAR(255)
);

-- Class_Mode
CREATE TABLE Class_Mode (
    class_mode_id INT PRIMARY KEY AUTO_INCREMENT,
    mode_name VARCHAR(255)
);

CREATE TABLE Enrollment (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT, 
    course_id INT,
    status ENUM('Enrolled', 'Completed', 'Cancelled'),
    date_enrolled DATETIME NOT NULL,
    payment_id BIGINT,
    comments VARCHAR(255),
    FOREIGN KEY (student_id) REFERENCES User(user_id), 
    FOREIGN KEY (course_id) REFERENCES Course(course_id), 
    FOREIGN KEY (payment_id) REFERENCES Payments(payment_id) 
);

-- User_role
INSERT INTO User_role (role_name) VALUES 
('Admin'),
('Tutor'),
('Student'),
('Parent'),
('Teacher'),
('Manager'),
('Assistant'),
('Supervisor'),
('Principal'),
('Guardian');

-- User
INSERT INTO User (user_id, username, email, password, first_name, last_name, role_id, house_no, state, country, zipcode, phone_number, date_of_birth, travel_preference, qualification, awards, skill_id) VALUES 
('1', 'admin', 'admin@example.com', 'admin123', 'Admin', 'User', 1, '123 Main St', 'California', 'USA', 12345, '123-456-7890', '1990-01-01', CURRENT_TIMESTAMP, 'PhD', 'Best Student Award', 1),
('2', 'tutor1', 'tutor1@example.com', 'tutor123', 'John', 'Doe', 2, '456 Elm St', 'New York', 'USA', 54321, '987-654-3210', '1985-05-15', CURRENT_TIMESTAMP, 'Masters', 'Teaching Excellence Award', 2),
('3', 'student1', 'student1@example.com', 'student123', 'Alice', 'Smith', 3, '789 Oak St', 'Texas', 'USA', 67890, '567-890-1234', '2000-10-20', CURRENT_TIMESTAMP, 'High School Diploma', 'Merit Scholarship', 3),
('4', 'teacher1', 'teacher1@example.com', 'teacher123', 'Emily', 'Johnson', 4, '567 Pine St', 'California', 'USA', 54321, '123-456-7890', '1982-03-20', CURRENT_TIMESTAMP, 'Bachelor', 'Best Teacher Award', 4),
('5', 'manager1', 'manager1@example.com', 'manager123', 'Michael', 'Brown', 5, '890 Oak St', 'Texas', 'USA', 34567, '987-654-3210', '1976-08-12', CURRENT_TIMESTAMP, 'Master', 'Manager of the Year', 5),
('6', 'assistant1', 'assistant1@example.com', 'assistant123', 'Sophia', 'Wilson', 6, '234 Elm St', 'New York', 'USA', 89012, '234-567-8901', '1995-11-25', CURRENT_TIMESTAMP, 'Associate', 'Assistant of the Month', 6),
('7', 'supervisor1', 'supervisor1@example.com', 'supervisor123', 'Daniel', 'Martinez', 7, '345 Maple St', 'California', 'USA', 45678, '789-012-3456', '1990-06-18', CURRENT_TIMESTAMP, 'Diploma', 'Supervisor Award', 7),
('8', 'principal1', 'principal1@example.com', 'principal123', 'Olivia', 'Garcia', 8, '678 Oak St', 'Texas', 'USA', 23456, '012-345-6789', '1968-12-03', CURRENT_TIMESTAMP, 'PhD', 'Principal of the Decade', 8),
('9', 'guardian1', 'guardian1@example.com', 'guardian123', 'Liam', 'Hernandez', 9, '789 Elm St', 'New York', 'USA', 56789, '456-789-0123', '1998-09-30', CURRENT_TIMESTAMP, 'High School Diploma', 'Guardian Angel Award', 9),
('10', 'parent1', 'parent1@example.com', 'parent123', 'Emma', 'Lopez', 10, '901 Pine St', 'California', 'USA', 89012, '678-901-2345', '1974-04-15', CURRENT_TIMESTAMP, 'Bachelor', 'Best Parent Award', 10);

-- Skill_set
INSERT INTO Skill_set (skill_name, skill_level) VALUES 
('Programming', 'Expert'),
('Database Management', 'Intermediate'),
('Data Analysis', 'Advanced'),
('Project Management', 'Intermediate'),
('Communication', 'Advanced'),
('Leadership', 'Advanced'),
('Problem Solving', 'Expert'),
('Teamwork', 'Intermediate'),
('Time Management', 'Intermediate'),
('Customer Service', 'Advanced');

-- Institute
INSERT INTO Institute (institute_id, institute_name, address, zipcode) VALUES 
('1', 'ABC Institute', '123 Maple Ave', 98765),
('2', 'XYZ Academy', '456 Pine St', 54321),
('3', 'DEF College', '789 Oak St', 12345),
('4', 'GHI University', '890 Elm St', 67890),
('5', 'JKL School', '901 Pine St', 23456),
('6', 'MNO Academy', '234 Elm St', 78901),
('7', 'PQR Institute', '567 Maple Ave', 34567),
('8', 'STU University', '678 Oak St', 89012),
('9', 'VWX College', '789 Elm St', 45678),
('10', 'YZA University', '901 Oak St', 90123);

-- Payments
INSERT INTO Payments (amount, payment_method, payment_date, discount, transaction_id) VALUES 
(100.00, 'Card', '2024-03-15 10:00:00', 10.00, 'TRX123456'),
(50.00, 'Online', '2024-03-16 12:00:00', NULL, 'TRX789012'),
(75.00, 'Cash', '2024-03-17 15:00:00', NULL, 'TRX567890'),
(120.00, 'Card', '2024-03-18 09:00:00', 15.00, 'TRX234567'),
(90.00, 'Online', '2024-03-19 11:00:00', NULL, 'TRX890123'),
(80.00, 'Cash', '2024-03-20 13:00:00', 10.00, 'TRX456789'),
(110.00, 'Card', '2024-03-21 14:00:00', NULL, 'TRX012345'),
(95.00, 'Online', '2024-03-22 16:00:00', NULL, 'TRX678901'),
(70.00, 'Cash', '2024-03-23 17:00:00', 5.00, 'TRX345678'),
(85.00, 'Card', '2024-03-24 18:00:00', NULL, 'TRX901234');

-- Pay_type
INSERT INTO Pay_type (method_name) VALUES 
('Credit Card'),
('Debit Card'),
('PayPal'),
('Cash'),
('Bank Transfer'),
('Cheque'),
('Mobile Payment'),
('Cryptocurrency'),
('Voucher'),
('Installment');


-- Course
INSERT INTO Course (tutor_id, course_title, description, class_mode_id, level_id, start_date, end_date, seats_availability) VALUES 
(2, 'Introduction to Programming', 'Learn basics of programming', 1, 1, '2024-03-15', '2024-04-15', 20),
(4, 'Database Management Fundamentals', 'Introduction to database management', 2, 2, '2024-03-16', '2024-04-16', 15),
(6, 'Data Analysis Techniques', 'Advanced data analysis methods', 3, 3, '2024-03-17', '2024-04-17', 25),
(8, 'Project Management Essentials', 'Basic principles of project management', 1, 2, '2024-03-18', '2024-04-18', 18),
(10, 'Effective Communication Skills', 'Improving communication skills', 2, 1, '2024-03-19', '2024-04-19', 22),
(1, 'Leadership Development Program', 'Developing leadership skills', 3, 3, '2024-03-20', '2024-04-20', 30),
(3, 'Problem Solving Strategies', 'Learning problem-solving techniques', 1, 2, '2024-03-21', '2024-04-21', 12),
(5, 'Teamwork in the Workplace', 'Enhancing teamwork skills', 2, 1, '2024-03-22', '2024-04-22', 17),
(7, 'Time Management Techniques', 'Improving time management skills', 3, 3, '2024-03-23', '2024-04-23', 28),
(9, 'Customer Service Excellence', 'Delivering exceptional customer service', 1, 2, '2024-03-24', '2024-04-24', 14);



INSERT INTO Course_Schedule (course_id, day_id, start_time, end_time) VALUES 
(16, 3, '2024-03-18 08:00:00', '2024-03-18 10:00:00');


INSERT INTO Course_Schedule (course_id, day_id, start_time, end_time) VALUES 
(11, 2, '2024-03-19 10:00:00', '2024-03-19 12:00:00'),
(11, 4, '2024-03-21 10:00:00', '2024-03-21 12:00:00');


INSERT INTO Course_Schedule (course_id, day_id, start_time, end_time) VALUES 
(17, 1, '2024-03-18 13:00:00', '2024-03-18 15:00:00'),
(17, 3, '2024-03-20 13:00:00', '2024-03-20 15:00:00');


INSERT INTO Course_Schedule (course_id, day_id, start_time, end_time) VALUES 
(12, 2, '2024-03-19 15:00:00', '2024-03-19 17:00:00'),
(12, 4, '2024-03-21 15:00:00', '2024-03-21 17:00:00');


INSERT INTO Course_Schedule (course_id, day_id, start_time, end_time) VALUES 
(18, 1, '2024-03-18 08:00:00', '2024-03-18 10:00:00'),
(18, 3, '2024-03-20 08:00:00', '2024-03-20 10:00:00');


INSERT INTO Course_Schedule (course_id, day_id, start_time, end_time) VALUES 
(13, 2, '2024-03-19 10:00:00', '2024-03-19 12:00:00'),
(13, 4, '2024-03-21 10:00:00', '2024-03-21 12:00:00');


INSERT INTO Course_Schedule (course_id, day_id, start_time, end_time) VALUES 
(19, 1, '2024-03-18 13:00:00', '2024-03-18 15:00:00'),
(19, 3, '2024-03-20 13:00:00', '2024-03-20 15:00:00');


INSERT INTO Course_Schedule (course_id, day_id, start_time, end_time) VALUES 
(14, 2, '2024-03-19 15:00:00', '2024-03-19 17:00:00'),
(14, 4, '2024-03-21 15:00:00', '2024-03-21 17:00:00');


INSERT INTO Course_Schedule (course_id, day_id, start_time, end_time) VALUES 
(20, 1, '2024-03-18 08:00:00', '2024-03-18 10:00:00'),
(20, 3, '2024-03-20 08:00:00', '2024-03-20 10:00:00');


INSERT INTO Course_Schedule (course_id, day_id, start_time, end_time) VALUES 
(15, 2, '2024-03-19 10:00:00', '2024-03-19 12:00:00'),
(15, 4, '2024-03-21 10:00:00', '2024-03-21 12:00:00');


-- Day_Static
INSERT INTO Day_Static (day) VALUES 
('Monday'),
('Tuesday'),
('Wednesday'),
('Thursday'),
('Friday'),
('Saturday'),
('Sunday');

-- Course_Level
INSERT INTO Course_Level (level_name) VALUES 
('Beginner'),
('Intermediate'),
('Advanced');

-- Class_Mode
INSERT INTO Class_Mode (mode_name) VALUES 
('Online'),
('In-Person'),
('Hybrid');

-- Review
INSERT INTO Review (course_id, student_id, rating, comments) VALUES 
(16, 3, 5, 'Excellent course, highly recommended!'),
(11, 4, 4, 'Good introduction to database management'),
(17, 5, 5, 'Very informative and well-structured'),
(12, 6, 4, 'Useful content, could have been more interactive'),
(18, 7, 5, 'Great course, improved my communication skills significantly'),
(13, 8, 4, 'Engaging sessions, learned a lot about leadership'),
(19, 9, 5, 'Fantastic strategies for problem-solving'),
(14, 10, 4, 'Good teamwork exercises, learned effective collaboration techniques'),
(20, 1, 5, 'Helped me manage my time better, very practical'),
(15, 2, 4, 'Valuable insights into delivering exceptional customer service');


-- Status
INSERT INTO Status (status_name) VALUES 
('Present'),
('Absent'),
('Late');


-- Attendance
INSERT INTO Attendance (course_id, student_id, attendance_date, status_id) VALUES 
(16, 3, '2024-03-18', 1),
(11, 4, '2024-03-19', 1),
(17, 5, '2024-03-20', 1),
(12, 6, '2024-03-21', 1),
(18, 7, '2024-03-18', 1),
(13, 8, '2024-03-19', 1),
(19, 9, '2024-03-20', 1),
(14, 10, '2024-03-21', 1),
(20, 1, '2024-03-18', 1),
(15, 2, '2024-03-19', 1);


-- Assignment
INSERT INTO Assignment (course_id, description, due_date, max_marks, field_type) VALUES 
    (16, 'Create a simple program using Python', '2024-03-22 23:59:59', 100, 'Programming'),
    (11, 'Design a basic database schema', '2024-03-23 23:59:59', 100, 'Database Management'),
    (17, 'Perform data analysis on a given dataset', '2024-03-24 23:59:59', 100, 'Data Analysis'),
    (12, 'Develop a project plan for a fictional project', '2024-03-25 23:59:59', 100, 'Project Management'),
    (18, 'Deliver a short presentation on a chosen topic', '2024-03-26 23:59:59', 100, 'Communication'),
    (13, 'Write an essay on leadership qualities', '2024-03-27 23:59:59', 100, 'Leadership'),
    (19, 'Solve a series of problem-solving exercises', '2024-03-28 23:59:59', 100, 'Problem Solving'),
    (14, 'Participate in team-building activities', '2024-03-29 23:59:59', 100, 'Teamwork'),
    (20, 'Create a time management plan for your daily activities', '2024-03-30 23:59:59', 100, 'Time Management'),
    (15, 'Provide examples of excellent customer service', '2024-03-31 23:59:59', 100, 'Customer Service')
ON DUPLICATE KEY UPDATE assignment_id = assignment_id; 


INSERT INTO Submissions (assignment_id, student_id, submission_date, grade, feedback) VALUES 
(52, 3, '2024-03-22 10:00:00', 95, 'Well done! Your program works efficiently.'),
(54, 4, '2024-03-23 11:30:00', 85, 'Good effort. Ensure proper normalization in your schema.'),
(56, 5, '2024-03-24 09:45:00', 90, 'Great analysis! Try to include more visualizations for clarity.'),
(58, 6, '2024-03-25 14:20:00', 80, 'Good project plan. Consider adding a risk management section.'),
(60, 7, '2024-03-26 13:15:00', 92, 'Excellent presentation! Your speaking skills have improved significantly.'),
(51, 8, '2024-03-27 10:45:00', 88, 'Insightful essay. Try to elaborate more on transformational leadership.'),
(53, 9, '2024-03-28 12:00:00', 96, 'Well-solved exercises! You demonstrate strong analytical skills.'),
(55, 10, '2024-03-29 15:30:00', 82, 'Good participation in team activities. Ensure equal contribution from all members.'),
(57, 1, '2024-03-30 09:00:00', 94, 'Well-organized time management plan. Stick to it consistently.'),
(59, 2, '2024-03-31 11:00:00', 87, 'Excellent examples of customer service. Try to include more diverse scenarios.');

INSERT INTO Student_Schedule (student_id, course_id, tutor_id) VALUES 
(8, 1, 13),
(3, 2, 16),
(9, 3, 19),
(4, 4, 11),
(10, 5, 14),
(5, 6, 17),
(1, 7, 20),
(6, 8, 12),
(2, 9, 15),
(7, 10, 18);

-- Enrollment
INSERT INTO Enrollment (student_id, course_id, status, date_enrolled, payment_id, comments) VALUES 
(3, 16, 'Enrolled', '2024-03-15 10:00:00', NULL, 'Enrolled in Introduction to Programming'),
(4, 11, 'Enrolled', '2024-03-16 12:00:00', NULL, 'Enrolled in Database Management Fundamentals'),
(5, 17, 'Enrolled', '2024-03-17 15:00:00', NULL, 'Enrolled in Data Analysis Techniques'),
(6, 12, 'Enrolled', '2024-03-18 09:00:00', NULL, 'Enrolled in Project Management Essentials'),
(7, 18, 'Enrolled', '2024-03-19 11:00:00', NULL, 'Enrolled in Effective Communication Skills'),
(8, 13, 'Enrolled', '2024-03-20 13:00:00', NULL, 'Enrolled in Leadership Development Program'),
(9, 19, 'Enrolled', '2024-03-21 14:00:00', NULL, 'Enrolled in Problem Solving Strategies'),
(10, 14, 'Enrolled', '2024-03-22 16:00:00', NULL, 'Enrolled in Teamwork in the Workplace'),
(1, 20, 'Enrolled', '2024-03-23 17:00:00', NULL, 'Enrolled in Time Management Techniques'),
(2, 15, 'Enrolled', '2024-03-24 18:00:00', NULL, 'Enrolled in Customer Service Excellence');


--List the top-performing students based on their overall grades across assignments and courses.

SELECT user.first_name, user.last_name, AVG(submissions.grade) AS avg_grade
FROM user
JOIN submissions ON user.user_id = submissions.student_id
JOIN assignment ON submissions.assignment_id = assignment.assignment_id
JOIN course ON assignment.course_id = course.course_id
WHERE user.role_id = 3 -- Filter for students
GROUP BY user.user_id
ORDER BY avg_grade DESC; 

--Identify the most popular courses

SELECT course.course_title, COUNT(*) AS enrollment_count
FROM course 
JOIN enrollment ON course.course_id = enrollment.course_id
GROUP BY course.course_id
ORDER BY enrollment_count DESC;

--list all tutors and assigned courses

SELECT user.first_name, user.last_name, GROUP_CONCAT(course.course_title) AS courses
FROM user
JOIN course ON user.user_id = course.tutor_id
WHERE user.role_id = 2 -- Filter for tutors
GROUP BY user.user_id;

--popular courses by day of week

SELECT DAYNAME(enrollment.date_enrolled) AS day_of_week, 
       course.course_title, 
       COUNT(*) as enrollments
FROM enrollment
JOIN course ON enrollment.course_id = course.course_id
JOIN course_schedule ON course.course_id = course_schedule.course_id
JOIN day_static ON course_schedule.day_id = day_static.day_id
GROUP BY day_of_week, course.course_title
ORDER BY day_of_week; 

--ratings as per tutor

SELECT user.first_name, user.last_name, AVG(review.rating) AS avg_rating
FROM review
JOIN course ON review.course_id = course.course_id
JOIN user ON course.tutor_id = user.user_id
WHERE user.role_id = 2 -- For tutors
GROUP BY user.user_id
ORDER BY avg_rating DESC;

--Revenue over time
SELECT DATE(payments.payment_date) AS payment_date, SUM(amount) AS daily_revenue
FROM payments
GROUP BY DATE(payments.payment_date);

select 


















 

































