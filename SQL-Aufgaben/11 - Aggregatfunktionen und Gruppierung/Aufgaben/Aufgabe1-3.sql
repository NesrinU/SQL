--Aufgabe 1
--Nutzen Sie bitte die Tabelle tblArtikel in der WAWI-Datenbank.
USE WAWI_BASIS;

SELECT *
FROM tblArtikel;

--Verwenden Sie jeweils Aggregatfunktionen, um die folgenden Aufgaben zu lösen:
--1.	Wie teuer ist der billigste und der teuerste Artikel. (Basis ist der EK-Preis)
SELECT MAX(ArtEKPreis) AS [Teuerste], MIN(ArtEKPreis) AS [Billigste]
FROM tblArtikel;


--2.	Ermitteln Sie den Durchschnittspreis aller Artikel.
SELECT AVG(ArtEKPreis) AS [Durchschnittspreis]
FROM tblArtikel;

--3.	Wie hoch ist die Anzahl der bestellten Artikel?
SELECT SUM(ArtMengeBestellt)
FROM tblArtikel;

--4.	Wie viele Artikel haben einen Umsatzsteuersatz von 19%?
SELECT COUNT(ArtUSt)
FROM tblArtikel
WHERE ArtUSt = 19;

--5.	Wie viel kostet der teuerste Artikel, der von den Lieferanten mit der Nummer 1001 bzw. 1130 geliefert wird?
SELECT MAX(ArtEKPreis) AS [Teuerste]
FROM tblArtikel
WHERE ArtLief = 1001 OR ArtLief = 1130;

--6.	Bei wie vielen Artikeln ist die Lieferzeit unbekannt?
SELECT COUNT(*) AS [Artikel-Unbekannte Lieferzeit]
FROM tblArtikel
WHERE ArtLieferzeit IS NULL;

--Aufgabe 2
--Verwenden Sie jeweils Aggregatfunktionen und die GROUP BY-Klausel, um die folgenden Aufgaben zu lösen:
--1.	Wie teuer ist in jeder Artikelgruppe der billigste und der teuerste Artikel?
SELECT ArtGruppe, MAX(ArtEKPreis) AS [Teuerste], MIN(ArtEKPreis) AS [Billigste]
FROM tblArtikel
GROUP BY ArtGruppe;

--2.	Ermitteln Sie den Durchschnittspreis der Artikel pro Kategorie.
SELECT ArtGruppe, AVG(ArtEKPreis) AS [Durchschnittspreis]
FROM tblArtikel
GROUP BY ArtGruppe;

--3.	Ermitteln Sie den Durchschnittspreis, der Artikel je Lieferant.
SELECT ArtLief, AVG(ArtEKPreis) AS [Durchschnittspreis]
FROM tblArtikel
GROUP BY ArtLief;

--4.	Wie teuer ist der teuerste Artikel je Lieferant aus den Kategorien GA und HW?
SELECT ArtLief, MAX(ArtEKPreis) AS [Teuerste]
FROM tblArtikel
WHERE ArtGruppe = 'GA' OR ArtGruppe = 'HW'
GROUP BY ArtLief;
--ODER
SELECT ArtLief, MAX(ArtEKPreis) AS [Teuerste]
FROM tblArtikel
WHERE ArtGruppe IN ('GA', 'HW')
GROUP BY ArtLief;

--5.	Ermitteln Sie, wie viele Artikel jeder Lieferant liefert.
SELECT ArtLief, SUM(ArtMengeBestellt) AS [Menge-Artikel]
FROM tblArtikel
GROUP BY ArtLief;

--Aufgabe 3
--Die folgende Aufgabe bezieht sich auf die ang-Tabelle in der TeachSQL-Datenbank
USE TeachSQL;

SELECT *
FROM ang;

--1.	Ermitteln Sie das durchschnittliche Monatsgehalt je Abteilung.
SELECT abt_nr, AVG(gehalt) AS [Durchschnitt-Gehalt]
FROM ang
GROUP BY abt_nr;

--2.	Wie hoch sind die Personalkosten im Monat?
SELECT SUM(gehalt) AS [PersonalKosten]
FROM ang;

--3.	Wie hoch sind die Personalkosten je Abteilung?
SELECT abt_nr, SUM(gehalt) AS [PersonalKosten]
FROM ang
GROUP BY abt_nr;

--4.	Was verdienen die Personen im Durchschnitt, die an zweiter Stelle ihres Namens ein „a“ oder ein „i“ haben?
SELECT AVG(gehalt) AS [Durchschnittsgehalt]
FROM ang
WHERE name LIKE '[a-z][ai]%';

SELECT AVG(gehalt) AS [Durchschnittsgehalt]
FROM ang
WHERE name LIKE '_[ai]%';

SELECT AVG(gehalt) AS [Durchschnittsgehalt]
FROM ang
WHERE SUBSTRING();

