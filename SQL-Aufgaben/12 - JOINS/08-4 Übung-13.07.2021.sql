--Aufgabe 1 
--Verwenden Sie jeweils JOINS, um die folgenden Aufgaben zu lösen:
--1. Ermitteln Sie, von welchen Kunden „Andrew Fuller" Bestellungen bearbeitet hat.
SELECT k.Firma AS Kunden, p.Vorname + ' ' + p.Nachname AS Personal
FROM Bestellungen AS b
INNER JOIN Kunden AS k
ON b.[Kunden-Code] = k.[Kunden-Code]
INNER JOIN Personal AS p
ON b.[Personal-Nr] = p.[Personal-Nr]
WHERE p.Vorname + ' ' + p.Nachname = 'Andrew Fuller';

--2. Ermitteln Sie über welche Versandfirmen, die Bestellungen des Kunden „Alfreds Futterkiste" 
--geliefert wurden.
SELECT v.Firma, b.[Bestell-Nr], k.Firma AS Kunden
FROM Bestellungen AS b
INNER JOIN Versandfirmen AS v
ON b.VersandÜber = v.[Firmen-Nr]
INNER JOIN Kunden AS k
ON b.[Kunden-Code] = k.[Kunden-Code]
WHERE k.Firma = 'Alfreds Futterkiste';

--3. Ermitteln Sie aus welchen Kategorien der Lieferant „Tokyo Traders" Artikel liefert.
SELECT k.Kategoriename, l.Firma Lieferant
FROM Artikel AS a
INNER JOIN Lieferanten AS l
ON a.[Lieferanten-Nr] = l.[Lieferanten-Nr]
Inner JOIN Kategorien AS k
ON a.[Kategorie-Nr] = k.[Kategorie-Nr]
WHERE l.Firma = 'Tokyo Traders';
 
--4. Ermitteln Sie welche Mitarbeiter von deutschen Kunden Bestellungen bearbeitet haben.
SELECT k.Firma AS Kunden, k.Land AS Kunden_Land, p.Vorname + ' ' + p.Nachname AS Personal
FROM Bestellungen AS b
INNER JOIN Kunden AS k
ON b.[Kunden-Code] = k.[Kunden-Code]
INNER JOIN Personal AS p
ON b.[Personal-Nr] = p.[Personal-Nr]
WHERE k.Land = 'Deutschland';

--5. Aus welchen Kategorien liefern die deutschsprachigen Lieferanten Artikel? 
SELECT k.Kategoriename, l.Firma+' - '+l.Land Lieferant
FROM Artikel AS a
INNER JOIN Lieferanten AS l
ON a.[Lieferanten-Nr] = l.[Lieferanten-Nr]
Inner JOIN Kategorien AS k
ON a.[Kategorie-Nr] = k.[Kategorie-Nr]
WHERE l.Land = 'Deutschland';

--a. Welche Artikel kosten weniger 10 €?
SELECT k.Kategoriename,  a.Artikelname, a.Einzelpreis, l.Firma+' - '+l.Land Lieferant
FROM Artikel AS a
INNER JOIN Lieferanten AS l
ON a.[Lieferanten-Nr] = l.[Lieferanten-Nr]
Inner JOIN Kategorien AS k
ON a.[Kategorie-Nr] = k.[Kategorie-Nr]
WHERE l.Land = 'Deutschland' AND a.Einzelpreis < 10;

--b. Welche Artikel kosten mehr als 10 € aber weniger als 15 €? 
SELECT k.Kategoriename, a.Artikelname, a.Einzelpreis, l.Firma+' - '+l.Land Lieferant
FROM Artikel AS a
INNER JOIN Lieferanten AS l
ON a.[Lieferanten-Nr] = l.[Lieferanten-Nr]
Inner JOIN Kategorien AS k
ON a.[Kategorie-Nr] = k.[Kategorie-Nr]
WHERE l.Land = 'Deutschland' AND a.Einzelpreis BETWEEN 10 AND 15;

--6. Welche Artikel wurden in der Bestellung mit der Nummer  10260 geordert? 
SELECT a.Artikelname, b.[Bestell-Nr]
FROM Artikel AS a
INNER JOIN Bestelldetails AS b
ON a.[Artikel-Nr] = b.[Artikel-Nr]
WHERE b.[Bestell-Nr] = 10260;

--Aufgabe 2 
--Verwenden Sie jeweils JOINS und Aggregatfunktinen, um die folgenden Aufgaben zu lösen:
--1. Aus wie vielen Kategorien liefert jeder Lieferant Artikel?
SELECT l.Firma AS Lieferant, COUNT(k.[Kategorie-Nr]) Anzahl_Kategorien
FROM Artikel AS a
INNER JOIN Kategorien AS k
ON a.[Kategorie-Nr] = k.[Kategorie-Nr]
INNER JOIN Lieferanten AS l
ON a.[Lieferanten-Nr] = l.[Lieferanten-Nr]
GROUP BY l.Firma;

--2. Wie viele Artikel gehören in jede Kategorie?
SELECT k.Kategoriename, COUNT(a.Artikelname) AS Anzahl_Artikel
FROM Artikel AS a
INNER JOIN Kategorien AS k
ON k.[Kategorie-Nr] = a.[Kategorie-Nr]
GROUP BY k.Kategoriename;

--3. Wieviel Artikel gehören jeweils in die Kategorien, aus denen ein Lieferant Artikel liefert?
???
SELECT l.Firma, k.Kategoriename, COUNT(a.[Artikel-Nr]) AS Anzahl_Artikel 
FROM Artikel AS a
INNER JOIN Kategorien AS k
ON k.[Kategorie-Nr] = a.[Kategorie-Nr]
INNER JOIN Lieferanten AS l
ON a.[Lieferanten-Nr] = l.[Lieferanten-Nr]
GROUP BY l.Firma, k.Kategoriename
ORDER BY l.Firma;

SELECT *
FROM Artikel

--4. Wieviele Bestellungen haben die einzelnen Mitarbeiter bearbeitet? 
SELECT p.Vorname+' '+p.Nachname AS Personal, COUNT(b.[Bestell-Nr]) AS Anzahl_Bestellung
FROM Bestellungen AS b
INNER JOIN Personal AS p
ON b.[Personal-Nr] = p.[Personal-Nr]
GROUP BY p.Vorname+' '+p.Nachname;