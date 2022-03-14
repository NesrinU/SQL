-----------------------------------------------------------------------
-- Kurse - Studenten
-----------------------------------------------------------------------
USE [TeachSQL]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCourseAttendence]') AND type in (N'U'))
DROP TABLE [dbo].tblCourseAttendence
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCourse]') AND type in (N'U'))
DROP TABLE [dbo].tblCourse
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblAttendee]') AND type in (N'U'))
DROP TABLE [dbo].tblAttendee
GO

CREATE TABLE tblCourse 
(
	CourseID			INT IDENTITY		
						CONSTRAINT PK_COURSE PRIMARY KEY NONCLUSTERED,
	Name				VARCHAR(100)	NOT NULL,
	MinAttendees	    INT NOT NULL	DEFAULT (5),
	MaxAttendees	    INT NOT NULL	DEFAULT (20)
);
GO
CREATE TABLE tblAttendee 
(
	AttendeeID			INT IDENTITY		
						CONSTRAINT PK_ATTENDEE PRIMARY KEY NONCLUSTERED,
	LastName			VARCHAR(100)	NOT NULL,
	FirstName			VARCHAR(100)	NOT NULL
);
GO
CREATE TABLE tblCourseAttendence
(
	CourseID			INT,
	AttendeeID			INT,
	CONSTRAINT PK_COURSE_ATTENDENCE PRIMARY KEY(CourseID,AttendeeID),
	CONSTRAINT FK_COURSE FOREIGN KEY (CourseID) REFERENCES tblCourse (CourseID),
	CONSTRAINT FK_ATTENDEE FOREIGN KEY (AttendeeID) REFERENCES tblAttendee (AttendeeID)	
);
GO

INSERT INTO tblCourse (Name, MinAttendees, MaxAttendees)
VALUES
('C# für Anfänger',6, 15),
('C# für Profis',12, 20),
('SQL für Anfänger',8, 6),
('SQL für Profis',5, 15);
GO
INSERT INTO  tblAttendee (FirstName, LastName)
VALUES 
('Konrad','Adenauer'),
('Kurt-Georg','Kiesinger'),
('Ludwig','Erhard'),
('Willy','Brandt'),
('Helmut','Schmidt'),
('Helmut','Kohl'),
('Gerhard','Schröder'),
('Angela','Merkel'),
('Will','Shakespeare'),
('Friedrich','Schiller'),
('J.W.','Goethe'),
('Leo','Tolstoi'),
('Groucho','Marx'),
('Harpo','Marx'),
('Steve','Jobs'),
('Bill','Gates');
GO

DECLARE @ccnt int = 2, @acnt int = 1
DECLARE @att int = (SELECT MAX(AttendeeID) FROM tblAttendee)

WHILE @ccnt < (SELECT MAX(CourseID) FROM tblCourse)
BEGIN
	WHILE @acnt <= (SELECT MinAttendees+1 FROM tblCourse WHERE CourseID = @ccnt) AND @acnt < @att 
	BEGIN
		INSERT INTO tblCourseAttendence VALUES (@ccnt, @acnt)
		SET @acnt+=1
	END
	SET @acnt = 1
	SET @ccnt += 1
END
GO
INSERT INTO tblCourseAttendence VALUES (4, 1)
INSERT INTO tblCourseAttendence VALUES (4, 2)
GO
