USE NordwindSQL;
GO

CREATE USER SecAdmin2
FOR LOGIN SecADmin2
WITH DEFAULT_SCHEMA = dbo;

--Auch dbo als Standardschema
CREATE USER SecAdmin3
FOR LOGIN SecAdmin3;

GRANT INSERT ON Bestelldetails 
TO SecAdmin1 
WITH GRANT OPTION;

--Sicherheitskontext wechseln
EXECUTE AS USER = 'SecAdmin1';
SELECT USER_NAME();

INSERT INTO Bestelldetails
VALUES(10249,66,2.5,10,0,NULL);

SELECT * FROM Bestelldetails;

GRANT INSERT ON Bestelldetails 
TO SecAdmin2
WITH GRANT OPTION;

--Zurück zum "Admin"
REVERT
SELECT user_name();

EXECUTE AS USER = 'SecADmin2';

INSERT INTO Bestelldetails
VALUES(10249,67,2.5,10,0,NULL);

REVERT

SELECT user_name();

REVOKE INSERT ON Bestelldetails
FROM SecAdmin1
CASCADE;

EXECUTE AS USER = 'SEcAdmin2';
SELECT user_name();

INSERT INTO Bestelldetails
VALUES(10249,61,2.5,10,0,NULL);
REVERT


--Bessere Idee
SELECT user_name();

--Benutzer in Standardrolle packen
--alte Methode
EXEC sp_addrolemember 'db_Datareader', 'SecAdmin1';
EXEC sp_addrolemember 'db_Datawriter', 'SecAdmin2';
EXEC sp_addrolemember 'db_Ddladmin', 'SecAdmin3';

--Test
EXECUTE AS USER = 'Secadmin1';
SELECT user_name()

SELECT * FROM Bestelldetails;
INSERT INTO Bestelldetails
VALUES(10249,60,2.5,10,0,NULL);

REVERT 

EXECUTE AS USER = 'Secadmin2';
SELECT user_name()

SELECT * FROM Bestelldetails;
INSERT INTO Bestelldetails
VALUES(10249,60,2.5,10,0,NULL);

REVERT 

EXECUTE AS USER = 'Secadmin3';
SELECT user_name()

SELECT * FROM Bestelldetails;
INSERT INTO Bestelldetails
VALUES(10249,60,2.5,10,0,NULL);

CREATE TABLE blubb(id int);
SELECT * FROM blubb;
REVERT

--Deny
DENY SELECT ON Artikel
TO SecAdmin1;

EXECUTE AS USER = 'Secadmin1';
SELECT user_name()

SELECT * FROM Bestelldetails;

SELECT * FROM Artikel;
REVERT

REVOKE SELECT ON Artikel
FROM SecADmin1;

--Neuer Test
EXECUTE AS USER = 'Secadmin1';
SELECT user_name()

SELECT * FROM Bestelldetails;

SELECT * FROM Artikel;
REVERT

--Schema anlegen
CREATE SCHEMA Einkauf
AUTHORIZATION SecADmin3
GO

--Contained User
EXEC sp_configure 'contained database authentication' , 1;
RECONFIGURE WITH OVERRIDE

EXEC sp_configure

USE [master]
GO
ALTER DATABASE [NordwindSQL] SET CONTAINMENT = PARTIAL WITH NO_WAIT

USE Nordwindsql;
GO

CREATE USER CUser1 WITH PASSWORD = 'P@ssw0rd';

EXEC sp_addrolemember 'db_ddladmin', 'CUser1';

EXECUTE AS USER = 'CUser1';

CREATE TABLE piesepampel(id int);

SELECT user_name();

REVERT
use master
