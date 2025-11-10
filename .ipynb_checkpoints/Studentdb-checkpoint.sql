CREATE DATABASE student_db;
USE student_db;

CREATE TABLE Students (
  StudentID INT PRIMARY KEY AUTO_INCREMENT,
  RollNo VARCHAR(10) UNIQUE NOT NULL,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50),
  Gender CHAR(1),
  Year INT,
  Department VARCHAR(50)
);

CREATE TABLE Courses (
  CourseID INT PRIMARY KEY AUTO_INCREMENT,
  CourseCode VARCHAR(10) UNIQUE NOT NULL,
  CourseName VARCHAR(100) NOT NULL,
  MaxMarks INT DEFAULT 100
);

CREATE TABLE Grades (
  GradeID INT PRIMARY KEY AUTO_INCREMENT,
  StudentID INT,
  CourseID INT,
  MarksObtained DECIMAL(5,2),
  ExamDate DATE,
  FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
  FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

CREATE TABLE Attendance (
  AttendanceID INT PRIMARY KEY AUTO_INCREMENT,
  StudentID INT,
  CourseID INT,
  TotalClasses INT,
  ClassesAttended INT,
  Month VARCHAR(20),
  FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
  FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Updated student names
INSERT INTO Students (RollNo, FirstName, LastName, Gender, Year, Department) VALUES
('BCA001', 'Aarav', 'Patil', 'M', 3, 'BCA'),
('BCA002', 'Diya', 'Menon', 'F', 3, 'BCA'),
('BCA003', 'Rohan', 'Verma', 'M', 3, 'BCA'),
('BCA004', 'Sneha', 'Pillai', 'F', 3, 'BCA'),
('BCA005', 'Aditya', 'Sharma', 'M', 3, 'BCA'),
('BCA006', 'Meera', 'Nair', 'F', 3, 'BCA'),
('BCA007', 'Vikram', 'Das', 'M', 3, 'BCA'),
('BCA008', 'Ishita', 'Rao', 'F', 3, 'BCA'),
('BCA009', 'Karan', 'Kapoor', 'M', 3, 'BCA'),
('BCA010', 'Nisha', 'Patel', 'F', 3, 'BCA');

INSERT INTO Courses (CourseCode, CourseName, MaxMarks) VALUES
('CS101', 'Introduction to Programming', 100);

INSERT INTO Grades (StudentID, CourseID, MarksObtained, ExamDate) VALUES
(1, 1, 72, '2025-04-10'),
(2, 1, 48, '2025-04-10'),
(3, 1, 55, '2025-04-10'),
(4, 1, 33, '2025-04-10'),
(5, 1, 88, '2025-04-10'),
(6, 1, 60, '2025-04-10'),
(7, 1, 25, '2025-04-10'),
(8, 1, 79, '2025-04-10'),
(9, 1, 46, '2025-04-10'),
(10, 1, 69, '2025-04-10');

INSERT INTO Attendance (StudentID, CourseID, TotalClasses, ClassesAttended, Month) VALUES
(1, 1, 40, 36, 'Apr-2025'),
(2, 1, 40, 20, 'Apr-2025'),
(3, 1, 40, 28, 'Apr-2025'),
(4, 1, 40, 12, 'Apr-2025'),
(5, 1, 40, 38, 'Apr-2025'),
(6, 1, 40, 31, 'Apr-2025'),
(7, 1, 40, 8, 'Apr-2025'),
(8, 1, 40, 35, 'Apr-2025'),
(9, 1, 40, 18, 'Apr-2025'),
(10, 1, 40, 33, 'Apr-2025');

SELECT 
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    ROUND(AVG(g.MarksObtained), 2) AS AverageMarks
FROM 
    Students s
JOIN 
    Grades g ON s.StudentID = g.StudentID
GROUP BY 
    s.StudentID;

SELECT 
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    ROUND((a.ClassesAttended / a.TotalClasses) * 100, 2) AS AttendancePercentage
FROM 
    Students s
JOIN 
    Attendance a ON s.StudentID = a.StudentID;

SELECT 
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    ROUND(AVG(g.MarksObtained), 2) AS AvgMarks,
    ROUND(AVG((a.ClassesAttended / a.TotalClasses) * 100), 2) AS AttendancePercent
FROM 
    Students s
JOIN 
    Grades g ON s.StudentID = g.StudentID
JOIN 
    Attendance a ON s.StudentID = a.StudentID
GROUP BY 
    s.StudentID;

-- Start transaction
START TRANSACTION;

-- Insert new grade record
INSERT INTO Grades (StudentID, CourseID, MarksObtained, ExamDate)
VALUES (1, 1, 95, '2025-05-01');

-- Check data before commit
SELECT * FROM Grades WHERE StudentID = 1;

-- If you are satisfied:
COMMIT;

-- Or if you want to cancel the changes:
ROLLBACK;