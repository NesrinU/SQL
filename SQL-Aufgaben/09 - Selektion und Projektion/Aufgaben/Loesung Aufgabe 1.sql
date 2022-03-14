-- Lösung Aufgabe 1

USE WAWI_BASIS;
GO

-- a)
SELECT *
FROM tblKunden;

-- b)
SELECT * 
FROM tblPersonal;

-- c)
SELECT PersTitel, PersVorname, PersNachname
FROM tblPersonal;

-- d)
SELECT *
FROM tblKunden
-- WHERE KdEmail LIKE '%@%';
WHERE KdEmail IS NOT NULL;

-- e)
SELECT *
FROM tblArtikel
WHERE ArtVKPreis > ArtEKPreis * 2;

-- f)
SELECT	ArtBezeichnung AS [Name],
		ArtMengeBestellt AS Menge,
		ArtMengeBestellt * ArtVKPreis AS Umsatz 
FROM tblArtikel
WHERE ArtMengeBestellt > 0;


-- g) 
--SELECT ArtBezeichnung AS Name 
--FROM tblArtikel
--WHERE ArtMengeBestellt * ArtVKPreis > 1000;

SELECT		ArtBezeichnung AS [Name],
			ArtMengeBestellt * (ArtVKPreis - ArtEKPreis) AS Gewinn
FROM tblArtikel
WHERE ArtMengeBestellt * (ArtVKPreis - ArtEKPreis) > 1000;


-- h)
SELECT *
FROM tblArtikel
WHERE ArtLief = 1130;


-- i)
SELECT ArtBezeichnung, ArtVKPreis AS ArtikelPreis
FROM tblArtikel
WHERE ArtVKPreis < 12;

-- j)
SELECT *
FROM tblArtikel
WHERE ArtBezeichnung LIKE '%mantel%';


-- k)
SELECT *
FROM tblArtikel
WHERE ArtBezeichnung LIKE '%glas%';


-- l)
SELECT *
FROM tblArtikel
WHERE ArtGruppe = 'KG';

-- m)
SELECT ArtBezeichnung
FROM tblArtikel
WHERE ArtMengeBestellt > 0;

-- n)
SELECT ArtBezeichnung
FROM tblArtikel
WHERE ArtMengeBestellt = 0;

-- o)
SELECT * 
FROM tblArtikel
WHERE ArtBezeichnung LIKE '[a-e]%';


-- p)
SELECT ArtBezeichnung
FROM tblArtikel
WHERE ArtVKPreis - ArtEKPreis < 5;


-- q)
SELECT *
FROM tblArtikel
WHERE ArtBezeichnung LIKE '_______';

SELECT *
FROM tblArtikel
WHERE LEN(ArtBezeichnung) = 7;


-- r)
SELECT *
FROM tblArtikel
WHERE ArtBezeichnung LIKE '%[0-9]_';


-- s)
SELECT *
FROM tblArtikel
-- WHERE ArtBezeichnung LIKE '%[0-9][0-9]%';
-- WHERE ArtBezeichnung LIKE '%[A-Z ][0-9][0-9][A-Z ]%';
WHERE ArtBezeichnung LIKE '%[^0-9][0-9][0-9][^0-9]%'
	OR ArtBezeichnung LIKE '[0-9][0-9][^0-9]%'
	OR ArtBezeichnung LIKE '%[^0-9][0-9][0-9]';


-- t)
SELECT		TOP 5
			ArtBezeichnung AS [Name],
			ArtMengeBestellt * (ArtVKPreis - ArtEKPreis) AS Gewinn
FROM tblArtikel
WHERE ArtMengeBestellt * (ArtVKPreis - ArtEKPreis) > 1000
ORDER BY Gewinn DESC;


-- u)
UPDATE tblArtikel
-- SET ArtVKPreis = ArtVKPreis - ArtVKPreis * 0.10
SET ArtVKPreis *= 0.9
WHERE ArtGruppe = 'HH' AND ArtVKPreis > 3 * ArtEKPreis;


-- v)
SELECT ArtBezeichnung AS Artikelname
FROM tblArtikel
WHERE ArtBezeichnung LIKE '%[^0-9][0-9][^0-9]%'
		OR ArtBezeichnung LIKE '[0-9][^0-9]%'
		OR ArtBezeichnung LIKE '%[^0-9][0-9]';


-- w)
SELECT *
FROM tblLagerstand
ORDER BY LagMenge DESC
OFFSET 11 ROW FETCH NEXT 1 ROW ONLY;
 









