CREATE DATABASE COLLABORATION_PROJECT;
USE COLLABORATION_PROJECT;

-- **************** STATIC TABLES ***********************

-- Create Type_Of_User_Account Table
CREATE TABLE Type_Of_User_Account (
	Type_Of_User_Account_ID INT PRIMARY KEY AUTO_INCREMENT,
    Type_Of_User_Account VARCHAR(10)
);

-- Inserting values in Type_Of_User_Account Table
INSERT INTO Type_Of_User_Account (Type_Of_User_Account_ID, Type_Of_User_Account) VALUES 
(1, 'Teacher'),
(2, 'Student'),
(3, 'Admin');

-- Create Time_Zone Table
CREATE TABLE Time_Zone (
	Time_Zone_ID INT PRIMARY KEY AUTO_INCREMENT,
    Time_Zone_City VARCHAR(50),
    Time_Zone_Code VARCHAR(50)
);

-- Inserting values in Time_Zone Table
-- INSERT INTO Time_Zone (Time_Zone_ID, Time_Zone_City, Time_Zone_Code) VALUES 
-- (1, ''),
-- (2, ''),
-- (3, '');
INSERT INTO Time_Zone (Time_Zone_ID, Time_Zone_City, Time_Zone_Code) VALUES 
(1, 'New York', 'EST'),
(2, 'Los Angeles', 'PST'),
(3, 'Chicago', 'CST'),
(4, 'London', 'GMT'),
(5, 'Paris', 'CET'),
(6, 'Tokyo', 'JST'),
(7, 'Sydney', 'AEDT'),
(8, 'Hong Kong', 'HKT'),
(9, 'Dubai', 'GST'),
(10, 'Moscow', 'MSK');


-- Create Preference_of_Class_Mode Table
CREATE TABLE Preference_of_Class_Mode (
	Preference_Of_Class_Mode_ID INT PRIMARY KEY AUTO_INCREMENT,
    Preference_Of_Class_Mode VARCHAR(50)
);

-- Inserting values in Preference_of_Class_Mode Table
INSERT INTO Preference_of_Class_Mode (Preference_Of_Class_Mode_ID, Preference_Of_Class_Mode) VALUES 
(1, 'Online'),
(2, 'In-Person'),
(3, 'Both');

-- Create Rating Table
CREATE TABLE Rating (
	Rating_ID INT PRIMARY KEY AUTO_INCREMENT,
    Rating_Value INT
);

-- Inserting values in Rating Table
INSERT INTO Rating (Rating_ID, Rating_Value) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Create Course_Category Table
CREATE TABLE Course_Category (
	Course_Category_ID INT PRIMARY KEY AUTO_INCREMENT,
    Course_Category_Name VARCHAR(50)
);

-- Inserting values in Course_Category Table
-- INSERT INTO Course_Category (Course_Category_ID, Course_Category_Name) VALUES 
-- (1, ''),
-- (2, ''),
-- (3, '');


-- Create Course_Sub_Category Table
CREATE TABLE Course_Sub_Category (
	Course_Sub_Category_ID INT PRIMARY KEY AUTO_INCREMENT,
    Course_Sub_Category_Name VARCHAR(50)
);

-- Inserting values in Course_Sub_Category Table
-- INSERT INTO Course_Sub_Category (Course_Sub_Category_ID, Course_Sub_Category_Name) VALUES 
-- (1, ''),
-- (2, ''),
-- (3, '');

-- Create Skills Table
CREATE TABLE Skills (
	Skill_ID INT PRIMARY KEY AUTO_INCREMENT,
    Skill_Name VARCHAR(50)
);

-- Inserting values in Skills Table
-- INSERT INTO Skills (Skill_ID, Skill_Name) VALUES 
-- (1, ''),
-- (2, ''),
-- (3, '');


-- Create Course_Level Table
CREATE TABLE Course_Level (
	Course_Level_ID INT PRIMARY KEY AUTO_INCREMENT,
    Course_Level_Name VARCHAR(50)
);

