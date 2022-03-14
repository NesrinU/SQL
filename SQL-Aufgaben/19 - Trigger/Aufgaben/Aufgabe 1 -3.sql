--Aufgabe 1
--Erstellen Sie in der TeachSQL-Datenbank eine Tabelle, welche Kundendaten enthalten soll (Spalten einigermaßen sinnvoll wählen). 
USE TeachSQL;
GO
CREATE TABLE Kundendaten
	(
	Kunden_ID		INT			PRIMARY KEY,
	Name			VARCHAR(50),
	Straße			VARCHAR(50),
	PLZ				INT,
	Ort				VARCHAR(50),
	);
--Erstellen Sie anschließend eine Tabelle, in welcher ein Log protokolliert werden soll. Die Spalten sind wie folgt:
--LogID, Kundennummer, AktuellerBenutzer, AktuelleUhrzeitUndDatum, Operation (Insert, Update, Delete).
CREATE TABLE Log_Datei
	(
	LogID						INT		IDENTITY, 
	Kundennummer				INT, 
	AktuellerBenutzer			VARCHAR(50), 
	AktuelleUhrzeitUndDatum		DATETIME2, 
	Operation					VARCHAR(50)
	);
 
--Diese Spalten sollen bei einer Operation auf die Kundentabelle gefüllt werden. Erstellen Sie hierzu einen passenden Trigger. 
CREATE OR ALTER TRIGGER tr_operation
ON Kundendaten
AFTER UPDATE, DELETE, INSERT
AS
	BEGIN
		IF EXISTS(SELECT * FROM deleted) AND EXISTS(SELECT * FROM inserted)
			BEGIN
				INSERT Log_Datei (Kundennummer, AktuellerBenutzer, AktuelleUhrzeitUndDatum, Operation)
				SELECT Kunden_ID, user_name(), GETDATE(), 'UPDATED' FROM deleted
			END
		ELSE IF EXISTS(SELECT * FROM deleted) 
			BEGIN
				INSERT Log_Datei (Kundennummer, AktuellerBenutzer, AktuelleUhrzeitUndDatum, Operation)
				SELECT Kunden_ID, user_name(), GETDATE(), 'DELETED' FROM deleted
			END
		ELSE 			
			BEGIN
				INSERT Log_Datei (Kundennummer, AktuellerBenutzer, AktuelleUhrzeitUndDatum, Operation)
				SELECT Kunden_ID, user_name(), GETDATE(), 'INSERTED' FROM inserted
			END
	END
RETURN;

INSERT Kundendaten
VALUES
(1, 'Emre Unal', 'Spelzenweg 4', 44369, 'Dortmund'),
(2, 'Gungor Unal', 'Kerzenweg 56', 44569, 'Bochum,'),
(3, 'Sumeyra Unal', 'Spelzenweg 4', 44369, 'Dortmund'),
(4, 'Aybuke Bilir', 'Kerzenweg 56', 44569, 'Bochum,')

UPDATE Kundendaten SET Name = 'Bilir' WHERE Kunden_ID = 1;
DELETE Kundendaten WHERE Kunden_ID=4;

SELECT * FROM Kundendaten;
SELECT * FROM Log_Datei;

--Aufgabe 2
--Erstellen Sie eine weitere Tabelle, welche Teilnehmerdaten der IT-Akademie beinhaltet. Die Adresse des Teilnehmers gehört dazu. Erstellen Sie eine weitere Tabelle für „historische Daten“, d.h. sobald ein Teilnehmer umzieht oder einen Namenswechsel hat, sollen die ursprünglichen Daten in einer Tabelle „Teilnehmerhistorie“ liegen. Diese Daten sollen außerdem einen Zeitstempel bekommen und eine Spalte, in welcher die Art der Änderung beschrieben wird (Heirat, Umzug).
--Erstellen Sie einen passenden Trigger.
CREATE TABLE IT_Akademie
	(
	ID		INT		PRIMARY KEY,
	Name			VARCHAR(50),
	Vorname			VARCHAR(50),
	Straße			VARCHAR(50),
	PLZ				INT,
	Ort				VARCHAR(50)	
	);
