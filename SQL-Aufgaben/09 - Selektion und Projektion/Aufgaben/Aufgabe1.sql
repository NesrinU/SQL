--Aufgabe 1
--Wechseln Sie in die WAWI-Datenbank.
USE WAWI_BASIS;

--a)	Lassen Sie alle Daten der Tabelle „tblKunden“ anzeigen.
SELECT * FROM tblKunden;

--b)	Lassen Sie alle Datensätze der Tabelle „tblPersonal“ anzeigen.
SELECT * FROM tblPersonal;

--c)	Zeigen die aus der Tabelle „tblPersonal“ nur den PersTitel, den PersVorname und den PersNachname an.
SELECT PersTitel, PersVorname, PersNachname 
FROM tblPersonal;

--d)	Filtern sie nur die Kunden heraus, welche eine Emailadresse haben. 
SELECT *
FROM tblKunden
WHERE KdEmail IS NOT NULL;

SELECT *
FROM tblKunden
WHERE KdEmail LIKE '%@%';

--e)	Listen Sie alle Artikel aus Tabelle „tblArtikel“ auf, bei denen der Verkaufspreis mehr als das doppelte des Einkaufspreises ist.
SELECT * 
FROM tblArtikel
WHERE ArtVKPreis > ArtEKPreis * 2;

--f)	Listen Sie den Artikelnamen in einer Spalte „Name“, die Bestellmenge in einer Spalte „Menge“ und den Umsatz (Bestellmenge * Verkaufspreis) in einer Spalte „Umsatz“ auf. Berücksichtigen Sie nur tatsächlich bestellte Artikel.
SELECT a.ArtBezeichnung AS Name, a.ArtMengeBestellt AS Menge, a.ArtMengeBestellt * a.ArtVKPreis AS Umsatz
	FROM	tblArtikel AS a;

--g)	Mit dem Verkauf welcher Artikel (in Spalte „Name“) wurde mehr als 1000€ Reingewinn (in Spalte „Gewinn“) gemacht?
SELECT a.ArtBezeichnung AS Name, (a.ArtVKPreis - a.ArtEKPreis) * ArtMengeBestellt AS Gewinn
		FROM	tblArtikel AS a
		WHERE (a.ArtVKPreis - a.ArtEKPreis) * ArtMengeBestellt> 1000;

--h)	Zeigen Sie alle Artikel des Lieferanten mit der Lieferantennummer 1130 an.
SELECT *
FROM tblArtikel 
WHERE ArtLief = 1130;

--i)	Zeigen Sie alle Artikel an, die weniger als 12,00 € kosten.
SELECT *
FROM tblArtikel 
WHERE ArtVKPreis < 12;

--j)	Zeigen Sie alle Arbeitsmäntel an.
SELECT *
FROM tblArtikel 
WHERE ArtBezeichnung LIKE '%arbeitsm%';

--k)	Zeigen Sie alle Artikel an, in deren Bezeichnung ein „glas“ vorkommt.
SELECT *
FROM tblArtikel 
WHERE ArtBezeichnung LIKE '%glas%';

--l)	Zeigen Sie alle Artikel der Artikelgruppe „KG“ an.
SELECT *
FROM tblArtikel 
WHERE ArtGruppe = 'KG';

--m)	Zeigen Sie alle Artikel an, die bestellt sind.
SELECT *
FROM tblArtikel 
WHERE ArtMengeBestellt > 0;

--n)	Zeigen Sie alle Artikel an, die nicht bestellt sind.
SELECT *
FROM tblArtikel 
WHERE ArtMengeBestellt = 0;

--o)	Zeigen Sie alle Artikel an, deren Bezeichnung mit „a“, „b“, „c“, „d“ oder „e“ beginnt.
SELECT *
FROM tblArtikel 
WHERE ArtBezeichnung LIKE '[a-e]%';

SELECT *
FROM tblArtikel 
WHERE ArtBezeichnung LIKE '[abcde]%';

--p)	Zeigen Sie alle Artikel an, bei denen die Differenz zwischen EK-Preis und VK-Preis weniger als  5,00 € beträgt
--q)	Zeigen Sie alle Artikel an, deren Bezeichnung aus sieben Zeichen besteht.
--r)	Zeigen Sie alle Artikel an, in deren Bezeichnung das vorletzte Zeichen eine Ziffer ist.
--s)	Zeigen Sie alle Artikel an, in deren Bezeichnung eine zweistellige Zahl enthalten ist.
--t)	Welche Artikel aus Aufgabe g) sind die fünf gewinnstärksten Artikel?
--u)	Verringern Sie die Preise aller Haushaltsartikel (ArtGruppe „HH“) um 10%, sofern der Verkaufspreis mehr als das Dreifache des Einkaufspreises ist.
--v)	Welche Artikelnamen beinhalten eine einstellige Zahl?
--w)	Wenn man die Artikel in der Tabelle „tblLagerstand“ nach der Lagermenge absteigend sortieren würde, welcher Artikel wäre dann an zwölfter Stelle?
