--Aufgabe: Sichten Anwendung 

--Lösen Sie in der Datenbank PRO_ANGSQL folgende Aufgaben. 
USE pro_angSQL;
--Die Abfragen sollen sich wenn möglich auf eine Sicht beziehen. In der FROM-Klausel steht also der
--Name einer Sicht, kein Tabellenname.
 
--a) Erstellen Sie die Sicht vwAng1 ohne Optionen: Nummer, Name, Gehalt, Name und Gehalt
--des Vorgesetzten. Versehen Sie jede Spalte mit einem eindeutigen Alias. 
CREATE VIEW vwAng1 AS
SELECT a.a_nr AS ang_ID, a.name AS ang_Name, a.gehalt AS ang_Gehalt, b.name AS ang_Vorgesetz, b.gehalt AS ang_Gehalt_Vorg 
FROM ang AS a
LEFT OUTER JOIN ang AS b 
ON b.a_nr = a.vorg

SELECT * FROM vwAng1;

--b) Erstellen Sie die Sicht vwAng2 ohne Optionen auf Basis der Sicht vwAng1 mit den gleichen
--Spalten. Sie verweist nur auf Mitarbeiter, welche kein Projekt haben.

CREATE VIEW vwAng2 AS
SELECT * FROM vwAng1 
WHERE ang_ID = ANY
	(
	SELECT a_nr FROM ang
	EXCEPT
	SELECT a_nr FROM pro_ang
	) 
;

SELECT * FROM vwAng2;

--c) Fügen Sie der Sicht vwAng2 eine weitere Filterbedingung-Klausel hinzu, sodass nur
--Gehälter unter 6500 angezeigt werden.
ALTER VIEW vwAng2 AS
SELECT * FROM vwAng1 
WHERE ang_ID = ANY
	(
	SELECT a_nr FROM ang
	EXCEPT
	SELECT a_nr FROM pro_ang
	) AND ang_Gehalt < 6500
;
 
 SELECT * FROM vwAng2;

--d) Erstellen Sie auf Basis der beiden Sichten eine Abfrage, welche die Mitarbeiter zeigt,
--welche ein Projekt haben. Kopieren Sie das Abfrageergebnis in eine neue Tabelle vwTest. 
WITH ang_pro AS
	(
	SELECT * FROM vwAng1
	EXCEPT
	SELECT * FROM vwAng2
	)
SELECT * INTO vwTest 
FROM ang_pro;
	
SELECT * FROM vwTest;

--e) Wie viele aller Mitarbeiter verdienen mehr als ihr Vorgesetzter?  
SELECT COUNT (ang_ID)
FROM vwAng1
WHERE ang_Gehalt > ANY
	(
	SELECT ang_Gehalt
	FROM vwAng1
	WHERE ang_ID = ANY (SELECT ang_Vorgesetz FROM vwAng1)
	)
;
--f) Ändern Sie die Sicht vwAng1 so, dass auch die Abteilungsnummern angezeigt werden.
ALTER VIEW vwAng1 AS
SELECT a.a_nr AS ang_ID, a.name AS ang_Name, a.gehalt AS ang_Gehalt, a.abt_nr AS ang_Abteilung, b.name AS ang_Vorgesetz, c.gehalt AS ang_Gehalt_Vorg 
FROM ang AS a
INNER JOIN (SELECT a_nr, name FROM ang WHERE a_nr = ANY (SELECT vorg FROM ang))AS b 
ON b.a_nr = a.vorg
INNER JOIN (SELECT a_nr, gehalt FROM ang WHERE a_nr = ANY (SELECT vorg FROM ang)) AS c
ON c.a_nr = a.vorg 
 
SELECT * FROM vwAng1;

--g) Lassen Sie sich für beide Views die Definition anzeigen. 
SELECT OBJECT_DEFINITION(OBJECT_ID('vwAng1'))
SELECT OBJECT_DEFINITION(OBJECT_ID('vwAng2'))
--h) Löschen Sie die Sicht vwAng1 und erstellen Sie sie neu wie unter a). 
DROP VIEW vwAng1;

ALTER VIEW vwAng1 AS
SELECT a.a_nr AS ang_ID, a.name AS ang_Name, a.gehalt AS ang_Gehalt, b.name AS ang_Vorgesetz, b.gehalt AS ang_Gehalt_Vorg 
FROM ang AS a
LEFT OUTER JOIN ang AS b 
ON b.a_nr = a.vorg


SELECT * FROM vwAng1;
--i) Ermitteln Sie über vwAng1 die Summe aller Gehälter.
SELECT SUM(ang_Gehalt) AS SUM_Gehälter
FROM vwAng1;

--j) Erhöhen Sie über die Sicht vwAng2 alle Gehälter um 2000. Überzeugen Sie sich, wieviele
--Gehälter verändert wurden. Machen Sie die Änderung wieder rückgängig.
BEGIN TRAN
UPDATE vwAng2 SET ang_Gehalt = ang_Gehalt + 2000
ROLLBACK

SELECT * FROM vwAng2;
 
--k) Ändern Sie die Sicht vwAng2 so, dass nur Änderungen gemäß der WHERE-Klausel möglich
--sing.  
ALTER VIEW vwAng2 AS
SELECT * FROM vwAng1 
WHERE ang_ID = ANY
	(
	SELECT a_nr FROM ang
	EXCEPT
	SELECT a_nr FROM pro_ang
	) AND ang_Gehalt < 6500
WITH CHECK OPTION;

SELECT * FROM vwAng2;

--l) Erhöhen Sie wiederum über die Sicht vwAng2 die Angestelltengehälter um 2000. Wieviele
--Gehälter wurden jetzt verändert? Machen Sie die Änderung wieder rückgängig. 
BEGIN TRAN
GO
UPDATE vwAng2 SET ang_Gehalt = ang_Gehalt + 2000

ROLLBACK

--m) Starten Sie eine Transaktion. Entfernen Sie aus der Tabelle ang die Spalte name. Lassen
--Sie über die Sicht vwAng1 anzeigen. Fordern Sie ein Rollback an. 
BEGIN TRAN
ALTER TABLE ang
DROP COLUMN name
SELECT * FROM vwAng1
ROLLBACK

--n) Aktivieren Sie für die Sicht vwAng2 die Schemabindung. Beseitigen Sie dabei schrittweise
--die Fehlermeldungen und stellen Sie fest, welche Voraussetzungen notwendig sind. 
ALTER VIEW vwAng2 WITH SCHEMABINDING AS
SELECT ang_ID, ang_Name, ang_Gehalt, ang_Vorgesetz, ang_Gehalt_Vorg  FROM dbo.vwAng1 
WHERE ang_ID = ANY
	(
	SELECT a_nr FROM dbo.ang
	EXCEPT
	SELECT a_nr FROM dbo.pro_ang
	) AND ang_Gehalt < 6500
WITH CHECK OPTION;

--o) Entfernen Sie aus der Tabelle ang wiederum die Spalte name.
ALTER TABLE DROP COLUMN name;