-- Inserting values in Course_Level Table
INSERT INTO Course_Level (Course_Level_ID, Course_Level_Name) VALUES 
(1, 'Beginner'),
(2, 'Intermediate'),
(3, 'Expert');

-- Create Course_Language Table
CREATE TABLE Course_Language (
	Course_Language_ID INT PRIMARY KEY AUTO_INCREMENT,
    Course_Language_Name VARCHAR(50)
);

-- Inserting values in Course_Language Table
-- INSERT INTO Course_Language (Course_Language_ID, Course_Language_Name) VALUES 
-- (1, ''),
-- (2, ''),
-- (3, '');

-- Create Approval_Status Table
CREATE TABLE Approval_Status (
	Approval_Status_ID INT PRIMARY KEY AUTO_INCREMENT,
    Approval_Status_Type VARCHAR(50)
);

-- Inserting values in Approval_Status Table
INSERT INTO Approval_Status (Approval_Status_ID, Approval_Status_Type) VALUES 
(1, 'Approved'),
(2, 'Not Approved');


-- Create Enrollment_Status Table
CREATE TABLE Enrollment_Status (
	Enrollment_Status_ID INT PRIMARY KEY AUTO_INCREMENT,
    Enrollment_Status_Name VARCHAR(50)
);

-- Inserting values in Enrollement_Status Table
INSERT INTO Enrollment_Status (Enrollment_Status_ID, Enrollment_Status_Name) VALUES 
(1, 'Enrolled'),
(2, 'Not Enrolled');


-- Create Payment_Methods Table
CREATE TABLE Payment_Methods (
	Payment_Method_ID INT PRIMARY KEY AUTO_INCREMENT,
    Payment_Method_Name VARCHAR(50)
);

-- Inserting values in Payment_Methods Table
INSERT INTO Payment_Methods (Payment_Method_ID, Payment_Method_Name) VALUES 
(1, 'Credit Card'),
(2, 'Debit Card'),
(3, 'Apple Pay'),
(4, 'Paypal');

-- ***************************** CREATING TABLES ***********************

-- Create Address Table
CREATE TABLE Address (
    Address_ID INT PRIMARY KEY,
    Address_Line1 TEXT,
    Address_Line2 TEXT,
    City TEXT,
    State TEXT,
    Country TEXT,
    Zipcode INT 
); 

-- Create USER Table
CREATE TABLE USER (
    User_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Email VARCHAR(100),
    Password VARCHAR(100), 
    Date_Of_Birth DATE,
    Type_Of_User_Account_ID INT,
    Phone_Number INT, 
    Address_ID INT,
    Time_Zone_ID INT,
    Account_Reguistration_TimeDateStamp DATETIME,
    FOREIGN KEY (Type_Of_User_Account_ID) REFERENCES Type_Of_User_Account(Type_Of_User_Account_ID),
    FOREIGN KEY (Address_ID) REFERENCES Address(Address_ID),
    FOREIGN KEY (Time_Zone_ID) REFERENCES Time_Zone(Time_Zone_ID)
);

-- Create Teacher Table
CREATE TABLE Teacher (
    Teacher_ID INT PRIMARY KEY,
    User_ID INT,
    Skills_Experties TEXT,
    Preference_Of_Class_Mode_ID INT,
    Profile_Description TEXT,
    Profile_Rating TEXT, 
    Social_Profile TEXT,
    FOREIGN KEY (User_ID) REFERENCES USER(User_ID),
    FOREIGN KEY (Preference_Of_Class_Mode_ID) REFERENCES Preference_of_Class_Mode(Preference_Of_Class_Mode_ID) 
);

-- Create Student Table
CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    User_ID INT,
    Interested_Skills TEXT,
    Preference_Of_Class_Mode_ID INT,
    No_of_Sub_Users INT,
    Social_Profiles TEXT,
    FOREIGN KEY (User_ID) REFERENCES USER(User_ID),
    FOREIGN KEY (Preference_Of_Class_Mode_ID) REFERENCES Preference_of_Class_Mode(Preference_Of_Class_Mode_ID) 
);

