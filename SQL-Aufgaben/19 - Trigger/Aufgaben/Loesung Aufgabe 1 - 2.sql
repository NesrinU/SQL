-- Aufgabe 1
USE TeachSQL;
GO

-- erstellen der Tabelle für Kundendaten
CREATE TABLE TabelleKunden
(
	ID INT PRIMARY KEY,
	Vorname NVARCHAR(30) NOT NULL,
	Nachname NVARCHAR(30) NOT NULL,
	Strasse NVARCHAR(30) NOT NULL,
	Hausnummer NVARCHAR(5) NOT NULL,
	PLZ		CHAR(5) NOT NULL,
	Ort NVARCHAR(30) NOT NULL
);

-- Logtabelle erstellen
CREATE TABLE LogTabelleKunden
(
	LogID INT IDENTITY PRIMARY KEY,
	Kundennummer INT NOT NULL,
	AktuellerBenutzer NVARCHAR(30) NOT NULL,
	AktuelleUhrzeitUndDatum DATETIME NOT NULL,
	Operation NVARCHAR(10) NOT NULL
);
GO

-- Trigger erstellen
CREATE TRIGGER tr_KundenLog
ON TabelleKunden
AFTER INSERT, UPDATE, DELETE
AS 
	BEGIN
		-- Welche Tabellen sind gefüllt?
		DECLARE @insert INT = (SELECT COUNT(*) FROM inserted);
		DECLARE @delete INT = (SELECT COUNT(*) FROM deleted);
		
		-- Entscheidungsfindung für die Operation
		IF	@insert > 0 AND @delete > 0
			BEGIN
				INSERT INTO LogTabelleKunden(Kundennummer, AktuellerBenutzer, AktuelleUhrzeitUndDatum, Operation)
				SELECT d.ID, SYSTEM_USER, GETDATE(), 'Update'
				FROM deleted d
			END
		ELSE
		IF	@insert > 0
			BEGIN
				INSERT INTO LogTabelleKunden(Kundennummer, AktuellerBenutzer, AktuelleUhrzeitUndDatum, Operation)
				SELECT i.ID, SYSTEM_USER, GETDATE(), 'Insert'
				FROM inserted i
			END
		ELSE
			BEGIN
				INSERT INTO LogTabelleKunden(Kundennummer, AktuellerBenutzer, AktuelleUhrzeitUndDatum, Operation)
				SELECT d.ID, SYSTEM_USER, GETDATE(), 'Delete'
				FROM deleted d
			END
	RETURN
	END;
GO

-- Testen
SELECT * FROM TabelleKunden;
SELECT * FROM LogTabelleKunden;


INSERT INTO TabelleKunden
VALUES (10, 'Mr', 'Voss', 'Keine Ahnung', '12', '12345', 'Bochum');

SELECT * FROM TabelleKunden;
SELECT * FROM LogTabelleKunden;


UPDATE TabelleKunden
SET Vorname = 'Igor'
WHERE ID = 10;

SELECT * FROM TabelleKunden;
SELECT * FROM LogTabelleKunden;


DELETE FROM TabelleKunden
WHERE ID = 10;

SELECT * FROM TabelleKunden;
SELECT * FROM LogTabelleKunden;

-- läuft :-)

-- Aufgabe 2

-- Tabelle erstellen
CREATE TABLE Teilnehmer
(
	ID INT PRIMARY KEY,
	Vorname NVARCHAR(30) NOT NULL,
	Nachname NVARCHAR(30) NOT NULL,
	Strasse NVARCHAR(30) NOT NULL,
	Hausnummer NVARCHAR(5) NOT NULL,
	PLZ CHAR(5) NOT NULL,
	Ort NVARCHAR(52) NOT NULL,
	Email NVARCHAR(40) NOT NULL,
	Telefonnummer NVARCHAR(30) NOT NULL
);


-- HistorieTabelle erstellen
CREATE TABLE TeilnehmerHistorie
(
	ID INT NOT NULL,
	Vorname NVARCHAR(30) NOT NULL,
	Nachname NVARCHAR(30) NOT NULL,
	Strasse NVARCHAR(30) NOT NULL,
	Hausnummer NVARCHAR(5) NOT NULL,
	PLZ CHAR(5) NOT NULL,
	Ort NVARCHAR(52) NOT NULL,
	Email NVARCHAR(40) NOT NULL,
	Telefonnummer NVARCHAR(30) NOT NULL,
	Zeitstempel DATETIME NOT NULL,
	Änderung NVARCHAR(7) NOT NULL
);
GO


-- Trigger
CREATE OR ALTER TRIGGER tr_Änderungen
ON Teilnehmer
AFTER UPDATE
AS
	BEGIN
		-- Welche Art der Änderung?
		DECLARE @art NVARCHAR(6);
		-- IF (SELECT Nachname FROM inserted) != (SELECT Nachname FROM deleted) 
		IF UPDATE(Nachname)
			SET @art = 'Heirat';
		ELSE
		IF	(SELECT Strasse FROM inserted) != (SELECT Strasse FROM deleted) OR
			(SELECT Hausnummer FROM inserted) != (SELECT Hausnummer FROM deleted) OR
			(SELECT Ort FROM inserted) != (SELECT Ort FROM deleted)
			SET @art = 'Umzug'
		ELSE
			SET @art = 'Andere';

		-- Historische Daten schreiben
		INSERT INTO TeilnehmerHistorie
		SELECT d.ID, d.Vorname, d.Nachname, d.Strasse, d.Hausnummer,
				d.PLZ, d.Ort, d.Email, d.Telefonnummer, GETDATE(), @art
		FROM deleted d
		RETURN
	END;
GO

-- Testen
INSERT INTO Teilnehmer 
VALUES 
(0, 'Ingo', 'Appelt', 'Lange Straße', '315', '12345', 'Berlin', 'ia@ia.de', '0123/45678'),
(1, 'Rüdiger', 'Hoffmann', 'Kurze Straße', '20', '24687', 'Olsberg', 'rh@blabla.de', '0123/234567'),
(2, 'Carolin', 'Kebekus', 'Rheinweg', '2', '22113', 'Kölle', 'ck@sonstwas.de', '0234/987654'),
(3, 'Marc', 'der Pansen', 'Breitweg', '500', '08150', 'Diggendorf', 'blla@bla.de', '02846/971871');

SELECT * FROM Teilnehmer;
SELECT * FROM TeilnehmerHistorie;

UPDATE Teilnehmer
SET Nachname = 'Kebekus'
WHERE ID = 2;

SELECT * FROM Teilnehmer;
SELECT * FROM TeilnehmerHistorie;

UPDATE Teilnehmer
SET Strasse = 'Langstraße'
WHERE ID = 0;

SELECT * FROM Teilnehmer;
SELECT * FROM TeilnehmerHistorie;

UPDATE Teilnehmer 
SET Email = 'bla@blubb.de'
WHERE ID = 3;

SELECT * FROM Teilnehmer;
SELECT * FROM TeilnehmerHistorie;
