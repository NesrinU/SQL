--Aufgabe 1
--Die Aufgabe bezieht sich auf Tabellen in der Datenbank NordwindSQL.
USE NordwindSQL;
GO
Select * FROM Bestellungen;
Select * FROM Bestelldetails;

--1.	Ermitteln Sie in einzelnen Abfragen die Anzahl der Bestellungen je Mitarbeiter, je Land, je Mitarbeiter pro Land und die Gesamtzahl.
SELECT [Personal-Nr] AS Mitarbeiter, COUNT(*) AS  Anzahl_Bestell
FROM Bestellungen
GROUP BY [Personal-Nr];

SELECT Bestimmungsland AS Land, COUNT(*) AS  Anzahl_Bestell
FROM Bestellungen
GROUP BY Bestimmungsland;

SELECT [Personal-Nr] AS Mitarbeiter, Bestimmungsland AS Land, COUNT(*) AS  Anzahl_Bestell
FROM Bestellungen
GROUP BY Bestimmungsland, [Personal-Nr];

SELECT COUNT(*) AS  Anzahl_Bestell
FROM Bestellungen;

--2.	Ändern Sie die obige Abfrage so, dass GROUPING SETS verwendet werden.

SELECT [Personal-Nr] AS Mitarbeiter, Bestimmungsland AS Land, COUNT(*) AS  Anzahl_Bestell
FROM Bestellungen
GROUP BY 
	GROUPING SETS
	(
		(Bestimmungsland, [Personal-Nr]),
		(Bestimmungsland),
		([Personal-Nr]),
		()
	);

--3.	Ändern Sie die obige Abfrage so, dass CUBE verwendet wird und anschließend ROLLUP. Sind die Ergebnismengen mit CUBE und ROLLUP unterschiedlich? Warum ist das so?
SELECT [Personal-Nr] AS Mitarbeiter, Bestimmungsland AS Land, COUNT(*) AS  Anzahl_Bestell
FROM Bestellungen
GROUP BY 
	CUBE(Bestimmungsland, [Personal-Nr]);

--4.	Erweitern Sie die obige Abfrage so, dass im Resultset kenntlich ist, welche Spalte in der Gruppierung verwendet wurde. Verwenden Sie die beiden entsprechenden Funktionen einzeln oder auch als Kombination.
SELECT GROUPING([Personal-Nr]) AS grp_Pers, GROUPING(Bestimmungsland) AS grp_Land, [Personal-Nr] AS Mitarbeiter, Bestimmungsland AS Land, COUNT(*) AS  Anzahl_Bestell
FROM Bestellungen
GROUP BY 
	CUBE(Bestimmungsland, [Personal-Nr]);

--5.	Ermitteln Sie in einer Abfrage die Anzahl der Artikel je Lieferant, je Kategorie, je Kategorie pro Lieferant und die Gesamtzahl. 
SELECT * FROM Artikel;

SELECT [Lieferanten-Nr], [Kategorie-Nr], COUNT(*) AS Anzahl_Artikel
FROM Artikel
GROUP BY
	CUBE([Lieferanten-Nr], [Kategorie-Nr]);

--6.	Ermitteln Sie in einer Abfrage die Anzahl der Artikel je Lieferant, je Kategorie pro Lieferant und die Gesamtzahl. 
SELECT [Lieferanten-Nr], [Kategorie-Nr], COUNT(*) AS Anzahl_Artikel
FROM Artikel
GROUP BY
	ROLLUP([Lieferanten-Nr], [Kategorie-Nr]);

--7.	Ermitteln Sie in einer Abfrage die Anzahl der Artikel je Lieferant pro Kategorie und die Gesamtzahl.
SELECT [Lieferanten-Nr], [Kategorie-Nr], COUNT(*) AS Anzahl_Artikel
FROM Artikel
GROUP BY
	GROUPING SETS
	(
		([Lieferanten-Nr], [Kategorie-Nr]),
		()
	);

--Aufgabe 2
--Die Aufgabe bezieht sich auf Tabellen in der Datenbank NordwindSQL.
--1.	Ermitteln Sie die Frachtkosten für jeden Kunden pro Versandfirma. Die Frachtkosten sollen für jede Versandfirma in einer eigenen Spalte erscheinen.
SELECT [Kunden-Code], [1] AS Firma_1, [2] AS Firma_2, [3] AS Firma_3
FROM Bestellungen
PIVOT(SUM(Frachtkosten) FOR Versandüber IN ([1], [2], [3])) AS pvt;

--2.	Erstellen Sie aus dem Resultset der obigen Abfrage eine neue Tabelle „Frachtkosten“.
SELECT [Kunden-Code], [1] AS Firma_1, [2] AS Firma_2, [3] AS Firma_3 INTO Frachtkosten
FROM Bestellungen
PIVOT(SUM(Frachtkosten) FOR Versandüber IN ([1], [2], [3])) AS pvt;

--3.	Erstellen Sie eine Abfrage auf Basis der neuen Tabelle, die „die Spalten wieder in Zeilen umwandelt“.

SELECT [Kunden-Code], Frachtkosten, Versandüber
FROM Frachtkosten
UNPIVOT(Frachtkosten FOR Versandüber IN ([Firma_1], [Firma_2], [Firma_3])) AS unpvt;