-- Create Course Table
CREATE TABLE Course (
    Course_ID INT PRIMARY KEY,
    Teacher_ID INT,
    Course_Category_ID INT,
    Course_Sub_Category_ID INT,
    Skill_ID INT,
    Course_Level_ID INT,
    Course_Title TEXT,
    Course_Teaching_Mode_ID INT, 
    Class_Details TEXT,
    Course_Language_ID INT,
    Class_Capacity INT,
    Description TEXT,
    Course_Schedule_ID INT,
    Rating_ID INT,
    Price_of_Course FLOAT,
    Course_Registration_DateTimeStamp DATETIME,
    Approval_Status_ID INT,
    FOREIGN KEY (Teacher_ID) REFERENCES Teacher(Teacher_ID),
    FOREIGN KEY (Course_Category_ID) REFERENCES Course_Category(Course_Category_ID),
    FOREIGN KEY (Course_Sub_Category_ID) REFERENCES Course_Sub_Category(Course_Sub_Category_ID),
    FOREIGN KEY (Skill_ID) REFERENCES Skills(Skill_ID),
    FOREIGN KEY (Course_Level_ID) REFERENCES Course_Level(Course_Level_ID),
    FOREIGN KEY (Course_Teaching_Mode_ID) REFERENCES Preference_of_Class_Mode(Preference_Of_Class_Mode_ID)
);

-- Create Course_Schedule Table
CREATE TABLE Course_Schedule (
    Course_Schedule_ID INT PRIMARY KEY,
    Start_Date DATE,
    End_Date DATE,
    Start_time TIME,
    End_time TIME
);

-- Create Assignment Table
CREATE TABLE Assignment (
    Assignment_ID INT PRIMARY KEY,
    CourseID INT,
    Description TEXT,
    Due_Date DATETIME,
    Max_Marks INT,
    FOREIGN KEY (CourseID) REFERENCES Course(Course_ID)
);

-- Create Submissions Table
CREATE TABLE Submissions (
    Submission_ID INT PRIMARY KEY,
    Assignment_ID INT,
    Student_ID INT,
    Submitted_Date DATETIME,
    Marks INT,
    Grade VARCHAR(5), 
    FOREIGN KEY (Assignment_ID) REFERENCES Assignment(Assignment_ID),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID)
);

-- Create  Attendance Table
CREATE TABLE Attendance (
    Attendence_ID INT PRIMARY KEY,
    Student_ID INT,
    Course_ID INT,
    AttendenceStatus VARCHAR(20), 
    Attendance_Percentage FLOAT,
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

-- Create Enrollment Table
CREATE TABLE Enrollment (
    Enrollment_ID INT PRIMARY KEY,
    Student_ID INT,
    Course_ID INT,
    Enrollment_Status_ID INT,
    Enrollment_DateTimeStamp DATETIME,
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID),
    FOREIGN KEY (Enrollment_Status_ID) REFERENCES Enrollment_Status(Enrollment_Status_ID)
);

-- Create Payments Table
CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY,
    Course_ID INT,
    Student_ID INT,
    Amount FLOAT,
    Payment_Method_ID INT,
    Payment_DateTimeStamp DATETIME,
    TransactionID VARCHAR(100),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Payment_Method_ID) REFERENCES Payment_Methods(Payment_Method_ID)
);

-- Create Notifications Table
CREATE TABLE Notifications (
    Notification_ID INT PRIMARY KEY,
    User_ID INT,
    Notification_Title VARCHAR(100),
    Notifiication_Description TEXT,
    Notification_DateTimeStamp DATETIME,
    FOREIGN KEY (User_ID) REFERENCES USER(User_ID)
);


-- ***************************** INSERT QUERIES ***********************