GO
CREATE TABLE Teilnehmerhistorie
	(
	Log_ID			INT		IDENTITY,
	ID				INT,
	Name			VARCHAR(50),
	Vorname			VARCHAR(50),
	Straße			VARCHAR(50),
	PLZ				INT,
	Ort				VARCHAR(50),
	Art_Änderung	VARCHAR(50)	
	);
GO

CREATE OR ALTER TRIGGER tr_art_änderung
ON IT_Akademie
AFTER UPDATE, DELETE, INSERT
AS
	BEGIN
		IF UPDATE(Name)
			BEGIN
				INSERT Teilnehmerhistorie(ID, Name, Vorname, Straße, PLZ, Ort, Art_Änderung)
				SELECT ID, Name, Vorname, Straße, PLZ, Ort, 'HEIRAT' FROM inserted
			END
		ELSE IF UPDATE(Straße)
			BEGIN
				INSERT Teilnehmerhistorie(ID, Name, Vorname, Straße, PLZ, Ort, Art_Änderung)
				SELECT ID, Name, Vorname, Straße, PLZ, Ort, 'UMZUG' FROM inserted
			END
		ELSE IF EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
			BEGIN
				INSERT Teilnehmerhistorie(ID, Name, Vorname, Straße, PLZ, Ort, Art_Änderung)
				SELECT ID, Name, Vorname, Straße, PLZ, Ort, 'INSERTED' FROM inserted
			END
		ELSE IF EXISTS(SELECT * FROM deleted) AND NOT EXISTS(SELECT * FROM inserted)
			BEGIN
				INSERT Teilnehmerhistorie(ID, Name, Vorname, Straße, PLZ, Ort, Art_Änderung)
				SELECT ID, Name, Vorname, Straße, PLZ, Ort, 'DELETED' FROM deleted
			END
	END
RETURN;

INSERT IT_Akademie VALUES (5, 'Bilir', 'Aybuke', 'Piremir 67', 16548, 'Bursa')
UPDATE IT_Akademie SET Name = 'UNAL' WHERE ID = 1;
UPDATE IT_Akademie SET Straße = 'Portsmoutherweg 1' WHERE ID = 3;

SELECT * FROM IT_Akademie;
SELECT * FROM Teilnehmerhistorie;

--Aufgabe 3
--Erstellen Sie eine Tabelle „CrazyTable“, welche eine ID-Spalte und eine NVARCHAR(MAX)-Spalte enthält. Fügen Sie in diese Tabelle einige Werte ein. Erstellen Sie einen INSTEAD-OF-Trigger, welcher 
---	beim Einfügen die ID’s aller Einträge um 1 nach vorne schiebt, damit der neue Eintrag die ID 1 bekommen kann
---	(krasse Aufgabe für Fortgeschrittene) beim Löschen eines Datensatzes die ID’s auch wieder so anpasst, dass keine Lücken in der ID-Reihenfolge entstehen können.
CREATE TABLE CrazyTable
	(
	ID		INT,
	Name	NVARCHAR(MAX)
	);
GO

CREATE OR ALTER TRIGGER tr_ID_Verschiebung
ON CrazyTable
INSTEAD OF INSERT, DELETE
AS
	BEGIN
		IF EXISTS(SELECT * FROM inserted)
			BEGIN
				UPDATE CrazyTable SET ID = ID+1
				INSERT CrazyTable (ID, Name)
				SELECT * FROM inserted
			END
		ELSE IF EXISTS(SELECT * FROM deleted)
			BEGIN
				DECLARE @ID INT = (SELECT ID FROM deleted)
				DELETE FROM CrazyTable WHERE @ID = ID
				SELECT * FROM deleted
				UPDATE CrazyTable SET ID = ID-1 WHERE @ID < ID
			END
	END
RETURN;

SELECT * FROM CrazyTable;

INSERT CrazyTable (ID, Name)
VALUES
(1, 'Emre')

DELETE FROM CrazyTable WHERE ID = 1;