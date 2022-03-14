--Aufgabe 2 a
--Erstellen auf dem SQLSRV1 Umgebung folgende Umgebung:

--1.	Eine Datenbank mit dem Namen SecurityTest
CREATE DATABASE SecurityTest;
GO
--2.	Erstellen Sie für die Datenbank SecurityTest folgende Objekte
USE SecurityTest;
GO
--a.	Die Rollen db_dev, db_user_prod und db_user_store 
CREATE ROLE db_dev;
GO
CREATE ROLE db_user_prod;
GO
CREATE ROLE db_user_store;

--b.	Die Anwender steve, will, tom und jerry 
--(die dazu notwendigen Anmeldungen nicht vergessen!)
CREATE LOGIN steve
WITH PASSWORD = 'P@ssw0rd';
GO
CREATE LOGIN will
WITH PASSWORD = 'P@ssw0rd';
GO
CREATE LOGIN tom
WITH PASSWORD = 'P@ssw0rd';
GO
CREATE LOGIN jerry
WITH PASSWORD = 'P@ssw0rd';

CREATE USER steve
FOR LOGIN steve;
GO
CREATE USER will
FOR LOGIN will;
GO
CREATE USER tom
FOR LOGIN tom;
GO
CREATE USER jerry
FOR LOGIN jerry;
GO
--c.	Erstellen Sie zwei Schemata (oder Schemas, oder Schemen) mit den Namen Produkte und Lager
CREATE SCHEMA Produkte
AUTHORIZATION db_dev;
GO
CREATE SCHEMA Lager
AUTHORIZATION db_dev;
--3.	Besitzer beider Schemata soll die Rolle db_dev sein, die Rolle db_dev soll außerdem selbst Mitglied in den festen Datenbankrollen db_ddladmin, db_datareader und db_datawriter sein. Alle Mitglieder der Rolle db_dev sollen auch explizit folgende Rechte an der Datenbank SecurityTest haben:
ALTER ROLE db_ddladmin
ADD MEMBER db_dev;
GO
ALTER ROLE db_datareader
ADD MEMBER db_dev;
GO
ALTER ROLE db_datawriter
ADD MEMBER db_dev;
--a.	Definition anzeigen
GRANT VIEW DEFINITION 
TO db_dev;
--b.	Assembly erstellen
GRANT CREATE ASSEMBLY
TO db_dev;
--c.	Prozedur erstellen
GRANT CREATE PROC ON SecurityTest
TO db_dev;
--d.	Funktion erstellen
GRANT CREATE FUNCTION
TO db_dev;

--4.	Ordnen Sie Sie die Anwender steve und will der Rolle db_dev als Mitglieder zu.
ALTER ROLE db_dev
ADD MEMBER steve;
GO 
ALTER ROLE db_dev
ADD MEMBER will;

--5.	Ordnen Sie den Anwender tom der Rolle db_user_prod als Mitglied zu.
ALTER ROLE db_user_prod
ADD MEMBER tom;
GO 
--6.	Ordnen Sie den Anwender jerry der Rolle db_user_store als Mitglied zu.
ALTER ROLE db_user_store
ADD MEMBER jerry;
GO 
--7.	Für die Anwender steve und will soll das Schema dbo das Standard-Schema sein, für tom soll Produkte das Standard-Schema sein, für jerry soll Lager das Standard-Schema sein. 
ALTER USER steve
WITH DEFAULT_SCHEMA=[dbo];
GO
ALTER USER will
WITH DEFAULT_SCHEMA=[dbo];
GO
ALTER USER tom
WITH DEFAULT_SCHEMA=[Produkte];
GO
ALTER USER jerry
WITH DEFAULT_SCHEMA=[Lager];
GO
--8.	Die Mitglieder der Rolle db_user_prod sollen in dem Schema Produkte alle Daten ansehen und ändern dürfen (SELECT, INSERT, UPDATE, DELETE). 
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Produkte TO db_user_prod;

--9.	Die Mitglieder der Rolle db_user_store sollen in dem Schema Lager alle Daten ansehen und ändern dürfen (SELECT, INSERT, UPDATE, DELETE).
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Lager TO db_user_store;

--Aufgabe 2 b
--1.	Kopieren Sie die Datenbank auf einen anderen SQL-Server und testen Sie, ob Sie dort als Benutzer steve mit der Datenbank arbeiten können.
--2.	Löschen Sie die Datenbank wieder.
--3.	Erstellen Sie anschließend in der Originaldatenbank einen Benutzer joe fügen Sie diesem Benutzer der Rolle db_user_prod hinzu. Der Benutzer soll auch noch mit den Daten arbeiten können, wenn die Datenbank auf einen anderen Server kopiert wird. Testen Sie das Ergebnis.