-- -- Inserting data into Address Table
-- INSERT INTO Address (Address_ID, Address_Line1, Address_Line2, City, State, Country, Zipcode) VALUES 
-- (1, '123 Main St', 'Apt 101', 'New York', 'NY', 'USA', 10001),
-- (2, '456 Elm St', NULL, 'Los Angeles', 'CA', 'USA', 90001),
-- (3, '789 Oak St', NULL, 'Chicago', 'IL', 'USA', 60601),
-- (4, '101 Pine St', 'Unit 201', 'San Francisco', 'CA', 'USA', 94101),
-- (5, '234 Maple St', NULL, 'Houston', 'TX', 'USA', 77001),
-- (6, '567 Cedar St', NULL, 'Miami', 'FL', 'USA', 33101),
-- (7, '890 Walnut St', 'Suite 301', 'Boston', 'MA', 'USA', 02101),
-- (8, '111 Birch St', NULL, 'Seattle', 'WA', 'USA', 98101),
-- (9, '222 Spruce St', NULL, 'Atlanta', 'GA', 'USA', 30301),
-- (10, '333 Elm St', NULL, 'Dallas', 'TX', 'USA', 75201);

-- -- Inserting data into USER Table
-- INSERT INTO USER (User_ID, First_Name, Last_Name, Email, Password, Date_Of_Birth, Type_Of_User_Account_ID, Phone_Number, Address_ID, Time_Zone_ID, Account_Registration_TimeDateStamp) VALUES 
-- (1, 'John', 'Doe', 'john@example.com', 'password123', '1990-01-01', 1, 1234567890, 1, 1, NOW()),
-- (2, 'Jane', 'Smith', 'jane@example.com', 'password456', '1995-02-15', 2, 9876543210, 2, 2, NOW()),
-- (3, 'Mike', 'Johnson', 'mike@example.com', 'password789', '1985-07-20', 1, 5556667777, 3, 3, NOW()),
-- (4, 'Emily', 'Brown', 'emily@example.com', 'passwordabc', '1988-09-10', 2, 3334445555, 4, 4, NOW()),
-- (5, 'Chris', 'Taylor', 'chris@example.com', 'passwordxyz', '1993-04-05', 1, 2223334444, 5, 5, NOW()),
-- (6, 'Sarah', 'Wilson', 'sarah@example.com', 'passworddef', '1998-11-25', 2, 6667778888, 6, 6, NOW()),
-- (7, 'David', 'Martinez', 'david@example.com', 'passwordghi', '1991-03-15', 1, 7778889999, 7, 7, NOW()),
-- (8, 'Amanda', 'Lee', 'amanda@example.com', 'passwordjkl', '1986-06-30', 2, 8889990000, 8, 8, NOW()),
-- (9, 'Ryan', 'Garcia', 'ryan@example.com', 'passwordmno', '1994-08-12', 1, 9990001111, 9, 9, NOW()),
-- (10, 'Rachel', 'Nguyen', 'rachel@example.com', 'passwordpqr', '1987-12-28', 2, 1231231234, 10, 10, NOW());

-- -- Inserting data into Teacher Table
-- INSERT INTO Teacher (Teacher_ID, User_ID, Skills_Experties, Preference_Of_Class_Mode_ID, Profile_Description, Profile_Rating, Social_Profile) VALUES 
-- (1, 1, 'Computer Science, Mathematics', 1, 'Experienced teacher with 10+ years of teaching experience.', '5 stars', 'https://twitter.com/teacher1'),
-- (2, 3, 'Physics, Chemistry', 2, 'Passionate about teaching science to students.', '4.5 stars', 'https://www.linkedin.com/teacher2'),
-- (3, 5, 'English Literature, Writing', 3, 'Published author with expertise in literature and writing.', '4 stars', 'https://www.facebook.com/teacher3'),
-- (4, 7, 'History, Social Studies', 1, 'Dedicated to making history come alive for students.', '4.8 stars', 'https://www.instagram.com/teacher4'),
-- (5, 9, 'Art, Music', 2, 'Inspiring creativity through art and music education.', '4.2 stars', 'https://www.pinterest.com/teacher5'),
-- (6, 11, 'Biology, Environmental Science', 3, 'Passionate about exploring the wonders of the natural world.', '4.7 stars', 'https://www.youtube.com/teacher6'),
-- (7, 13, 'Foreign Languages', 1, 'Experienced language teacher offering personalized instruction.', '4.9 stars', 'https://www.twitch.tv/teacher7'),
-- (8, 15, 'Physical Education, Sports', 2, 'Promoting health and fitness through physical education programs.', '4.3 stars', 'https://www.snapchat.com/teacher8'),
-- (9, 17, 'Business, Economics', 3, 'Preparing students for success in the business world.', '4.6 stars', 'https://www.tiktok.com/teacher9'),
-- (10, 19, 'Engineering, Technology', 1, 'Innovative educator leveraging technology in the classroom.', '4.4 stars', 'https://www.whatsapp.com/teacher10');

