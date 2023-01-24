CREATE DATABASE IF NOT EXISTS IronDB;
USE IronDB;

CREATE TABLE Students (
	StudentID int,
	Name varchar(255),
	Surname  varchar(255),
	Course_id int
);

CREATE TABLE Teachers(
TeacherID int,
Name varchar(255),
Surname varchar(255)
);

CREATE TABLE Courses(
CourseID int,
Title varchar(255),
Form varchar(255),
TeacherID int
);

INSERT INTO courses (CourseID, Title, Form, TeacherID)
VALUES (111, 'DA', 'Fulltime', 1),
(112, 'WEB', 'Parttime', 2),
(113, 'UIUX', 'Fulltime', 3);

UPDATE courses
SET Form = 'Fulltime'
WHERE CourseID = 112;

select * from courses;

INSERT INTO courses (CourseID, Title, Form, TeacherID)
VALUES (114, 'DA', 'Parttime', 1),
(115, 'WEB', 'Parttime', 2),
(116, 'UIUX', 'Parttime', 3);

SELECT * FROM courses
LIMIT 2;

SELECT Title, Form FROM courses
WHERE Title = "DA";

SELECT Title, TeacherID FROM courses
WHERE Form="Fulltime"
Order by Title DESC;

SELECT Title, count(Title) FROM courses
GROUP BY Title;

