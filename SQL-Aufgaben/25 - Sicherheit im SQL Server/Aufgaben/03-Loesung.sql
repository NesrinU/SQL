USE ProjectDB;
GO
--Aufgabe 1.1
CREATE ROLE Personalverwaltung;

GRANT SELECT ON VW_Projekte_Mitarbeiter
TO Personalverwaltung;

GRANT SELECT ON tblProjekte_mitarbeiter
TO Personalverwaltung;

GRANT SELECT ON tblProjekte
TO Personalverwaltung;

GRANT SELECT ON tblMitarbeiter(Name,Vorname,GebDat,[Alter])
TO Personalverwaltung;

--Aufgabe 1.2
CREATE ROLE ProjektManager;

GRANT UPDATE ON tblProjekte_mitarbeiter
TO ProjektManager;

GRANT UPDATE ON tblProjekte(Ende) 
TO ProjektManager;

--Aufgabe 1.3
CREATE ROLE Abteilungsleiter;

--Lösung mit Standardrolle
ALTER ROLE db_datareader
ADD MEMBER Abteilungsleiter;

--Oder
GRANT SELECT ON SCHEMA::dbo
TO Abteilungsleiter;

GRANT INSERT, UPDATE, DELETE ON tblProjekte
TO Abteilungsleiter;

GRANT INSERT, UPDATE, DELETE ON tblMitarbeiter
TO Abteilungsleiter;

GRANT INSERT, UPDATE, DELETE ON tblProjekte_Mitarbeiter
TO Abteilungsleiter;

--Aufgabe 1.4
CREATE LOGIN Gerd
WITH PASSWORD = 'P@ssw0rd';

CREATE LOGIN Eva
WITH PASSWORD = 'P@ssw0rd';

CREATE LOGIN Lisa
WITH PASSWORD = 'P@ssw0rd';

CREATE LOGIN Anna
WITH PASSWORD = 'P@ssw0rd';

CREATE LOGIN Eduard
WITH PASSWORD = 'P@ssw0rd';

CREATE LOGIN Roland
WITH PASSWORD = 'P@ssw0rd';


CREATE USER gerd
FOR LOGIN gerd;

CREATE USER eva
FOR LOGIN eva;
CREATE USER anna
FOR LOGIN anna;
CREATE USER lisa
FOR LOGIN lisa;
CREATE USER eduard
FOR LOGIN eduard;
CREATE USER roland
FOR LOGIN roland;

EXEC sp_addrolemember 'Abteilungsleiter', 'gerd';

ALTER ROLE Projektmanager
ADD MEMBER eva;

ALTER ROLE Projektmanager
ADD MEMBER lisa;

ALTER ROLE Projektmanager
ADD MEMBER anna;

ALTER ROLE Personalverwaltung
ADD MEMBER Eduard;

ALTER ROLE Personalverwaltung
ADD MEMBER Roland;

--Test
EXECUTE AS USER = 'Roland';
SELECT * FROM tblProjekte;
SELECT * FROM tblMitarbeiter;--geht nicht
SELECT name,vorname, gebdat,[alter] FROM tblMitarbeiter;--geht
REVERT


EXECUTE AS USER = 'Eva'
UPDATE tblProjekte
	SET ENDE = '01.01.2014';

UPDATE tblProjekte
	SET ENDE = '01.01.2014'
	WHERE id = 1;
REVERT

EXECUTE AS USER = 'Gerd'
INSERT INTO tblProjekte
VALUES(5,'Frühstück fassen', '20.02.2014','20.02.2014', 5)
REVERT


--Aufgabe 2
CREATE LOGIN steven
WITH PASSWORD = 'P@ssw0rd';

CREATE USER steven
FOR LOGIN steven;

EXEC sp_addrolemember 'db_datareader', 'steven';
EXEC sp_addrolemember 'db_datawriter', 'steven';
EXEC sp_addrolemember 'db_ddladmin', 'steven';
GO

CREATE SCHEMA Personal AUTHORIZATION steven;
GO

ALTER USER steven
WITH DEFAULT_SCHEMA = Personal

--Falls vorher vergessen
ALTER AUTHORIZATION ON SCHEMA::Personal TO steven;

CREATE LOGIN tom
WITH PASSWORD='P@ssw0rd';

CREATE USER tom
FOR LOGIN tom;

EXEC sp_addrolemember 'db_datareader', 'tom';
EXEC sp_addrolemember 'db_datawriter', 'tom';
EXEC sp_addrolemember 'db_ddladmin', 'tom';
GO

EXECUTE AS USER = 'steven';
SELECT current_user;

SELECT * FROM tblProjekte;
SELECT * INTO Projekte
FROM tblProjekte;

SELECT * INTO Mitarbeiter
FROM tblMitarbeiter;

SELECT * INTO ProjekteMitarbeiter
FROM tblProjekte_Mitarbeiter;

REVERT

EXECUTE AS USER ='Eduard';
SELECT * FROM personal.projekte;
REVERT

DROP USER steven;
--geht nicht

ALTER AUTHORIZATION ON SCHEMA::Personal
TO tom;
DROP USER steven;

 