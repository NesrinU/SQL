-- 
CREATE DATABASE Sicherheit;
GO

USE Sicherheit;
GO


CREATE TABLE Testtabelle
(
	ID INT IDENTITY PRIMARY KEY,
	Benutzer sysname NOT NULL,
	Daten NVARCHAR(max)
);


CREATE USER U1 WITHOUT LOGIN;
CREATE USER U2 WITHOUT LOGIN;
CREATE USER Boss WITHOUT LOGIN;


INSERT INTO Testtabelle
VALUES
('U1', 'User1_Daten1'),
('U1', 'User1_Daten2'),
('U1', 'User1_Daten3'),
('U2', 'User2_Daten1'),
('U2', 'User2_Daten2'),
('U2', 'User2_Daten3'),
('Boss', 'Boss_Daten1'),
('Boss', 'Boss_Daten2'),
('Boss', 'Boss_Daten3'),
('Boss', 'Boss_Daten4');

SELECT * FROM Testtabelle;


-- Leseberechtigung geben
GRANT SELECT ON Testtabelle TO U1;
GRANT SELECT ON Testtabelle TO U2;
GRANT SELECT ON Testtabelle TO Boss;

SELECT CURRENT_USER;
GO

-- Schema erstellen, MS rät dazu
CREATE SCHEMA SicherheitsSchema;
GO


CREATE FUNCTION SicherheitsSchema.fn_zeilenfilter(@Username sysname)  
    RETURNS TABLE  
WITH SCHEMABINDING  
AS  
    RETURN	SELECT 
				1 AS fn_sicherheitsergebnis   
			WHERE @Username = USER_NAME()	
							OR USER_NAME() = 'Boss'
							OR USER_NAME() = 'dbo'
;

GO

-- Was macht die Funktion?
CREATE USER U3 WITHOUT LOGIN;
GRANT SELECT ON [SicherheitsSchema].[fn_zeilenfilter] TO [U3];
GRANT SELECT ON TestTabelle TO [U3];


EXECUTE AS User = 'U3';

SELECT * FROM SicherheitsSchema.fn_zeilenfilter('3');
REVERT;

SELECT USER_NAME();



CREATE SECURITY POLICY FilterPolicy  
	ADD FILTER PREDICATE 
		SicherheitsSchema.fn_zeilenfilter(Benutzer)
		ON dbo.Testtabelle
		WITH (STATE = ON);	


EXECUTE AS User = 'Boss';
SELECT * FROM Testtabelle;
SELECT CURRENT_USER;
REVERT;


EXEC AS USER = 'U1';
SELECT * FROM Testtabelle;
SELECT CURRENT_USER;
REVERT;


EXEC AS USER = 'U2';
SELECT * FROM Testtabelle;
SELECT CURRENT_USER;
REVERT;


EXEC AS USER = 'U3';
SELECT * FROM Testtabelle;
SELECT CURRENT_USER;
REVERT;


