--Kopieren Sie die Datenbank „NordwindSQL“ auf Ihren Rechner und fügen Sie die Datenbank an
USE NordwindSQL;

--Aufgabe 1 
--Verwenden Sie jeweils JOINS, um die folgenden Aufgaben zu lösen:
--1. Zeigen Sie alle Kategoriebezeichnungen mit den zugehörigen Artikelbezeichnungen an.
SELECT k.Kategoriename, a.Artikelname
FROM Kategorien AS k
INNER JOIN Artikel AS a
ON k.[Kategorie-Nr] = a.[Kategorie-Nr];

--2. Zeigen Sie alle Lieferantennamen mit den zugehörigen Artikelbezeichnungen an.
SELECT a.Artikelname, l.Firma AS Lieferant
FROM Artikel AS a
INNER JOIN Lieferanten AS l
ON a.[Lieferanten-Nr] = l.[Lieferanten-Nr];

--3. Zeigen Sie alle deutschen Lieferantennamen mit den zugehörigen Artikelbezeichnungen an.
SELECT a.Artikelname, l.Firma AS Lieferant, l.Land
FROM Artikel AS a
INNER JOIN Lieferanten AS l
ON a.[Lieferanten-Nr] = l.[Lieferanten-Nr]
WHERE l.Land = 'Deutschland';

--4. Zeigen Sie alle spanischen Kundennamen mit deren Bestellungen an.
SELECT b.[Bestell-Nr], k.Firma, k.Land
FROM Bestellungen AS b
INNER JOIN Kunden AS k
ON b.[Kunden-Code] = k.[Kunden-Code]
WHERE k.Land = 'Spanien';

--5. Zeigen Sie alle Bestellungen an, die von „Andrew Fuller“ bearbeitet wurden.
SELECT b.[Bestell-Nr], p.Vorname + ' '+ p.Nachname AS Personal
FROM Bestellungen AS b
INNER JOIN Personal AS p
ON b.[Personal-Nr] = p.[Personal-Nr]
WHERE p.Vorname + ' '+ p.Nachname = 'Andrew Fuller';

--6. Zeigen Sie alle Bestellungen, die über die Firma „United Package“ versandt wurden.
SELECT b.[Bestell-Nr], v.Firma AS Firma
FROM Bestellungen AS b
INNER JOIN Versandfirmen AS v
ON b.VersandÜber = v.[Firmen-Nr]
WHERE v.Firma = 'United Package';

--7. Zeigen Sie alle Artikelbezeichnungen der Kategorien „Getränke“ und „Süßwaren“ an. 
SELECT a.Artikelname, k.Kategoriename 
FROM Kategorien AS k
INNER JOIN Artikel AS a
ON k.[Kategorie-Nr] = a.[Kategorie-Nr]
WHERE k.Kategoriename IN ('Getränke', 'Süßwaren');