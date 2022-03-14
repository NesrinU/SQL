--Alle Aufgaben beziehen sich auf die Tabelle „Artikel“ der Datenbank „WaWi“. Kopieren Sie die Datenbank aus der Freigabe und fügen Sie diese an.
USE WAWI_BASIS;

--Aufgabe 2 (Projektion)
--Erstellen Sie SELECT-Statements für die folgenden Aufgaben:
--•	Lassen Sie den gesamten Inhalt der Tabelle anzeigen.
SELECT * 
FROM tblArtikel;

--•	Zeigen Sie die Spalten ArtBezeichnung, ArtGruppe und ArtLief an.
SELECT ArtBezeichnung, ArtGruppe, ArtLief 
FROM tblArtikel;

--•	Zeigen Sie die Spalten ArtBezeichnung, ArtVKPreis und ArtLieferzeit an.
SELECT ArtBezeichnung, ArtVKPreis, ArtLieferzeit 
FROM tblArtikel;

--•	Zeigen Sie die Spalten ArtBezeichnung, ArtVKPreis und ArtLieferzeit an. Vergeben Sie dabei die Überschriften Bezeichnung, VK-Preis und Lieferzeit.
SELECT a.ArtBezeichnung AS Bestellung, a.ArtVKPreis AS [VK-Preis], a.ArtLieferzeit AS Lieferzeit 
FROM tblArtikel a;

--Aufgabe 3 (Berechnungen)
--Führen Sie die folgenden Berechnungen durch. Lassen Sie jeweils die Artikelbezeichnung, die Basisspalten und die berechnete Spalte anzeigen. Vergeben Sie für die berechneten Spalten sinnvolle Aliasnamen:
--•	Ermitteln Sie die Differenz zwischen ArtVKPreis und ArtEKPreis. 
SELECT a.ArtVKPreis - a.ArtEKPreis AS Differenz
FROM tblArtikel a;

--•	Berechnen Sie den Wert der bestellten Artikel.
SELECT a.ArtBezeichnung AS Name , a.ArtMengeBestellt * a.ArtVKPreis AS Wert
FROM tblArtikel a
WHERE a.ArtMengeBestellt > 0;

--•	Berechnen Sie den Umsatzsteuerbetrag je Artikel. Basis ist der EK-Preis.
SELECT a.ArtBezeichnung AS Name , a.ArtEKPreis * a.ArtUSt / 100 AS Umsatzsteuerbetrag
FROM tblArtikel a;

--•	Berechnen Sie den VK-Preis eines Artikels, wenn man einen Aufschlag von 40% annimmt.
SELECT a.ArtBezeichnung AS Name , a.ArtVKPreis + (a.ArtVKPreis * 0.40) AS VK_Aufschlag
FROM tblArtikel a;

--•	Welches sind die 3 Artikel mit den höchsten Preisunterschieden zwischen ArtVKPreis und ArtEKPreis?
SELECT TOP 3 a.ArtBezeichnung AS Name , a.ArtVKPreis - a.ArtEKPreis AS TOP_Differenz
FROM tblArtikel a
ORDER BY a.ArtVKPreis - a.ArtEKPreis DESC;

--•	Welches sind die 3 Artikel mit den höchsten prozentualen Preisunterschieden zwischen ArtVKPreis und ArtEKPreis?
SELECT --TOP 3 
a.ArtBezeichnung AS Name , (a.ArtVKPreis / a.ArtEKPreis) * 100 AS TOP_Differenz
FROM tblArtikel a
WHERE ArtEKPreis != 0
	AND ArtEKPreis IS NOT NULL
	AND ArtVKPreis != 0
	AND ArtVKPreis IS NOT NULL
ORDER BY (a.ArtVKPreis / a.ArtEKPreis) * 100 DESC;

--•	Zeigen die die Top 3 der verkaufsstärksten Artikel
SELECT TOP 3 
a.ArtBezeichnung AS Name , a.ArtMengeBestellt AS Verkaufstärkste
FROM tblArtikel a
ORDER BY a.ArtMengeBestellt DESC;

--•	Zeigen Sie die Plätze 10 – 12 der verkaufsstärksten Artikel
SELECT 
a.ArtBezeichnung AS Name , a.ArtMengeBestellt AS Verkaufstärkste
FROM tblArtikel a
ORDER BY a.ArtMengeBestellt DESC
OFFSET 9 ROWS FETCH NEXT 3 ROWS ONLY;

--•	Zeigen Sie alle Artikel an, welche eine durch 7 teilbare Artikelnummer und mit ‚a‘ anfangen; sortieren Sie die Ausgabe absteigend nach dem Artikelpreis
SELECT a.ArtBezeichnung AS Name , a.ArtNr AS Artikelnummer
FROM tblArtikel a
WHERE a.ArtNr % 7 = 0 AND a.ArtBezeichnung LIKE 'a%'
ORDER BY a.ArtBezeichnung DESC;

--•	Welche Artikel haben folgende Eigenschaften: 
--o	In der Artikelbezeichnung kommt eine Zahl vor
--o	Die Lieferzeit ist kleiner als 3
--o	Entweder ist die Artikelnummer geteilt durch 2 kleiner als 550, oder die Bestellmenge ist größer als 10
SELECT *
FROM tblArtikel a
WHERE a.ArtBezeichnung LIKE '%[0-9]%' AND a.ArtLieferzeit < 3 AND ( (a.ArtNr / 2) < 550 OR a.ArtMengeBestellt > 10);
