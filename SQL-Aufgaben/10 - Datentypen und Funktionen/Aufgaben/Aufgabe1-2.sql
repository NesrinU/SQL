--Die folgenden Aufgaben beziehen sich auf die Tabelle dbo.tblPersonal in der WAWI-Datenbank
--Aufgabe 1
USE WAWI_BASIS;

SELECT * 
FROM tblPersonal;

--Verwenden Sie jeweils Datums-Funktionen, um die folgenden Aufgaben durchzuführen. Lassen Sie jeweils Vor- und Nachname und die in den Bedingungen geforderten Spalten anzeigen:
--1.	Zeigen Sie von allen Angestellten jeweils nur den Tag, den Monat bzw. das Jahr  des Eintrittsdatums an.
SELECT PersVorname, PersNachname, PersEintritt, DAY(PersEintritt) AS Tag,  MONTH(PersEintritt) AS Monat, YEAR(PersEintritt) AS Jahr
FROM tblPersonal;

--2.	Zeigen Sie von allen Angestellten das Eintrittsjahr an.
SELECT PersVorname, PersNachname, YEAR(PersEintritt) AS Eintrittsjahr
FROM tblPersonal
;

--3.	Ermitteln Sie alle Angestellten, die in einem Januar ihre Stelle angetreten haben.
SELECT PersVorname, PersNachname, MONTH(PersEintritt) AS EintrittsMonat, YEAR(PersEintritt) AS EintrittsJahr
FROM tblPersonal
WHERE MONTH(PersEintritt) = 1;

--4.	Ermitteln Sie alle Angestellten, die in einem März angefangen haben und die Angestellten, die in einem Juli angefangen haben.
SELECT PersVorname, PersNachname, MONTH(PersEintritt) AS EintrittsMonat, YEAR(PersEintritt) AS EintrittsJahr
FROM tblPersonal
WHERE MONTH(PersEintritt) = 3 OR MONTH(PersEintritt) = 7;

--5.	Ermitteln Sie alle Angestellten, die in einem 2. Quartal angefangen haben.
SELECT PersVorname, PersNachname, MONTH(PersEintritt) AS EintrittsMonat, YEAR(PersEintritt) AS EintrittsJahr
FROM tblPersonal
WHERE MONTH(PersEintritt) >= 4 AND MONTH(PersEintritt)  <= 6;
--ODER
SELECT PersVorname, PersNachname, MONTH(PersEintritt) AS EintrittsMonat, YEAR(PersEintritt) AS EintrittsJahr
FROM tblPersonal
WHERE MONTH(PersEintritt) BETWEEN 4 AND 6;

--6.	Ermitteln Sie alle Angestellten, die in der 40. KW angefangen haben.
SELECT PersVorname, PersNachname, DATEPART(WW, PersEintritt) AS KW, DAY(PersEintritt) AS Tag,  MONTH(PersEintritt) AS Monat, YEAR(PersEintritt) AS Jahr
FROM tblPersonal
WHERE DATEPART(WW, PersEintritt) = 40;

--7.	Ermitteln Sie das ungefähre Alter aller Angestellten, an deren Eintrittsdatum.
SELECT PersVorname, PersNachname, DATEDIFF(YEAR, PersGebDatum, PersEintritt) AS [Alter], CAST(PersEintritt AS DATE) AS Eintritt
FROM tblPersonal;

--8.	Ermitteln Sie alle Angestellten, die bei in ihrem Eintrittsjahr jünger als 40 waren.
SELECT PersVorname, PersNachname, DATEDIFF(YEAR, PersGebDatum, PersEintritt) AS [Alter], CAST(PersEintritt AS DATE) AS Eintritt
FROM tblPersonal
WHERE DATEDIFF(YEAR, PersGebDatum, PersEintritt) < 40;

--9.	Ermitteln Sie die Angestellten, die seit mehr als 8 Jahren beschäftigt sind. (Es darf kein statisches Datum als Kriterium verwendet werden.)
SELECT PersVorname, PersNachname, CAST(PersEintritt AS DATE) AS Eintritt, DATEDIFF(YEAR, PersEintritt, GETDATE()) AS Beschäf_Jahr
FROM tblPersonal
WHERE DATEDIFF(YEAR, PersEintritt, COALESCE(PersAustritt, GETDATE())) > 8;

