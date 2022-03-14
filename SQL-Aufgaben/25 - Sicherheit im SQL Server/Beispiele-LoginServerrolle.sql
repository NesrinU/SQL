--Windows-Benutzer
CREATE LOGIN [sqldomain\sqluser2]
FROM WINDOWS
WITH DEFAULT_DATABASE =  tempdb;

--Windows-Gruppe
CREATE LOGIN [sqldomain\sqluser]
FROM WINDOWS;

--SQL-Benutzer
CREATE LOGIN testman
WITH PASSWORD = 'P@ssw0rd',
	CHECK_POLICY = ON;

--Serverrolle
CREATE SERVER ROLE Hilfsadmin;

GRANT ALTER ANY DATABASE
TO Hilfsadmin;

ALTER SERVER ROLE Hilfsadmin
ADD MEMBER [sqldomain\sqluser1];


--Informationen
EXEC sp_helpsrvrole;
EXEC sp_helpsrvrolemember;




