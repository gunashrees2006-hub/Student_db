create database student_db;
use student_db;
CREATE TABLE Students (
    student_id INT PRIMARY KEY ,
    name VARCHAR(50),
    department VARCHAR(30),
    semester INT
);
CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY ,
    student_id INT,
    total_classes INT,
    attended_classes INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);
CREATE TABLE Marks (
    mark_id INT PRIMARY KEY ,
    student_id INT,
    subject VARCHAR(50),
    marks_obtained INT,
    max_marks INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);
INSERT INTO Students (student_id,name, department, semester) VALUES
(1,'Aarav', 'BCA', 5),
(2,'Diya', 'BCA', 5),
(3,'Kiran', 'BCA', 5),
(4,'Leela', 'BCA', 5),
(5,'Ravi', 'BCA', 5),
(6,'Neha', 'BCA', 5),
(7,'Rahul', 'BCA', 5),
(8,'Anita', 'BCA', 5),
(9,'Varun', 'BCA', 5),
(10,'Pooja', 'BCA', 5);
INSERT INTO Attendance (student_id, total_classes, attendance_id) VALUES
(1, 50, 45),
(2, 50, 38),
(3, 50, 42),
(4, 50, 35),
(5, 50, 47),
(6, 50, 40),
(7, 50, 48),
(8, 50, 33),
(9, 50, 46),
(10, 50, 41);
INSERT INTO Marks (mark_id, student_id, subject, marks_obtained, max_marks) VALUES
(1, 1, 'Python', 88, 100),
(2, 2, 'Python', 65, 100),
(3, 3, 'Python', 72, 100),
(4, 4, 'Python', 55, 100),
(5, 5, 'Python', 90, 100),
(6, 6, 'Python', 68, 100),
(7, 7, 'Python', 92, 100),
(8, 8, 'Python', 52, 100),
(9, 9, 'Python', 84, 100),
(10, 10, 'Python', 60, 100);

-- Average marks per student
SELECT s.name, AVG(m.marks_obtained) AS avg_marks
FROM Students s
JOIN Marks m ON s.student_id = m.student_id
GROUP BY s.name;

-- Attendance percentage
SELECT s.name, (a.attended_classes / a.total_classes) * 100 AS attendance_percent
FROM Students s
JOIN Attendance a ON s.student_id = a.student_id;

-- Correlation-like data (for ML)
SELECT 
    s.student_id,
    s.name,
    (SUM(a.attended_classes) / SUM(a.total_classes)) * 100 AS attendance_percent,
    AVG(m.marks_obtained) AS avg_marks
FROM Students s
JOIN Attendance a ON s.student_id = a.student_id
JOIN Marks m ON s.student_id = m.student_id
GROUP BY s.student_id, s.name;


SELECT COUNT(*) FROM Students;
SELECT COUNT(*) FROM Attendance;
SELECT COUNT(*) FROM Marks;

-- check if student IDs match across tables
SELECT DISTINCT s.student_id
FROM Students s
LEFT JOIN Attendance a ON s.student_id = a.student_id
LEFT JOIN Marks m ON s.student_id = m.student_id
WHERE a.student_id IS NULL OR m.student_id IS NULL;