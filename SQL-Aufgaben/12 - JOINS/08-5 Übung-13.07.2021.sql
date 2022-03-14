--Aufgabe 1 
--Es sind die folgenden Tabellen gegeben: 
--Das entsprechende Skript finden Sie in der Freigabe zum Unterricht (Courses.sql). Beant
--die folgenden Fragen zu den Daten: 
USE TeachSQL;

SELECT *
FROM tblCourse;

SELECT *
FROM tblCourseAttendence;

SELECT *
FROM tblAttendee;

--1. Gibt es Kurse, die von keinem Teilnehmer gebucht wurden?
SELECT c.Name, a.AttendeeID
FROM tblCourseAttendence AS ca
RIGHT OUTER JOIN tblCourse AS c
ON ca.CourseID = c.CourseID
LEFT OUTER JOIN tblAttendee AS a
ON  ca.AttendeeID = a.AttendeeID
WHERE a.AttendeeID IS NULL;
 
--2. Gibt es Teilnehmer, die keinem Kurs zugeordnet sind?
SELECT a.FirstName, a.LastName, c.CourseID
FROM tblCourseAttendence AS ca
LEFT OUTER JOIN tblCourse AS c
ON ca.CourseID = c.CourseID
RIGHT OUTER JOIN tblAttendee AS a
ON  ca.AttendeeID = a.AttendeeID
WHERE c.CourseID IS NULL;
 
--3. Welcher der Kurse hat bisher weniger Teilnehmer zugeordnet, als die gefordertMindestzahl?
SELECT c.Name, COUNT(a.AttendeeID) AS Teilnehmer, c.MinAttendees
FROM tblCourseAttendence AS ca
RIGHT OUTER JOIN tblCourse AS c
ON ca.CourseID = c.CourseID
LEFT OUTER JOIN tblAttendee AS a
ON  ca.AttendeeID = a.AttendeeID
GROUP BY c.Name, c.MinAttendees
HAVING COUNT(a.AttendeeID) < c.MinAttendees;

--ODER LÖSUNG VOM LEHRER
WITH AttCount
AS
(
SELECT 
	CourseID,
	COUNT(*) AttCount
FROM tblCourseAttendence
GROUP BY CourseID
)
SELECT 
	C.Name 
FROM 
	AttCount AC
INNER JOIN
	tblCourse C
ON AC.CourseID = C.CourseID AND AC.AttCount < C.MinAttendees

SELECT *
FROM tblCourse

--4. Welche der Teilnehmer nehmen nicht am Kurs „SQL für Anfänger“ teil? 
SELECT DISTINCT (a.FirstName+' '+a.LastName) AS Teilnehmer
FROM 
(SELECT C.* 
FROM tblCourse C
WHERE C.Name = 'SQL für Anfänger') T
LEFT OUTER JOIN
	tblCourseAttendence CA
ON T.CourseID = CA.CourseID
RIGHT OUTER JOIN
	tblAttendee A
ON A.AttendeeID = CA.AttendeeID
WHERE t.CourseID IS NULL;