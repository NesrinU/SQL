--Aufgabe 1
--1.	Legen Sie eine Tabelle mit Teilnehmerdaten an. Diese soll an eine automatisch erstellte Verlaufstabelle gebunden sein. Fügen Sie einige Daten ein. Ändern Sie in verschiedenen Zeitpunkten die Tabelleneinträge, fügen Sie einige hinzu und löschen Sie einige wieder. Testen Sie alle verschiedenen Abfragemodi.
CREATE TABLE Teilnehmerdaten
	(
	ID		INT		PRIMARY KEY,
	Name			VARCHAR(50),
	Vorname			VARCHAR(50),
	Straße			VARCHAR(50),
	PLZ				INT,
	Ort				VARCHAR(50),
	StartDatum		DATETIME2
		GENERATED ALWAYS AS ROW START DEFAULT SYSUTCDATETIME(),
	EndDatum		DATETIME2
		GENERATED ALWAYS AS ROW END DEFAULT CONVERT(DATETIME2, '2021-07-23 16:00:00'),
	PERIOD FOR SYSTEM_TIME(StartDatum, EndDatum)
	)
WITH (SYSTEM_VERSIONING = ON);
GO
INSERT INTO Teilnehmerdaten (ID, Name, Vorname, Straße, PLZ, Ort)
VALUES
(1,	'Unal',		'Sumeyra',	'Spelzenweg 4',			44369,	'Dortmund'),
(2,	'Ozkan',	'Murat',	'Am Fichtenbrink 5',	33659,	'Bielefeld'),
(3,	'Unal',		'Gungor',	'Portsmoutherweg 1',	27896,	'Zittau'),
(4,	'Bilir',	'Aybuke',	'Piremir 67',			16548,	'Bursa')
;

SELECT * FROM [dbo].[MSSQL_TemporalHistoryFor_546100986];

SELECT * FROM Teilnehmerdaten;

--ALTER TABLE Teilnehmerdaten SET (SYSTEM_VERSIONING = OFF)

DELETE FROM Teilnehmerdaten WHERE ID = 4;
INSERT INTO Teilnehmerdaten (ID, Name, Vorname, Straße, PLZ, Ort)
VALUES 
(4, 'Bilir', 'Aybuke', 'Piremir 67', 16548, 'Bursa')
;
--2.	Erstellen Sie eine weitere Tabelle mit dem gleichen Schema der ersten Tabelle. Diese soll an eine benutzerdefinierte Verlaufstabelle gebunden sein. Auch hier fügen Sie Daten ein, ändern diese und löschen einige, so dass die Verlaufstabelle gefüllt wird.
CREATE TABLE Teilnehmer_History2
	(
	ID				INT		NOT NULL,
	Name			VARCHAR(50),
	Vorname			VARCHAR(50),
	Straße			VARCHAR(50),
	PLZ				INT,
	Ort				VARCHAR(50),
	StartDatum		DATETIME2	NOT NULL,
	EndDatum		DATETIME2	NOT NULL
	);
GO
CREATE TABLE Teilnehmerdaten2
	(
	ID		INT		PRIMARY KEY,
	Name			VARCHAR(50),
	Vorname			VARCHAR(50),
	Straße			VARCHAR(50),
	PLZ				INT,
	Ort				VARCHAR(50),
	StartDatum		DATETIME2
		GENERATED ALWAYS AS ROW START DEFAULT SYSUTCDATETIME(),
	EndDatum		DATETIME2
		GENERATED ALWAYS AS ROW END DEFAULT CONVERT(DATETIME2, '2021-07-23 16:00:00'),
	PERIOD FOR SYSTEM_TIME(StartDatum, EndDatum)
	)
WITH (SYSTEM_VERSIONING = ON(HISTORY_TABLE = dbo.Teilnehmer_History2));
GO
INSERT INTO Teilnehmerdaten2(ID, Name, Vorname, Straße, PLZ, Ort)
VALUES
(1,	'Unal',		'Sumeyra',	'Spelzenweg 4',			44369,	'Dortmund'),
(2,	'Ozkan',	'Murat',	'Am Fichtenbrink 5',	33659,	'Bielefeld'),
(3,	'Unal',		'Gungor',	'Portsmoutherweg 1',	27896,	'Zittau'),
(4,	'Bilir',	'Aybuke',	'Piremir 67',			16548,	'Bursa')
;

SELECT * FROM Teilnehmer_History2;

SELECT * FROM Teilnehmerdaten2;

--ALTER TABLE Teilnehmerdaten SET (SYSTEM_VERSIONING = OFF)

DELETE FROM Teilnehmerdaten2 WHERE ID = 4;
INSERT INTO Teilnehmerdaten2 (ID, Name, Vorname, Straße, PLZ, Ort)
VALUES 
(4, 'Bilir', 'Aybuke', 'Piremir 67', 16548, 'Bursa');
UPDATE Teilnehmerdaten2 SET Name = 'Bilir' WHERE ID = 1;

--3.	(Zusatz, falls Sie zu schnell fertig sein sollten  ) Machen Sie sich mit dem MERGE-Befehl vertraut. Versuchen Sie, die Daten aus der Tabelle aus Aufgabe 1 in die Tabelle aus Aufgabe 2 zu überführen, derart, dass doppelte Teilnehmer nicht vorkommen dürfen.
