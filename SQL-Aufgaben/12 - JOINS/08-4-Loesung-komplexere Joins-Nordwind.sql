--Aufgabe 1.1
SELECT DISTINCT k.Firma,
		p.nachname,
		p.vorname
FROM personal AS p
INNER JOIN Bestellungen AS b
ON p.[personal-nr] = b.[Personal-nr]
INNER JOIN Kunden AS k
ON b.[Kunden-Code] = k.[Kunden-Code]
WHERE p.nachname='Fuller'
ORDER BY k.firma

--Aufgabe 1.2
SELECT DISTINCT v.firma AS Versandfirma,
		k.firma AS Kunde
FROM Versandfirmen AS v
INNER JOIN Bestellungen b
ON v.[Firmen-Nr] = b.[Versand‹ber]
INNER JOIN kunden AS k
ON b.[Kunden-Code] = k.[Kunden-code]
WHERE k.Firma LIKE  'Alfreds Futterkiste'

--Aufgabe 1.3
SELECT DISTINCt k.Kategoriename,
	l.Firma
FROM Kategorien AS k
INNER JOIN Artikel a
ON k.[Kategorie-Nr] = a.[Kategorie-Nr]
INNER JOIN Lieferanten l
ON a.[Lieferanten-nr] = l.[Lieferanten-Nr]
WHERE l.Firma = 'Tokyo Traders'

--Aufgabe 1.4
SELECT DISTINCT p.Nachname,
		p.Vorname,
		k.land
FROM personal AS p
INNER JOIN Bestellungen AS b
ON p.[Personal-NR] = b.[Personal-Nr]
INNER JOIN kunden AS k
ON b.[Kunden-Code] = k.[Kunden-Code]
WHERE k.land = 'Deutschland'

--Aufgabe 1.5
SELECT DISTINCT l.Firma,
		k.Kategoriename
FROM kategorien AS k
INNER JOIN Artikel AS a 
ON k.[Kategorie-Nr] = a.[Kategorie-Nr]
INNER JOIN Lieferanten AS l
ON a.[Lieferanten-Nr] = l.[Lieferanten-Nr]
WHERE l.Land IN ('Deutschland' , 'Schweiz', '÷sterreich')

--Aufgabe 1.5a
SELECT DISTINCT l.Firma,
		k.Kategoriename,
		a.Artikelname,
		a.Einzelpreis
FROM kategorien AS k
INNER JOIN Artikel AS a 
ON k.[Kategorie-Nr] = a.[Kategorie-Nr]
INNER JOIN Lieferanten AS l
ON a.[Lieferanten-Nr] = l.[Lieferanten-Nr]
WHERE l.Land IN ('Deutschland' , 'Schweiz', '÷sterreich')
AND WHERE a.Einzelpreis < 5

--Aufgabe 1.5b
SELECT DISTINCT l.Firma,
		k.Kategoriename,
		a.Artikelname,
		a.Einzelpreis
FROM kategorien AS k
INNER JOIN Artikel AS a 
ON k.[Kategorie-Nr] = a.[Kategorie-Nr]
INNER JOIN Lieferanten AS l
ON a.[Lieferanten-Nr] = l.[Lieferanten-Nr]
WHERE l.Land IN ('Deutschland' , 'Schweiz', '÷sterreich')
AND a.Einzelpreis BETWEEN 10 AND 15


--Aufgabe 1.6
SELECT b.[Bestell-nr],
		a.Artikelname
FROM Bestellungen AS b
INNER JOIN Bestelldetails AS bd
ON b.[Bestell-nr] = bd.[Bestell-nr]
INNER JOIN Artikel AS a
ON bd.[Artikel-Nr] = a.[Artikel-Nr]
WHERE b.[Bestell-nr] = 10260

--Aufgabe 2.1
SELECT DISTINCt count (DISTINCT k.Kategoriename) AS [Anzahl an Kategorien],
	l.Firma
FROM Kategorien AS k
INNER JOIN Artikel a
ON k.[Kategorie-Nr] = a.[Kategorie-Nr]
INNER JOIN Lieferanten l
ON a.[Lieferanten-nr] = l.[Lieferanten-Nr]
GROUP BY 	l.Firma

--Aufgabe 2.2
SELECT k.Kategoriename,
		COUNT(DISTINCT a.Artikelname) AS [Anzahl der Artikel]
FROM kategorien AS k
INNER JOIN Artikel a
ON k.[Kategorie-Nr] = a.[Kategorie-Nr]
GROUP BY k.Kategoriename

--Aufgabe 2.3
SELECT l.Firma,
		k.kategoriename,
		COUNT(a.artikelname) AS [Anzahl der Artikel]
FROM Lieferanten l
INNER JOIN Artikel a
ON a.[Lieferanten-Nr] = l.[Lieferanten-Nr] 
INNER JOIN Kategorien k
ON a.[Kategorie-Nr] = k.[Kategorie-Nr]
GROUP BY l.Firma, k.kategoriename
ORDER BY l.firma

--Aufgabe 2.4
SELECT p.Nachname, 
	p.Vorname,
	COUNT(b.[Bestell-Nr]) AS [Anzahl der Bestellungen]
FROM personal AS p
INNER JOIN Bestellungen AS b
ON p.[Personal-Nr]=b.[Personal-Nr]
GROUP BY p.Nachname, p.Vorname