-- Beispiele zu SELECT

-- Erste SELECTs
SELECT 1;
SELECT 'Hallo';
SELECT Hallo;
SELECT [Hallo];
SELECT "Hallo";

-- Kommazahlen
SELECT 3,4;
SELECT 3.4;

-- Aliase
SELECT 'Es klapperten die Klapperschlangen';
SELECT 'Bis ihre Klappern schlapper klangen' AS Spalte1;
SELECT 'Hallo Welt' Beispiel;
SELECT 1 Zahl, 'Hallo Welt' AS Zeichenkette;


-- Berechnungen
SELECT 1 + 1;
SELECT 1 + '1';
SELECT '1' + '1';
SELECT '1' + 1;

SELECT 7 / 2;
SELECT 7 / 2.0;
SELECT 7.0 / 2;

-- Schöne Funktionen
SELECT GETDATE() [Datum und Uhrzeit];
SELECT SUSER_NAME();
SELECT USER_NAME();
SELECT CURRENT_USER;

-- Abfragen auf Tabellen
SELECT * FROM abt;
SELECT abt_name Abteilungsname
FROM abt;

-- Aliase für Tabellen
SELECT a.gehalt, a.name, a.vorg
FROM ang a;

SELECT *
FROM (VALUES ('Hur', 'rah'), ('Jip', 'pieh')) t(Spalte1, Spalte2);



-- Tabellenergebnisse einschränken
SELECT * 
FROM ang
WHERE gehalt > 4500;

SELECT a.name, a.beruf Job
FROM ang a
WHERE Job LIKE 'Pro%';






-- Tabellenergebnisse sortieren
SELECT * 
FROM ang
WHERE gehalt > 4500
ORDER BY gehalt ASC;

SELECT * 
FROM ang
WHERE gehalt > 4500
ORDER BY gehalt DESC;

SELECT a.name, a.beruf Job, a.gehalt
FROM ang a
WHERE gehalt > 4500
ORDER BY Job;

SELECT * FROM ang
WHERE vorg IS NOT NULL;


SELECT 1 + NULL;
SELECT 'Hallo' + NULL + 'Welt!';

USE Northwind;

SELECT * 
FROM Products
ORDER BY UnitPrice;

DECLARE @zahl INT = 20;

SELECT * 
FROM Products
ORDER BY UnitPrice
OFFSET @zahl ROW FETCH NEXT 10 ROWS ONLY;