-- -- Inserting data into Student Table
-- INSERT INTO Student (Student_ID, User_ID, Interested_Skills, Preference_Of_Class_Mode_ID, No_of_Sub_Users, Social_Profiles) VALUES 
-- (1, 2, 'Computer Programming, Mathematics', 1, 0, 'https://twitter.com/student1'),
-- (2, 4, 'Chemistry, Biology', 2, 1, 'https://www.linkedin.com/student2'),
-- (3, 6, 'Creative Writing, Literature', 3, 0, 'https://www.facebook.com/student3'),
-- (4, 8, 'History, Geography', 1, 2, 'https://www.instagram.com/student4'),
-- (5, 10, 'Art, Music', 2, 0, 'https://www.pinterest.com/student5'),
-- (6, 12, 'Environmental Science, Conservation', 3, 1, 'https://www.youtube.com/student6'),
-- (7, 14, 'French, Spanish', 1, 0, 'https://www.twitch.tv/student7'),
-- (8, 16, 'Basketball, Soccer', 2, 1, 'https://www.snapchat.com/student8'),
-- (9, 18, 'Entrepreneurship, Finance', 3, 0, 'https://www.tiktok.com/student9'),
-- (10, 20, 'Computer Engineering, Robotics', 1, 2, 'https://www.whatsapp.com/student10');

-- -- Inserting data into Course Table
-- INSERT INTO Course (Course_ID, Teacher_ID, Course_Category_ID, Course_Sub_Category_ID, Skill_ID, Course_Level_ID, Course_Title, Course_Teaching_Mode_ID, Class_Details, Course_Language_ID, Class_Capacity, Description, Course_Schedule_ID, Rating_ID, Price_of_Course, Course_Registration_DateTimeStamp, Approval_Status_ID) VALUES 
-- (1, 1, 1, 1, 1, 1, 'Introduction to Programming', 1, 'Learn the fundamentals of programming.', 1, 20, 'This course covers basic programming concepts such as variables, loops, and functions.', 1, 1, 49.99, NOW(), 1),
-- (2, 3, 2, 1, 2, 2, 'Creative Writing Workshop', 2, 'Explore your creativity through writing.', 3, 15, 'This workshop focuses on developing writing skills through various exercises and prompts.', 2, 2, 29.99, NOW(), 1),
-- (3, 5, 3, 1, 3, 3, 'Art Appreciation Course', 1, 'Discover the world of art through history and analysis.', 2, 25, 'This course explores different art movements, styles, and techniques.', 3, 3, 39.99, NOW(), 1),
-- (4, 7, 4, 1, 4, 1, 'Introduction to French Language', 2, 'Learn the basics of French language and culture.', 1, 30, 'This course covers essential French vocabulary, grammar, and pronunciation.', 1, 4, 19.99, NOW(), 1),
-- (5, 9, 5, 1, 5, 2, 'Financial Planning Masterclass', 1, 'Take control of your finances and plan for the future.', 2, 20, 'This masterclass provides practical advice on budgeting, saving, and investing.', 2, 5, 59.99, NOW(), 1),
-- (6, 2, 1, 2, 6, 3, 'Advanced Programming Techniques', 2, 'Dive deeper into advanced programming concepts.', 3, 15, 'This course covers advanced topics such as data structures, algorithms, and optimization techniques.', 3, 4, 69.99, NOW(), 1),
-- (7, 4, 2, 2, 7, 1, 'Chemistry Lab Practicum', 1, 'Hands-on experience with chemistry experiments.', 1, 10, 'This practicum allows students to apply theoretical knowledge in a laboratory setting.', 1, 5, 79.99, NOW(), 1),
-- (8, 6, 3, 2, 8, 2, 'Literature Seminar Series', 2, 'Engage in critical discussions about literature.', 2, 20, 'This seminar series explores various literary works and themes.', 2, 1, 49.99, NOW(), 1),
-- (9, 8, 4, 2, 9, 3, 'Entrepreneurship Bootcamp', 1, 'Launch your own business with confidence.', 1, 25, 'This bootcamp provides practical guidance on starting and growing a successful business.', 3, 2, 89.99, NOW(), 1),
-- (10, 10, 5, 2, 10, 1, 'Introduction to Robotics', 2, 'Explore the exciting world of robotics.', 2, 20, 'This course introduces basic robotics concepts and hands-on projects.', 2, 3, 59.99, NOW(), 1);

