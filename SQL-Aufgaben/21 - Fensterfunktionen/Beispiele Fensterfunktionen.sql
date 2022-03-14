USE TeachSQL;
GO


CREATE TABLE TxnData (AcctId int, TxnDate date, Amount decimal)
GO


SELECT * FROM TxnData
ORDER BY TxnDate;


-- Summe auf sämtlichen Accounts
SELECT SUM(Amount)
FROM TxnData;

-- Summe pro Konto
SELECT AcctId,  SUM(Amount)
FROM TxnData
GROUP BY AcctId;

SELECT *, 
	(SELECT SUM(Amount) FROM TxnData x WHERE x.AcctId = y.AcctId)
FROM TxnData y;


-- Mit Fensterfunktion
SELECT *, 
	SUM(Amount) OVER () Gesamtsumme
FROM TxnData;

-- Summe für jede AcctId
SELECT *, 
	SUM(Amount) OVER (PARTITION BY AcctID) Gesamtsumme
FROM TxnData;


-- Laufende Summe der Zahlungseingänge
SELECT *, 
	SUM(Amount) OVER (
						PARTITION BY AcctID
						ORDER BY TxnDate
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
					) [laufende Summe]
FROM TxnData;

-- Summe zwischen akuteller und zwei vorheriger Zeilen
SELECT *, 
	SUM(Amount) OVER (
						PARTITION BY AcctID
						ORDER BY TxnDate
						ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
					) [laufende Summe]
FROM TxnData;

-- Summe zwischen akuteller und zwei nachfolgenden Zeilen
SELECT *, 
	SUM(Amount) OVER (
						PARTITION BY AcctID
						ORDER BY TxnDate
						ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
					) [laufende Summe]
FROM TxnData;

-- Summe zwischen akuteller, einer vorherigen und einer nachfolgenden Zeile
SELECT *, 
	SUM(Amount) OVER (
						PARTITION BY AcctID
						ORDER BY TxnDate
						ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
					) [laufende Summe]
FROM TxnData;

-- alternatives "LAG"
SELECT *, 
	SUM(Amount) OVER (
						PARTITION BY AcctID
						ORDER BY TxnDate
						ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
					) [Vorgänger]
FROM TxnData;

-- ROWS und RANGE
SELECT * FROM TxnData;

SELECT *, 
	SUM(Amount) OVER (
						PARTITION BY AcctID
						ORDER BY TxnDate
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
					) [laufende Summe]
FROM TxnData;

SELECT *, 
	SUM(Amount) OVER (
						PARTITION BY AcctID
						ORDER BY TxnDate
						RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
					) [laufende Summe]
FROM TxnData;


-- Fensterrangfunktionen
SELECT *,
	RANK()	OVER (ORDER BY Amount DESC)  AS [Rank],
	DENSE_RANK()	OVER (ORDER BY Amount DESC) AS [Dense_Rank],
	ROW_NUMBER() OVER (ORDER BY Amount DESC) [Row_Number],
	NTILE(2) OVER (ORDER BY Amount DESC) [Ntile]
FROM TxnData;


-- Versatzfunktionen
SELECT * ,
	LAG(Amount) OVER (PARTITION BY AcctID ORDER BY TxnDate) Vorheriger,
	LEAD(Amount) OVER (PARTITION BY AcctID ORDER BY TxnDate) Nachheriger,
	FIRST_VALUE(Amount) OVER (PARTITION BY AcctID ORDER BY TxnDate) ErsterWert,
	LAST_VALUE(Amount) OVER (PARTITION BY AcctID ORDER BY TxnDate
					ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) LetzterWert
FROM TxnData;




-- Weiteres Beispiel: Vorgehensweise
USE NordwindSQL;
GO

SELECT * FROM Personal;

-- Namen auflisten, deren Geburtsdatum und nach GebDat sortiert (aufsteigend)
-- Weitere Spalte: Altersunterschied zum Vorgänger

-- Spaltenliste
SELECT p.Vorname, p.Nachname, p.Geburtsdatum
FROM Personal p
ORDER BY p.Geburtsdatum;


-- Zwischenüberlegung: Jahresunterschied
SELECT DATEDIFF(YEAR, '03.07.1978', GETDATE());

-- Fensterfunktion anwenden
SELECT p.Vorname, p.Nachname, p.Geburtsdatum,
	LAG(Geburtsdatum) OVER (ORDER BY Geburtsdatum) [vorheriger Geburtstag]
FROM Personal p;

-- DATEDIFF einbeziehen
SELECT p.Vorname, p.Nachname, p.Geburtsdatum,
	DATEDIFF(YEAR, LAG(Geburtsdatum) OVER (ORDER BY Geburtsdatum), Geburtsdatum) [Altersunterschied]
FROM Personal p;





