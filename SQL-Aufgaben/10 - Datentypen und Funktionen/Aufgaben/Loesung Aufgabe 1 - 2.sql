--Die folgenden Aufgaben beziehen sich auf die Tabelle dbo.tblPersonal in der WAWI-Datenbank
USE WAWI_BASIS;
GO

--Aufgabe 1
--Verwenden Sie jeweils Datums-Funktionen, um die folgenden Aufgaben durchzuführen. Lassen Sie jeweils Vor- und Nachname und die in den Bedingungen geforderten Spalten anzeigen:

--1.	Zeigen Sie von allen Angestellten jeweils nur den Tag, den Monat bzw. das Jahr  des Eintrittsdatums an.
SELECT PersVorname, 
	YEAR(PersEintritt) Jahr, 
	MONTH(PersEintritt) Monat,
	DAY(PersEintritt) Tag
FROM tblPersonal;

--2.	Zeigen Sie von allen Angestellten das Eintrittsjahr an.
SELECT PersVorname, 
	YEAR(PersEintritt) Jahr
FROM tblPersonal;

--3.	Ermitteln Sie alle Angestellten, die in einem Januar ihre Stelle angetreten haben.
SELECT a.PersVorname, a.PersNachname,
	MONTH(a.PersEintritt) Eintrittsmonat
FROM tblPersonal a
WHERE MONTH(a.PersEintritt) = 1;


--4.	Ermitteln Sie alle Angestellten, die in einem März angefangen haben und die Angestellten, die in einem Juli angefangen haben.
SELECT PersVorname, PersNachname,
		PersEintritt
FROM tblPersonal
WHERE MONTH(PersEintritt) = 3
		OR MONTH(PersEintritt) = 7;

SELECT PersVorname, PersNachname,
		PersEintritt
FROM tblPersonal
WHERE MONTH(PersEintritt) IN (3, 7);


--5.	Ermitteln Sie alle Angestellten, die in einem 2. Quartal angefangen haben.
SELECT PersVorname, PersNachname,
	MONTH(PersEintritt) Monat,
	YEAR(PersEintritt) Jahr
FROM tblPersonal
WHERE MONTH(PersEintritt) >= 4 AND 
	MONTH(PersEintritt) <= 6;

SELECT PersVorname, PersNachname,
	MONTH(PersEintritt) Monat,
	YEAR(PersEintritt) Jahr
FROM tblPersonal
WHERE MONTH(PersEintritt) BETWEEN 4 AND 6;

SELECT PersVorname, PersNachname,
	MONTH(PersEintritt) Monat,
	YEAR(PersEintritt) Jahr
FROM tblPersonal
WHERE MONTH(PersEintritt) IN (4, 5, 6);

SELECT PersVorname, PersNachname,
	MONTH(PersEintritt) Monat,
	YEAR(PersEintritt) Jahr
FROM tblPersonal
WHERE DATEPART(QUARTER,  PersEintritt) = 2;


--6.	Ermitteln Sie alle Angestellten, die in der 40. KW angefangen haben.
SELECT PersVorname, PersNachname,
	MONTH(PersEintritt) Monat,
	YEAR(PersEintritt) Jahr
FROM tblPersonal
WHERE DATEPART(WEEK,  PersEintritt) = 40;

SELECT PersVorname, PersNachname,
	MONTH(PersEintritt) Monat,
	YEAR(PersEintritt) Jahr
FROM tblPersonal
WHERE DATEPART(ISO_WEEK,  PersEintritt) = 40;


--7.	Ermitteln Sie das ungefähre Alter aller Angestellten, an deren Eintrittsdatum.
SELECT PersVorname, PersNachname, PersGebDatum, PersEintritt,
		DATEDIFF(YEAR, PersGebDatum, PersEintritt) [Alter]
FROM tblPersonal;


--8.	Ermitteln Sie alle Angestellten, die bei in ihrem Eintrittsjahr jünger als 40 waren.
SELECT PersVorname, PersNachname, PersGebDatum, PersEintritt,
		DATEDIFF(YEAR, PersGebDatum, PersEintritt) [Alter]
FROM tblPersonal
WHERE DATEDIFF(YEAR, PersGebDatum, PersEintritt) < 40;


--9.	Ermitteln Sie die Angestellten, die seit mehr als 8 Jahren beschäftigt sind. (Es darf kein statisches Datum als Kriterium verwendet werden.)
SELECT PersVorname, PersNachname, PersEintritt
FROM tblPersonal
WHERE DATEDIFF(YEAR, PersEintritt, COALESCE(PersAustritt, GETDATE())) > 8;