-- -- Inserting data into Course_Schedule Table
-- INSERT INTO Course_Schedule (Course_Schedule_ID, Start_Date, End_Date, Start_time, End_time) VALUES 
-- (1, '2024-05-01', '2024-06-01', '09:00:00', '12:00:00'),
-- (2, '2024-05-15', '2024-07-15', '13:00:00', '16:00:00'),
-- (3, '2024-06-01', '2024-07-01', '10:00:00', '13:00:00'),
-- (4, '2024-06-15', '2024-08-15', '14:00:00', '17:00:00'),
-- (5, '2024-07-01', '2024-08-01', '11:00:00', '14:00:00'),
-- (6, '2024-07-15', '2024-09-15', '15:00:00', '18:00:00'),
-- (7, '2024-08-01', '2024-09-01', '12:00:00', '15:00:00'),
-- (8, '2024-08-15', '2024-10-15', '16:00:00', '19:00:00'),
-- (9, '2024-09-01', '2024-10-01', '13:00:00', '16:00:00'),
-- (10, '2024-09-15', '2024-11-15', '17:00:00', '20:00:00');

-- -- Inserting data into Assignment Table
-- INSERT INTO Assignment (Assignment_ID, CourseID, Description, Due_Date, Max_Marks) VALUES 
-- (1, 1, 'Programming Assignment 1: Variables and Control Structures', '2024-05-15 23:59:59', 100),
-- (2, 1, 'Programming Assignment 2: Functions and Arrays', '2024-06-01 23:59:59', 100),
-- (3, 2, 'Creative Writing Assignment 1: Short Story', '2024-05-30 23:59:59', 100),
-- (4, 2, 'Creative Writing Assignment 2: Poetry', '2024-06-15 23:59:59', 100),
-- (5, 3, 'Art Project 1: Drawing Basics', '2024-06-15 23:59:59', 100),
-- (6, 3, 'Art Project 2: Painting Techniques', '2024-07-01 23:59:59', 100),
-- (7, 4, 'French Language Exercise 1: Vocabulary Quiz', '2024-05-25 23:59:59', 100),
-- (8, 4, 'French Language Exercise 2: Speaking Assessment', '2024-06-10 23:59:59', 100),
-- (9, 5, 'Financial Planning Project 1: Budget Analysis', '2024-06-10 23:59:59', 100),
-- (10, 5, 'Financial Planning Project 2: Investment Portfolio', '2024-06-30 23:59:59', 100);

-- -- Inserting data into Submissions Table
-- INSERT INTO Submissions (Submission_ID, Assignment_ID, Student_ID, Submitted_Date, Marks, Grade) VALUES 
-- (1, 1, 1, '2024-05-15 10:00:00', 90, 'A'),
-- (2, 1, 2, '2024-05-16 11:00:00', 85, 'A-'),
-- (3, 2, 1, '2024-06-01 09:00:00', 95, 'A+'),
-- (4, 2, 2, '2024-06-02 10:00:00', 80, 'B'),
-- (5, 3, 3, '2024-05-30 15:00:00', 90, 'A'),
-- (6, 3, 4, '2024-05-31 16:00:00', 85, 'A-'),
-- (7, 4, 3, '2024-06-15 10:00:00', 95, 'A+'),
-- (8, 4, 4, '2024-06-16 11:00:00', 80, 'B'),
-- (9, 5, 5, '2024-06-15 14:00:00', 90, 'A'),
-- (10, 5, 6, '2024-06-16 15:00:00', 85, 'A-');