--10.	Zeigen Sie von allen Angestellten das Eintrittsdatum im deutschen, amerikanischen und ANSI-Format an. (Tip: https://msdn.microsoft.com/de-de/library/ms187928.aspx)
SELECT PersVorname, PersNachname, CAST(PersEintritt AS DATE) AS Eintritt,
CONVERT(VARCHAR(20), PersEintritt, 104) AS Deutsch,
CONVERT(VARCHAR(20), PersEintritt, 101) AS USA,
CONVERT(VARCHAR(20), PersEintritt, 112) AS Ansi
FROM tblPersonal;

--11.	Lassen Sie jeweils den Wochentag und den Monat des Eintrittsdatums als ganze Zahl anzeigen.
SELECT PersVorname, PersNachname, CONCAT(DATEPART(DW, PersEintritt), DATEPART(MM, PersEintritt)) AS [Tag und Monat], CAST(PersEintritt AS DATE) AS Eintritt
FROM tblPersonal;

--12.	Lassen Sie jeweils den Wochentag und den Monat des Eintrittsdatums als Name anzeigen.
SELECT PersVorname, PersNachname, CONCAT(DATENAME(DW, PersEintritt), ' ', DATENAME(MM, PersEintritt)) AS [Tag und Monat], CAST(PersEintritt AS DATE) AS Eintritt
FROM tblPersonal;

--Aufgabe 2
--Verwenden Sie jeweils String-Funktionen, um die folgenden Aufgaben durchzuführen. Ermitteln Sie, falls nötig, vorher die passende Funktion selbständig.
--Lassen Sie jeweils Vor- und Nachname und die, in den Bedingungen geforderten Spalten anzeigen:
--1.	Zeigen Sie von allen Angestellten Land, PLZ und Ort kombiniert in einer Spalte an. 
SELECT PersVorname, PersNachname, CONCAT(PersPlz, ' ', PersOrt, ' ', PersLand) AS [Kombinierte Adresse]
FROM tblPersonal;

--2.	Zeigen Sie von allen Angestellten Vor- und Nachname in einer Spalte an. Verwenden Sie das folgende Format: name, vorname.
SELECT PersVorname, PersNachname, CONCAT(PersNachname, ', ', PersVorname) AS [Name-Vorname]
FROM tblPersonal;

--3.	Zeigen Sie von allen Angestellten die ersten drei Buchstaben des Ortes an.
SELECT PersVorname, PersNachname, PersOrt, SUBSTRING(PersOrt, 1, 3) AS [Erste 3]
FROM tblPersonal;
--ODER
SELECT PersVorname, PersNachname, PersOrt, LEFT(PersOrt, 3) AS [Erste 3]
FROM tblPersonal;

--4.	Zeigen Sie von allen Angestellten die letzten 4 Buchstaben des Ortes an.
SELECT PersVorname, PersNachname, PersOrt, RIGHT(PersOrt, 4) AS [Letzte 4]
FROM tblPersonal;
--ODER
SELECT PersVorname, PersNachname, PersOrt, REVERSE(SUBSTRING(REVERSE(PersOrt), 1, 4)) AS [Erste 3]
FROM tblPersonal;

--5.	Zeigen Sie von allen Angestellten den Ort in Großbuchstaben an.
SELECT PersVorname, PersNachname, PersOrt, UPPER(PersOrt) AS [ORT]
FROM tblPersonal;

--6.	Zeigen Sie von allen Angestellten den Ort in Kleinbuchstaben an.
SELECT PersVorname, PersNachname, PersOrt, LOWER(PersOrt) AS [ort]
FROM tblPersonal;

--7.	Ermitteln Sie von allen Angestellten die Länge des Vornamens.
SELECT PersVorname, PersNachname, LEN(PersVorname) AS [LängeVorname]
FROM tblPersonal;

--8.	Zeigen Sie von allen Angestellten die Initialen an.
SELECT PersVorname, PersNachname, CONCAT(LEFT(PersVorname, 1), LEFT(PersNachname, 1)) AS [Initialen]
FROM tblPersonal;

--9.	Fügen Sie bei allen Angestellten in der Spalte Straße zwei Leerzeichen zwischen Straße und Hausnummer ein.
SELECT PersVorname, PersNachname, PersStrasse, REPLACE(PersStrasse, ' ', '  ') AS [2 Leerzeichen (Straße-Nr)]
FROM tblPersonal;

--10.	Ersetzen Sie bei allen Angestellten in der Spalte Straße das Leerzeichen durch ein Komma.
SELECT PersVorname, PersNachname, PersStrasse, REPLACE(PersStrasse, ' ', ',') AS [Koma (Straße-Nr)]
FROM tblPersonal;

--11.	Ermitteln Sie von allen Angestellten die Länge des Ortsnamens.
SELECT PersVorname, PersNachname, PersOrt, LEN(PersOrt) AS [Länge-Ort]
FROM tblPersonal;
