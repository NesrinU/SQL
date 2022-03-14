--Aufgabe 1 
--Die Aufgabe bezieht sich auf Tabellen in der Datenbank pro_angSQL. 
--1. Erzeugen Sie eine Sicht, die alle Daten der Angestellten außer der Spalte Gehalt anzeigt.
CREATE VIEW vwang_ohne_gehalt AS
SELECT a_nr, name, beruf, abt_nr, vorg FROM ang;

--2. Versuchen Sie, in diese Sicht Daten einzugeben.
SELECT * FROM vwang_ohne_gehalt;

INSERT INTO vwang_ohne_gehalt
VALUES
	(
	402, 'Ünal', 'Progr', 2, 205
	);

--3. Erzeugen Sie jeweils eine Sicht für die Daten der Angestellten jeder einzelnen Abteilung. 
--Sorgen Sie dafür, dass in jede dieser Sichten nur neue Angestellte mit der korrekten
--Abteilungsnummer eingegeben werden können. Testen Sie das Ergebnis. 
SELECT * FROM abt;

CREATE VIEW vwVerwaltung AS
SELECT * FROM ang WHERE abt_nr = 1 WITH CHECK OPTION;
GO
CREATE VIEW vwVertrieb AS
SELECT * FROM ang WHERE abt_nr = 2 WITH CHECK OPTION;
GO
CREATE VIEW vwEntwicklung AS
SELECT * FROM ang WHERE abt_nr = 3 WITH CHECK OPTION;

BEGIN TRAN
INSERT INTO vwVerwaltung
VALUES
	(
	405, 'Ünal', 'Progr', 1, 205, 5000
	);
SELECT * FROM vwVerwaltung;
ROLLBACK

--4. Lassen Sie sich die Definitionen der Sichten auf verschiedene Weisen anzeigen.
SELECT OBJECT_DEFINITION(OBJECT_ID('vwVerwaltung'))
SELECT OBJECT_DEFINITION(OBJECT_ID('vwVertrieb'))
SELECT OBJECT_DEFINITION(OBJECT_ID('vwEntwicklung'))

--5. Löschen Sie die zuerst erstellte Sicht wieder.
DROP VIEW vwVerwaltung;
GO
DROP VIEW vwVertrieb;
GO
DROP VIEW vwEntwicklung;

--6. Erstellen Sie eine Abfrage mit Bezug auf die Sichten, die alle Angestellten mit Nachnamen a-k 
--zeigt.
CREATE VIEW vwNachname_a_bis_k AS
SELECT * FROM ang WHERE name LIKE '[a-k]%';

--7. Erzeugen Sie eine Sicht, die alle Angestellten mit den Projektbeschreibungen anzeigt.
CREATE View  vwang_pro AS
	SELECT  a.a_nr, a.name, p.p_beschr
	FROM ang AS a
	INNER JOIN pro_ang AS pa
	ON a.a_nr = pa.a_nr
	INNER JOIN pro AS p
	ON pa.p_nr = p.p_nr;
SELECT * FROM vwang_pro;


--8. Erzeugen Sie eine Sicht, die alle Abteilungen mit dem Namen der Abteilungsleiter anzeigt. 
CREATE VIEW vwabt AS
	SELECT abt.abt_name, abt.abt_leiter, ang.name 
	FROM ang
	INNER JOIN abt
	ON ang.a_nr = abt.abt_leiter;
SELECT * FROM vwabt;

--Aufgabe 2 
--Die Aufgabe bezieht sich auf die Datenbank NordwindSQL. 
USE NordwindSQL;

--1. Erstellen Sie eine Sicht, die auf die Daten aller deutschen Kunden verweist. 
CREATE VIEW vwKunden_Deutsch AS
SELECT * FROM Kunden WHERE Land = 'Deutschland';

SELECT * FROM vwKunden_Deutsch;

--2. Testen Sie, ob Sie über diese Sicht einen schweizer Kunden einfügen können.
BEGIN TRAN
INSERT INTO vwKunden_Deutsch
VALUES
	(
	'ALF',	'Alfreds', 'Maria Anders',	NULL,	'Obere Str. 59',	'Dortmund',	NULL, 	44369,	'Schweiz',	050-0074321,	050-0076545
	);
ROLLBACK
--3. Ändern Sie die Sicht so, dass keine Kunden aus einem anderen Land gespeichert werden 
--können. Testen Sie das Ergebnis.
ALTER VIEW vwKunden_Deutsch AS
SELECT * FROM Kunden WHERE Land = 'Deutschland' WITH CHECK OPTION;

BEGIN TRAN
INSERT INTO vwKunden_Deutsch
VALUES
	(
	'ALF',	'Alfreds', 'Maria Anders',	NULL,	'Obere Str. 59',	'Dortmund',	NULL, 	44369,	'Schweiz',	050-0074321,	050-0076545
	);
ROLLBACK

--4. Lassen Sie sich die Definition dieser Sicht auf verschiedene Weisen anzeigen. 
SELECT OBJECT_DEFINITION(OBJECT_ID('vwKunden_Deutsch'))

--5. Erstellen Sie eine Sicht, die die Anzeige aller Auslaufartikel ermöglicht. Sorgen Sie dafür, dass 
--sich niemand die Definition dieser View ansehen kann. Testen Sie das Ergebnis.
CREATE VIEW vwAuslaufartikel WITH ENCRYPTION AS
SELECT * FROM Artikel WHERE Auslaufartikel = 1;

SELECT * FROM vwAuslaufartikel;

SELECT OBJECT_DEFINITION(OBJECT_ID('vwAuslaufartikel'))

--6. Kopieren Sie alle Artikel unter 12 € in eine neue Tabelle Billigartikel.
SELECT * INTO Billigartikel FROM Artikel WHERE Einzelpreis < 12;

SELECT * FROM Billigartikel;

--7. Erstellen Sie eine Sicht, die auf alle Artikel der Tabelle Billigartikel des Lieferanten mit der 
--Nummer 11 verweist. Sorgen Sie dafür, dass sich die Struktur der Tabelle Billigartikel nicht
--mehr ändern lässt.  
CREATE VIEW vwLief_11 WITH SCHEMABINDING AS
	SELECT [Artikel-Nr], Artikelname, [Lieferanten-Nr], [Kategorie-Nr], Liefereinheit, Einzelpreis, Lagerbestand, BestellteEinheiten, Mindestbestand, Auslaufartikel FROM dbo.Billigartikel WHERE [Lieferanten-Nr] = 11 WITH CHECK OPTION;

SELECT * FROM vwLief_11;