-- -- Inserting data into Attendance Table
-- INSERT INTO Attendance (Attendence_ID, Student_ID, Course_ID, AttendenceStatus, Attendance_Percentage) VALUES 
-- (1, 1, 1, 'Present', 95.0),
-- (2, 2, 1, 'Present', 90.0),
-- (3, 3, 2, 'Present', 85.0),
-- (4, 4, 2, 'Present', 80.0),
-- (5, 5, 3, 'Present', 95.0),
-- (6, 6, 3, 'Present', 90.0),
-- (7, 7, 4, 'Present', 85.0),
-- (8, 8, 4, 'Present', 80.0),
-- (9, 9, 5, 'Present', 95.0),
-- (10, 10, 5, 'Present', 90.0);

-- -- Inserting data into Enrollment Table
-- INSERT INTO Enrollment (Enrollment_ID, Student_ID, Course_ID, Enrollment_Status_ID, Enrollment_DateTimeStamp) VALUES 
-- (1, 1, 1, 1, NOW()),
-- (2, 2, 1, 1, NOW()),
-- (3, 3, 2, 1, NOW()),
-- (4, 4, 2, 1, NOW()),
-- (5, 5, 3, 1, NOW()),
-- (6, 6, 3, 1, NOW()),
-- (7, 7, 4, 1, NOW()),
-- (8, 8, 4, 1, NOW()),
-- (9, 9, 5, 1, NOW()),
-- (10, 10, 5, 1, NOW());

-- -- Inserting data into Payments Table
-- INSERT INTO Payments (Payment_ID, Course_ID, Student_ID, Amount, Payment_Method_ID, Payment_DateTimeStamp, TransactionID) VALUES 
-- (1, 1, 1, 49.99, 1, NOW(), '123456789'),
-- (2, 1, 2, 49.99, 2, NOW(), '987654321'),
-- (3, 2, 3, 29.99, 3, NOW(), '555666777'),
-- (4, 2, 4, 29.99, 4, NOW(), '333444555'),
-- (5, 3, 5, 39.99, 1, NOW(), '222333444'),
-- (6, 3, 6, 39.99, 2, NOW(), '666777888'),
-- (7, 4, 7, 19.99, 3, NOW(), '777888999'),
-- (8, 4, 8, 19.99, 4, NOW(), '888999000'),
-- (9, 5, 9, 59.99, 1, NOW(), '999000111'),
-- (10, 5, 10, 59.99, 2, NOW(), '123123123');

-- -- Inserting data into Notifications Table
-- INSERT INTO Notifications (Notification_ID, User_ID, Notification_Title, Notifiication_Description, Notification_DateTimeStamp) VALUES 
-- (1, 1, 'New Course Enrollment', 'You have been successfully enrolled in the course "Introduction to Programming".', NOW()),
-- (2, 2, 'New Payment Confirmation', 'Your payment for the course "Introduction to Programming" has been confirmed.', NOW()),
-- (3, 3, 'New Assignment Submission', 'Your assignment submission for "Programming Assignment 1" has been received.', NOW()),
-- (4, 4, 'New Course Enrollment', 'You have been successfully enrolled in the course "Creative Writing Workshop".', NOW()),
-- (5, 5, 'New Payment Confirmation', 'Your payment for the course "Creative Writing Workshop" has been confirmed.', NOW()),
-- (6, 6, 'New Assignment Submission', 'Your assignment submission for "Creative Writing Assignment 1" has been received.', NOW()),
-- (7, 7, 'New Course Enrollment', 'You have been successfully enrolled in the course "Art Appreciation Course".', NOW()),
-- (8, 8, 'New Payment Confirmation', 'Your payment for the course "Art Appreciation Course" has been confirmed.', NOW()),
-- (9, 9, 'New Assignment Submission', 'Your assignment submission for "Art Project 1" has been received.', NOW()),
-- (10, 10, 'New Course Enrollment', 'You have been successfully enrolled in the course "Introduction to French Language".', NOW());
