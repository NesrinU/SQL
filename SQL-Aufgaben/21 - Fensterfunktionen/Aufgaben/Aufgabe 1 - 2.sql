--Aufgabe 1
--Die Aufgabe bezieht sich auf Tabellen in der Datenbank NordwindSQL.
USE NordwindSQL;
SELECT * FROM Bestellungen;
SELECT * FROM Bestelldetails;

--1.	Erstellen Sie eine Sicht „vwBestellungen“, die die Kundennummer, die Bestellnummer, das Datum und die Bestellsumme (muss errechnet werden) aus der Tabelle Bestellungen enthält. Die Spalte Bestellsumme soll auf zwei Nachkommastellen gerundet und vom Typ decimal(8,2) sein.
CREATE OR ALTER VIEW vwBestellungen 
AS
	SELECT DISTINCT bg.[Kunden-Code], bd.[Bestell-Nr], bg.[Bestelldatum],   
		SUM(CONVERT(decimal(8,2),bd.Einzelpreis*bd.Anzahl*(1-bd.Rabatt))) OVER (PARTITION BY bd.[Bestell-Nr])  AS Bestellsumme
	FROM Bestelldetails AS bd
	INNER JOIN Bestellungen AS bg
	ON bd.[Bestell-Nr] = bg.[Bestell-Nr];

SELECT * FROM vwBestellungen;
 
--2.	Erstellen Sie eine Abfrage, die die Daten der View abfragt. Zusätzlich soll in einer Spalte die Gesamtsumme der Kundenbestellungen angezeigt werden. 
SELECT *,
	SUM(Bestellsumme) OVER (PARTITION BY [Kunden-Code])  AS Gesamtsumme
FROM vwBestellungen;

--3.	Erweitern Sie die obige Abfrage, so dass in einer weiteren Spalte die laufende Summe je Kunde errechnet wird.
SELECT *,
	SUM(Bestellsumme) OVER (PARTITION BY [Kunden-Code])  AS Gesamtsumme,
	SUM(Bestellsumme) OVER (
						PARTITION BY [Kunden-Code]
						ORDER BY [Bestell-Nr]
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
					) [laufende Summe]
FROM vwBestellungen;

--4.	Erweitern Sie die obige Abfrage erneut, so dass in einer neuen Spalte die Summe der aktuellen, der vorherigen und der folgenden Bestellung angezeigt wird.
SELECT *,
	SUM(Bestellsumme) OVER (PARTITION BY [Kunden-Code])  AS Gesamtsumme,
	SUM(Bestellsumme) OVER (
						PARTITION BY [Kunden-Code]
						ORDER BY [Bestell-Nr]
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
					) [laufende Summe],
	SUM(Bestellsumme) OVER (
						PARTITION BY [Kunden-Code]
						ORDER BY [Bestell-Nr]
						ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
					) [laufende Summe - 2]
FROM vwBestellungen;

--5.	Ermitteln Sie in einer weiteren Spalte, den Anteil der Bestellung an der Gesamtsumme der Bestellungen jedes Kunden in %.
SELECT *,
	SUM(Bestellsumme) OVER (PARTITION BY [Kunden-Code])  AS Gesamtsumme,
	SUM(Bestellsumme) OVER (
						PARTITION BY [Kunden-Code]
						ORDER BY [Bestell-Nr]
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
					) AS [laufende Summe],
	SUM(Bestellsumme) OVER (
						PARTITION BY [Kunden-Code]
						ORDER BY [Bestell-Nr]
						ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
					) AS [laufende Summe - 2],
	CONVERT(DECIMAL(8,2),Bestellsumme/(SUM(Bestellsumme) OVER (PARTITION BY [Kunden-Code]))*100) AS [Anteil-Prozent]
FROM vwBestellungen;


--Aufgabe 2
--Die Aufgabe bezieht sich auf Tabellen in der Datenbank NordwindSQL.
--1.	Fügen Sie der Sicht „vwBestellungen“ eine Spalte mit dem Bestimmungsland hinzu.
CREATE OR ALTER VIEW vwBestellungen 
AS
	SELECT DISTINCT bg.[Kunden-Code], bd.[Bestell-Nr], bg.[Bestelldatum],   
		SUM(CONVERT(decimal(8,2),bd.Einzelpreis*bd.Anzahl*(1-bd.Rabatt))) OVER (PARTITION BY bd.[Bestell-Nr])  AS Bestellsumme,
		bg.Bestimmungsland
	FROM Bestelldetails AS bd
	INNER JOIN Bestellungen AS bg
	ON bd.[Bestell-Nr] = bg.[Bestell-Nr];

SELECT * FROM vwBestellungen;

--2.	Ermitteln Sie die Rangfolge der Kunden. Kriterium ist die gesamte Bestellsumme eines Kunden.
SELECT *,
	RANK()	OVER (PARTITION BY [Kunden-Code] ORDER BY Bestellsumme DESC) AS [Rank]
	--DENSE_RANK()	OVER (PARTITION BY [Kunden-Code] ORDER BY Bestellsumme DESC) AS [Dense_Rank]
	--ROW_NUMBER() OVER (ORDER BY Amount DESC) [Row_Number]
FROM vwBestellungen;

--3.	Ändern Sie die obige Abfrage, so dass die Rangfolge des Kunden innerhalb des Landes angezeigt wird.
SELECT *,
	--RANK()	OVER (PARTITION BY Bestimmungsland ORDER BY [Kunden-Code] DESC) AS [Rank]
	DENSE_RANK()	OVER (PARTITION BY Bestimmungsland ORDER BY [Kunden-Code] DESC) AS [Dense_Rank]
	--ROW_NUMBER() OVER (ORDER BY Amount DESC) [Row_Number]
FROM vwBestellungen;

--4.	Lassen Sie alle Kunden anzeigen, die sich in der oberen Hälfte der Kundenrangliste befinden.
--SELECT *,
--	NTILE(2) OVER (ORDER BY Amount DESC) [Ntile]
--FROM vwBestellungen;