--10.	Zeigen Sie von allen Angestellten das Eintrittsdatum im deutschen, amerikanischen und ANSI-Format an. (Tip: https://msdn.microsoft.com/de-de/library/ms187928.aspx)
SELECT PersVorname, PersNachname,
		CONVERT(CHAR(10), PersEintritt, 104) AS EintrittDE,
		CONVERT(CHAR(10), PersEintritt, 101) AS EintrittUS,
		CONVERT(CHAR(10), PersEintritt, 102) AS EintrittANSI
FROM tblPersonal;

--11.	Lassen Sie jeweils den Wochentag und den Monat des Eintrittsdatums als ganze Zahl anzeigen.
SELECT PersVorname, PersNachname, 
	DATEPART(MONTH, PersEintritt) Monat,
	DATEPART(DAY, PersEintritt) Tag
FROM tblPersonal;



--12.	Lassen Sie jeweils den Wochentag und den Monat des Eintrittsdatums als Name anzeigen.
SELECT PersVorname, PersNachname, 
	DATENAME(MONTH, PersEintritt) Monat,
	DATENAME(WEEKDAY, PersEintritt) Tag
FROM tblPersonal;



--Aufgabe 2
--Verwenden Sie jeweils String-Funktionen, um die folgenden Aufgaben durchzuführen. Ermitteln Sie, falls nötig, vorher die passende Funktion selbständig.
--Lassen Sie jeweils Vor- und Nachname und die, in den Bedingungen geforderten Spalten anzeigen:
--1.	Zeigen Sie von allen Angestellten Land, PLZ und Ort kombiniert in einer Spalte an. 
SELECT PersVorname, PersNachname,
	PersLand + PersPlz +' ' + PersOrt AS Adresse 
FROM tblPersonal;


SELECT PersVorname, PersNachname,
	RTRIM(PersLand) + ' ' + PersPlz + ' ' + PersOrt AS Anschrift
FROM tblPersonal;

SELECT 'Hal' + '          lo W          ' + 'elt!';
SELECT 'Hal' + RTRIM('          lo W          ') + 'elt!';
SELECT 'Hal' + LTRIM('          lo W          ') + 'elt!';
SELECT 'Hal' + RTRIM(LTRIM('          lo W          ')) + 'elt!';





--2.	Zeigen Sie von allen Angestellten Vor- und Nachname in einer Spalte an. Verwenden Sie das folgende Format: name, vorname.
SELECT PersNachname, PersVorname,
	LOWER(PersNachname) + ', ' + LOWER(PersVorname) AS Name
FROM tblPersonal;

SELECT PersNachname, PersVorname,
	PersNachname + ', ' + PersVorname AS Name
FROM tblPersonal;

--3.	Zeigen Sie von allen Angestellten die ersten drei Buchstaben des Ortes an.
SELECT LEFT(PersOrt, 3), PersOrt
FROM tblPersonal;

--4.	Zeigen Sie von allen Angestellten die letzten 4 Buchstaben des Ortes an.
SELECT RIGHT(PersOrt, 4), PersOrt
FROM tblPersonal;

SELECT PersOrt,
	REVERSE(SUBSTRING(REVERSE(PersOrt), 1, 4))
FROM tblPersonal;


--5.	Zeigen Sie von allen Angestellten den Ort in Großbuchstaben an.
SELECT PersNachname, PersVorname, PersOrt,
		UPPER(PersOrt) AS Örtli
FROM tblPersonal;

--6.	Zeigen Sie von allen Angestellten den Ort in Kleinbuchstaben an.
SELECT PersNachname, PersVorname, PersOrt,
		LOWER(PersOrt) AS Örtli
FROM tblPersonal;

--7.	Ermitteln Sie von allen Angestellten die Länge des Vornamens.
SELECT LEN(PersVorname) AS Namenslänge, PersVorname
FROM tblPersonal;


--8.	Zeigen Sie von allen Angestellten die Initialen an.
SELECT PersVorname, PersNachname,
		LEFT (PersVorname, 1) + LEFT (PersNachname, 1) AS Initialen
FROM tblPersonal;

--9.	Fügen Sie bei allen Angestellten in der Spalte Straße zwei Leerzeichen zwischen Straße und Hausnummer ein.
SELECT PersVorname, PersNachname,
	REPLACE(PersStrasse, ' ', '  ') AS Strasse
FROM tblPersonal;

SELECT SUBSTRING(PersStrasse, 1,  LEN(PersStrasse) - CHARINDEX(' ', REVERSE(PersStrasse))) 
	+ '  ' + 
	REVERSE(SUBSTRING(REVERSE(PersStrasse), 1, CHARINDEX(' ', REVERSE(PersStrasse))))
FROM tblPersonal;

SELECT PersStrasse,
		SUBSTRING(PersStrasse, 1, PATINDEX('% [0-9]%', PersStrasse)) + '          ' + SUBSTRING(PersStrasse, PATINDEX('% [0-9]%', PersStrasse), LEN(PersStrasse))
FROM tblPersonal;

SELECT
	PersNachname, PersVorname,
	REPLACE(PersStrasse, ' ', '  ') AS "Variante A",
	RTRIM(LEFT(PersStrasse, LEN(PersStrasse) 
	- LEN(PATINDEX('% %', REVERSE(PersStrasse)))- 1)) 
	+ '  ' + LTRIM(REVERSE(LEFT(REVERSE(PersStrasse), 
	LEN(PATINDEX('% %', REVERSE(PersStrasse))) + 1))) AS "Variante B"
FROM tblPersonal;

--10.	Ersetzen Sie bei allen Angestellten in der Spalte Straße das Leerzeichen durch ein Komma.
SELECT PersVorname, PersNachname,
	REPLACE(PersStrasse, ' ', ',') AS Strasse
FROM tblPersonal;

--11.	Ermitteln Sie von allen Angestellten die Länge des Ortsnamens.
SELECT PersVorname, PersNachname, PersOrt,
		LEN(PersOrt) AS 'Länge des Ortsnamens'
FROM tblPersonal;



SELECT PATINDEX('%[123] [abc]%', 'Blabla blabl2 Hallo Welt Bla2 Blabla');


