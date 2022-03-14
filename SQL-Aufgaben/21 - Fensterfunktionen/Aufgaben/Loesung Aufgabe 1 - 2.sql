-- Lösung Aufgaben 1 - 2
USE NordwindSQL;
GO


--Aufgabe 1.1 Hilfsfunktion
CREATE OR ALTER FUNCTION ufnBestellsumme(@bnr int)
RETURNS DECIMAL(8,2)
AS
BEGIN
	DECLARE @summe money;
	SET @summe =(
		SELECT SUM(Einzelpreis * Anzahl * (1.0 - rabatt))
		FROM Bestelldetails
		WHERE [Bestell-Nr] = @bnr
	)
	RETURN CAST(@summe AS decimal(8,2));
END;
GO


CREATE OR ALTER VIEW vwKundensummen
AS
 SELECT [Kunden-Code] AS Kunde, [Bestell-Nr] AS Bestellung,
	CAST(Bestelldatum AS Date) AS Datum, 
	dbo.ufnBestellsumme([Bestell-Nr]) AS BestellSumme
 FROM Bestellungen b;
GO


SELECT * FROM vwKundensummen
ORDER BY Kunde;

SELECT * FROM Bestelldetails;


--Aufgabe 1.2
SELECT Kunde, Bestellung, Datum, BestellSumme,
	SUM(Bestellsumme) OVER(PARTITION BY Kunde) AS KundenSumme
FROM VwKundensummen;

SELECT Kunde, Bestellung, Datum, BestellSumme,
	SUM(Bestellsumme) OVER() AS KundenSumme
FROM VwKundensummen;


--Aufgabe 1.3
SELECT Kunde, Bestellung, Datum, BestellSumme,
	SUM(Bestellsumme) OVER(PARTITION BY Kunde) AS KundenSumme,
	SUM(Bestellsumme) OVER(PARTITION BY Kunde ORDER BY datum
		RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS LfdSumme
FROM VwKundensummen;


--Aufgabe 1.4
SELECT Kunde, Bestellung, Datum, BestellSumme,
	SUM(Bestellsumme) OVER(PARTITION BY Kunde) AS KundenSumme,
	SUM(Bestellsumme) OVER(PARTITION BY Kunde ORDER BY datum) AS LfdSumme,
	SUM(Bestellsumme) OVER(PARTITION BY Kunde ORDER BY datum
					ROWS BETWEEN 1 PRECEDING 
					AND	1 FOLLOWING) AS Summe3Zeilen
FROM VwKundensummen;

--Aufgabe 1.5
SELECT Kunde, Bestellung, Datum, BestellSumme,
	SUM(Bestellsumme) OVER(PARTITION BY Kunde) AS KundenSumme,
	SUM(Bestellsumme) OVER(PARTITION BY Kunde ORDER BY datum) AS LfdSumme,
	SUM(Bestellsumme) OVER(PARTITION BY Kunde ORDER BY datum
					ROWS BETWEEN 1 PRECEDING 
					AND	1 FOLLOWING) AS Summe3Zeilen,
	Bestellsumme * 100 / SUM(Bestellsumme) OVER(PARTITION BY Kunde) Anteil
FROM VwKundensummen;
GO


SELECT Bestellung,Kunde,Datum ,Bestellsumme,
SUM(Bestellsumme) OVER () AS Alle,
SUM(Bestellsumme) OVER (PARTITION BY Kunde) Kundensumme,
SUM(Bestellsumme) OVER (ORDER BY Kunde
                    ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) [Laufende Summe],
SUM(Bestellsumme) OVER (PARTITION BY Kunde)*100 / SUM(Bestellsumme)  OVER () AS Prozent
FROM VwKundensummen;
GO 


--Aufgabe 2.1

ALTER VIEW vwKundensummen
AS
 SELECT [Kunden-Code] AS Kunde, [Bestell-Nr] AS Bestellung,
	Bestimmungsland AS Land,
	CAST(Bestelldatum AS Date) AS Datum, ROUND(dbo.ufnBestellsumme([Bestell-Nr]),2) AS BestellSumme
 FROM Bestellungen b;
GO

SELECT * FROM vwKundensummen
ORDER BY Kunde;


--Aufgabe 2.2
WITH CTEKundensummen 
AS	(
	SELECT DISTINCT Kunde, 
		SUM(Bestellsumme) OVER (PARTITION BY Kunde) AS Summe
	FROM [vwKundensummen]
	)
SELECT ks.Kunde,ks.Summe,
	RANK() OVER(ORDER BY Summe DESC) AS Rang
FROM CTEKundensummen AS ks
ORDER BY Rang 
;
GO


SELECT * FROM vwKundensummen;


--Aufgabe 2.3

CREATE OR ALTER VIEW vwBestellung
AS
SELECT		b.[Kunden-Code],
			b.[Bestell-Nr],
			b.Bestimmungsland,
			b.Bestelldatum,
			CAST(
				SUM((bd.Anzahl * bd.Einzelpreis) * (1-bd.Rabatt))
					AS decimal (8,2)
				) AS Bestellsumme

	FROM Bestellungen AS b
	INNER JOIN Bestelldetails AS bd
	ON b.[Bestell-Nr] = bd.[Bestell-Nr]
	Group by b.[Kunden-Code], b.[Bestell-Nr],b.Bestimmungsland, b.Bestelldatum;

GO

SELECT		
	DENSE_RANK() OVER (PARTITION BY Land ORDER BY SUM(Bestellsumme) DESC )  AS 'Rang',
	Kunde,
	Land,
	SUM(Bestellsumme)
FROM vwKundensummen
GROUP BY Kunde, Land;

				


--Aufgabe 2.4
SELECT TOP 50 PERCENT kunde,
		SUM(BestellSumme) AS Summe,
		NTILE(2) OVER (ORDER BY SUM(Bestellsumme)DESC) AS Haelfte
	FROM vwKundensummen
	GROUP BY kunde;


SELECT kunde,
		SUM(BestellSumme) AS Summe,
		NTILE(2) OVER (ORDER BY SUM(Bestellsumme)DESC) AS Haelfte
FROM vwKundensummen
WHERE NTILE(2) OVER (ORDER BY SUM(Bestellsumme)DESC) = 1
GROUP BY kunde; -- geht nicht, da FFkt nicht in WHERE benutzt werden können

SELECT kunde,
		SUM(BestellSumme) AS Summe,
		NTILE(2) OVER (ORDER BY SUM(Bestellsumme)DESC) AS Haelfte
FROM vwKundensummen
GROUP BY kunde
HAVING NTILE(2) OVER (ORDER BY SUM(Bestellsumme)DESC) = 1; -- geht nicht, da FFkt nicht in HAVING benutzt werden können


WITH CTEKundenhaelfte 
AS	(
	SELECT kunde,
		SUM(BestellSumme) AS Summe,
		NTILE(2) OVER (ORDER BY SUM(Bestellsumme)DESC) AS Haelfte
	FROM vwKundensummen
	GROUP BY kunde
	)
SELECT * FROM CTEKundenhaelfte
WHERE Haelfte = 1;



SELECT Bestellung, Kunde, Datum ,Bestellsumme,
RANK() OVER (PARTITION BY [Kunde]
ORDER BY Bestellsumme DESC) AS [Ordnen nach Kunde]
FROM vwKundensummen;

SELECT * FROM vwKundensummen;
