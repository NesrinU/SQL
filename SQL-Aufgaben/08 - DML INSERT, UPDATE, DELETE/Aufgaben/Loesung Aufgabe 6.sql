-- Erstellen einer neuen Datenbank
CREATE DATABASE KanzlerDB;
GO

-- Benutzen der Datenbank
USE KanzlerDB;
GO

-- Erstellen der Tabelle
CREATE TABLE Kanzler
(
	Name				NVARCHAR(20)	NOT NULL,
	Vorname				NVARCHAR(20)	NOT NULL,
	VON					DATE			NOT NULL,
	BIS					DATE			,
	Partei				NVARCHAR(20)	,
	[Anzahl Kabinette]	INT				NOT NULL
);


-- Einfügen der Daten
INSERT Kanzler VALUES
('Adenauer', 'Konrad', '15.09.1949', '16.10.1963', 'CDU', 5),
('Erhard', 'Ludwig', '16.10.1963', '01.12.1966', 'CDU', 2),
('Kiesinger', 'Kurt Georg', '01.12.1966', '21.10.1969', 'CDU', 1),
('Brandt', 'Willy', '21.10.1969', '07.05.1974', 'SPD', 2),
('Scheel', 'Walter', '07.05.1974', '16.05.1974', 'FDP', 0),
('Schmidt', 'Helmut', '16.05.1974', '01.10.1983', 'SPD', 3),
('Kohl', 'Helmut', '01.10.1983', '27.10.1998', 'CDU', 5),
('Schröder', 'Gerhard', '27.10.1998', '22.11.2005', 'SPD', 2),
('Merkel', 'Angela', '22.11.2005', NULL, 'CDU', 4);

SELECT * FROM Kanzler;

-- Datensätze aktualisieren
UPDATE Kanzler
SET BIS = '01.10.1982'
WHERE BIS = '01.10.1983';

-- Vorsicht, auch das Anfangsdatum vom dicken Kohl
-- muss ja ebenfalls angepasst werden!
UPDATE Kanzler
SET VON = '01.10.1982'
WHERE VON = '01.10.1983';

-- Test
SELECT * FROM Kanzler;


-- Löschen, wo #Kabinette = 0
DELETE FROM Kanzler
WHERE [Anzahl Kabinette] = 0;


-- Kopieren in zwei neue Tabellen

-- 1. CDU
SELECT * INTO CDUKanzler
FROM Kanzler
WHERE Partei = 'CDU';

-- 2. SPD
SELECT * INTO SPDKanzler
FROM Kanzler
WHERE Partei = 'SPD';

-- Testen
SELECT * FROM CDUKanzler;
SELECT * FROM SPDKanzler;


-- Spitznamen der Kanzler einfügen
-- neue Spalten in den Tabellen CDUKanzler und SPDKanzler
ALTER TABLE CDUKanzler
ADD Spitzname NVARCHAR(30)
NOT NULL DEFAULT '---';

ALTER TABLE SPDKanzler
ADD Spitzname NVARCHAR(30)
NOT NULL DEFAULT '---';
GO

-- CDU
SELECT * FROM CDUKanzler;

UPDATE CDUKanzler
SET Spitzname = 'Der Alte'
WHERE Name = 'Adenauer'; 

UPDATE CDUKanzler
SET Spitzname = 'Der Dicke'
WHERE Name = 'Erhard'; 

UPDATE CDUKanzler
SET Spitzname = 'Häuptling Silberzunge'
WHERE Name = 'Kiesinger'; 

UPDATE CDUKanzler
SET Spitzname = 'Der schwarze Riese'
WHERE Name = 'Kohl'; 

UPDATE CDUKanzler
SET Spitzname = 'Mutti'
WHERE Name = 'Merkel'; 


-- SPD
SELECT * FROM SPDKanzler;

UPDATE SPDKanzler
SET Spitzname = 'Willy Wolke'
WHERE Name = 'Brandt'; 

UPDATE SPDKanzler
SET Spitzname = 'Schmidt Schnauze'
WHERE Name = 'Schmidt'; 

UPDATE SPDKanzler
SET Spitzname = 'Brioni-Kanzler'
WHERE Name = 'Schröder'; 

SELECT * FROM SPDKanzler;
