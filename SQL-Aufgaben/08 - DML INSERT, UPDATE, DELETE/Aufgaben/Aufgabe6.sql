--Aufgabe 6
--Erstellen Sie eine Tabelle im SQL Server in einer neuen Datenbank „KanzlerDB“, die folgende Daten einiger Kanzler der BRD speichern kann:

CREATE DATABASE KanzlerDB;
USE KanzlerDB;

CREATE TABLE Kanzler
(
	Name		VARCHAR(50),
	Vorname		VARCHAR(50),
	VON			DATE,
	BIS			DATE,
	Partei		VARCHAR(50),
	Anzahl_Kabinette INT
);

--Name	Vorname	VON	BIS	Partei	Anzahl Kabinette
--Adenauer	Konrad	15.09.1949 	16.10.1963 	CDU	5
--Erhard	Ludwig	16.10.1963 	01.12.1966 	CDU	2
--Kiesinger	Kurt Georg	01.12.1966 	21.10.1969	CDU	1
--Brandt	Willy	21.10.1969	07.05.1974	SPD	2
--Scheel	Walter	07.05.1974	16.05.1974	FDP	0
--Schmidt	Helmut	16.05.1974	01.10.1983	SPD	3

--Fügen Sie die Daten nicht über die graphische Oberfläche, sondern mittels INSERT-Anweisungen in die Tabelle ein.

INSERT INTO Kanzler
VALUES
('Adenauer',	'Konrad',	'15.09.1949',	'16.10.1963', 	'CDU',	5),
('Erhard',	'Ludwig',		'16.10.1963',	'01.12.1966', 	'CDU',	2),
('Kiesinger','Kurt Georg',	'01.12.1966',	'21.10.1969',	'CDU',	1),
('Brandt',	'Willy'	,		'21.10.1969',	'07.05.1974',	'SPD',	2),
('Scheel',	'Walter',		'07.05.1974',	'16.05.1974',	'FDP',	0),
('Schmidt',	'Helmut',		'16.05.1974',	'01.10.1983',	'SPD',	3);

SELECT * FROM Kanzler;

--Ergänzen Sie die noch fehlenden Kanzler (google, wikipedia).
INSERT INTO Kanzler
VALUES
('Kohl',		'Helmut',	'01.10.1982', 	'27.10.1998',	'CDU',	5),
('Schröder',	'Gerhard',	'27.10.1998', 	'22.10.2005',	'SPD',	2),
('Merkel',		'Angela',	'22.10.2005',	'',				'CDU',	4);

SELECT * FROM Kanzler;

--Aktualisieren Sie den Datensatz von Helmut Schmidt. Dieser hat von 1974 – 1982 regiert, nicht bis 1983, wie in der Tabelle fälschlicherweise angegeben.
UPDATE Kanzler
SET BIS = '01.10.1982'
WHERE Name = 'Schmidt';

SELECT * FROM Kanzler;

--Löschen Sie Alle Datensätze aus der Tabelle, bei denen die Anzahl der Kabinette gleich 0 ist.
DELETE Kanzler
WHERE Anzahl_Kabinette = 0;

SELECT * FROM Kanzler;

--Kopieren Sie die Kanzler der CDU in eine eigene Tabelle „CDUKanzler“ und die Kanzler der SPD in eine eigene Tabelle „SPDKanzler“. Recherchieren Sie, wie man ganze Tabellen mit T-SQL kopiert (Stichwort SELECT INTO).
SELECT * INTO CDUKanzler
FROM Kanzler
WHERE Partei = 'CDU';

SELECT * FROM CDUKanzler;

SELECT * INTO SPDKanzler
FROM Kanzler
WHERE Partei = 'SPD';

SELECT * FROM SPDKanzler;

--Fügen Sie den CDU-Kanzlern und den SPD-Kanzlern noch eine weitere Spalte hinzu, in welchen Sie die Spitznamen der Kanzler eintragen. Die Spalte soll eine NOT NULL-Eigenschaft haben. Tragen Sie auch dort Werte ein.
ALTER TABLE CDUKanzler
ADD Spitzname	VARCHAR(50)	DEFAULT '---' NOT NULL;

SELECT * FROM CDUKanzler;

ALTER TABLE SPDKanzler
ADD Spitzname	VARCHAR(50)	DEFAULT '---' NOT NULL;

SELECT * FROM SPDKanzler;


UPDATE CDUKanzler
SET Spitzname = 'Der Alte'
WHERE Name = 'Adenauer'; 
--||
--USW...

--('Der Alte'),
--('Gummilöwe'),
--('Häuptling Silberzunge'),
--('Willy'),
--('Mister Bundesrepublik'),
--('Schmidt Schnauze'),
--('Bimbeskanzler'),
--('Gasprom Gerd'),
--('Mutti');
