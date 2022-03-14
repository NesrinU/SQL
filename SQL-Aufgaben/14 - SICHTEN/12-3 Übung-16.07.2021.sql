--Temporäre Tabellen 
--1. Erstellen Sie die globale temporäre Tabelle:
CREATE TABLE ##pro 
	(
	Projekt				INT			PRIMARY KEY,
	Thema				VARCHAR(50)	NOT NULL,
	Mitarbeiterzahl		INT,
	Start				DATE
	);
GO
INSERT INTO ##pro 
	VALUES 
		(004,		'FiBu',		7,		'1.9.2021'),
		(009,		'KLR',		4,		'5.11.2021'),
		(018,		'KLR',		2,		'1.12.2021'),
		(012,		'Logistik',	12,		'1.12.2021'),
		(006,		'KLR',		9,		'1.10.2021'),
		(015,		'FiBu',		2,		'1.3.2022')
		;
SELECT * FROM ##pro;
 
--2. Und folgende lokale temporäre Tabelle:
CREATE TABLE #pro 
	(
	ProjektNr		INT			PRIMARY KEY,
	Inhalt			VARCHAR(50)	NOT NULL,
	Teamgröße		INT,
	Beginn			DATE
	);
GO
INSERT INTO #pro 
	VALUES 
(002,	'KLR',		5,	'5.10.2021'),
(006,	'KLR',		9,	'1.10.2021'),
(013,	'KLR',		10,	'4.2.2022'),
(018,	'KLR',		2,	'1.12.2021'),
(012,	'Logistik',	12,	'1.12.2021'),
(003,	'KLR',		5,	'1.10.2021'),
(011,	'KLR',		13,	'1.11.2021'),
(007,	'FiBu',		6,	'1.12.2021'); 

SELECT * FROM #pro;
 
--3. Rufen Sie die Daten beider Tabellen zunächst im aktuellen Abfragefenster, danach in
--einem anderen Abfragefenster ab. 
SELECT * FROM ##pro;
SELECT * FROM #pro;

--4. Fügen Sie in die lokale Tabelle neue Datensätze ein: 
INSERT INTO #pro 
	VALUES 
(014, 'FiBu', 9,	'10.10.2021'),
(020, 'FiBu', 3,	'8.11.2021'),
(024, 'FiBu', 11,	'1.12.2021');

--5. Lassen Sie die in beiden Tabellen identischen Datensätze anzeigen.
 SELECT * FROM ##pro;
SELECT * FROM #pro;
--6. Kopieren Sie mit 1 Anweisung alle Datensätze ohne Duplikate in eine neue globale 
--Tabelle.
WITH a AS 
(
SELECT * 
FROM ##pro
UNION
SELECT *
 FROM #pro
 )
 SELECT * INTO ##pro2
FROM a;
--7. Löschen Sie die erste globale Tabelle und entfernen Sie aus der lokalen sämtliche 
--Datensätze. 
DROP TABLE ##pro;

--Von nun an arbeiten Sie nur noch mit der zuletzt erstellten Tabelle. 
--8. Für alle Nicht-KLR Projekte wird ein weiterer Mitarbeiter zur Verfügung gestellt.
SELECT * 
FROM ##pro2
WHERE Thema NOT IN ('KLR');

--9. Die Tabelle bekommt eine neue Spalte Dauer in Tagen. 
ALTER TABLE ##pro2
ADD Dauer	INT;

--10. KLR-Projekte dauern 40 Tage, FiBu 75 Tage, Logistik 65 Tage.
UPDATE ##pro2 SET Dauer = 40 WHERE Thema = 'KLR'; 
UPDATE ##pro2 SET Dauer = 75 WHERE Thema = 'FiBu';
UPDATE ##pro2 SET Dauer = 65 WHERE Thema = 'Logistik';

SELECT * FROM ##pro2;
--11. Die Starttermine werden ggf. auf den Monatsersten vorverlegt.
UPDATE ##pro2 SET Start = DATEADD(DAY,(DATEPART(DAY,Start)-1)*(-1),Start);

--12. Für die neue Spalte Budget gesamt gilt:  
--KLR-Projekte 7000,- € zzgl. 900,- pro Tag
--FiBu-Projekte 1000,- € zzgl. 500,- € pro Tag
--Logistik-Projekte: 900,- € pro Tag 
--13. Folgende Abfragen werden benötigt:
--a) Welche Projekte haben mehr als 11 Mitarbeiter?
--b) Welches Projekt beginnt als Letztes?
--c) An wie vielen Projekten arbeiten mehr als 8 MA?
--d) Welche FiBu-Projekte haben weniger als 7 MA?
--e) Wie viele Projekte beginnen in welchem Monat?
--f) Wie heißt die ø Mitarbeiterzahl?
--g) Wie verteilen sich die Budgets prozentual auf KLR, FiBu und Logistik? 
--h) In welchem Monat starten die meisten Projekte? 