--Aufgabe 5.1
--Sie sollen �ber die Oberfl�che des SSMS eine neue Datenbank mit dem Namen NewDB1 erstellen. Die Datenbank soll folgende Eigenschaften/Einstellungen aufweisen:

--1.	Die MDF-Datei soll auf dem Laufwerk E:\ im Verzeichnis TestDatabases liegen und NewDB1.mdf hei�en. Geben Sie der Datei eine Startgr��e von 15 MB und erm�glichen Sie ein Wachstum um 5 MB. Die Datei soll eine maximale Gr��e von 50 MB erreichen d�rfen!

--2.	Das Transaktionsprotokoll soll auf dem Laufwerk F:\ im Verzeichnis TestLogs liegen und NewDB_Log.ldf hei�en. 

--3.	Erstellen Sie in der Datenbank NewDB1  eine neue Tabelle und versuchen Sie so viele Daten einzuf�gen, dass der SQL Server gezwungen ist MDF-Datei mindestens ein Mal zu vergr��ern (Tipp: Batch mit einer Schleife verwenden!).
CREATE DATABASE [NewDB1]
ON  PRIMARY 
(NAME = N'NewDB1_MDF', 
FILENAME = N'E:\TestDatabases\NewDB1.mdf',
SIZE = 15 MB,
MAXSIZE = 50 MB,
FILEGROWTH = 5 MB
)
LOG ON 
(NAME = N'NewDB_Log', 
FILENAME = N'F:\TestLogs\NewDB_Log.ldf'
)
;

USE NewDB1;
GO
CREATE TABLE NeueTabelle
	(
	ID		INT			IDENTITY,
	Name	VARCHAR(50)
	);

DECLARE @name varchar = 1
WHILE @name < 1000
BEGIN
	INSERT NeueTabelle(Name)
	VALUES ('Hasan' + @name);
	SET @name +=1;
END;

SELECT * FROM NeueTabelle;
TRUNCATE TABLE NeueTabelle;

--Aufgabe 5.2
--Sie sollen �ber T-SQL Anweisungen eine neue Datenbank mit dem Namen NewDB2 erstellen. Die Datenbank soll folgende Eigenschaften/Einstellungen aufweisen:

--1.	Die MDF-Datei soll auf dem Laufwerk E:\ im Verzeichnis TestDatabases liegen und NewDB2_F1.mdf hei�en. Geben Sie der Datei  eine Startgr��e von 10 MB und erm�glichen Sie ein Wachstum um 25 Prozent. Die Datei soll eine maximale Gr��e von 150 MB erreichen d�rfen!

--2.	Das Transaktionsprotokoll soll auf dem Laufwerk F:\ im Verzeichnis TestLogs liegen NewDB2_Log.ldf hei�en. 

--3.	Eine NDF-Datei soll auf dem Laufwerk G:\ im Verzeichnis TestDatabases liegen und NewDB2_F2.ndf hei�en. Geben Sie der Datei eine Startgr��e von 15 MB und erm�glichen Sie ein Wachstum um 10 MB. Die Datei soll eine maximale Gr��e von 1 GB erreichen d�rfen!


