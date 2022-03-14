USE Personal;
GO

--Aufgabe 1
SELECT perstitel,
	PersVorname,
	PersNachname
FROM tblPersonal;

--Aufgabe 2.1
SELECT perstitel,
	PersVorname,
	PersNachname,
	PersAkadGrad
FROM tblPersonal
WHERE PersAkadGrad ='Dr.';

--Aufgabe 2.2
SELECT perstitel,
	PersVorname,
	PersNachname,
	PersGeschlecht
FROM tblPersonal
WHERE PersGeschlecht=1;

--Aufgabe 2.3
SELECT perstitel,
	PersVorname,
	PersNachname,
	PersGeschlecht,
	PersAbteilung
FROM tblPersonal
WHERE PersAbteilung=40;

--Aufgabe 2.4
SELECT perstitel,
	PersVorname,
	PersNachname,
	PersGeschlecht,
	PersAbteilung
FROM tblPersonal
WHERE PersAbteilung=40
AND PersGeschlecht = 1;


--Aufgabe 2.5
SELECT perstitel,
	PersVorname,
	PersNachname,
	PersGeschlecht,
	PersAbteilung
FROM tblPersonal
WHERE PersAbteilung=40
OR PersAbteilung=55;

--oder
SELECT perstitel,
	PersVorname,
	PersNachname,
	PersGeschlecht,
	PersAbteilung
FROM tblPersonal
WHERE PersAbteilung IN (40,55)

--Aufgabe 2.6
SELECT perstitel,
	PersVorname,
	PersNachname
FROM tblPersonal
WHERE PersTitel IS NULL;

--Aufgabe 2.7
SELECT perstitel,
	PersVorname,
	PersNachname,
	PersAustritt
FROM tblPersonal
WHERE PersAustritt IS NULL;

--Aufgabe 2.8
SELECT perstitel,
	PersVorname,
	PersNachname,
	PersLand,
	PersPlz
FROM tblPersonal
WHERE PersLand = 'A'
AND PersPlz LIKE'8%';

--Aufgabe 2.9
SELECT perstitel,
	PersVorname,
	PersNachname,
	PersLand,
	PersPlz
FROM tblPersonal
WHERE PersLand = 'd'
AND PersPlz LIKE '[3-5]%'
ORDER BY PersPlz DESC;
--oder
SELECT perstitel,
	PersVorname,
	PersNachname,
	PersLand,
	PersPlz
FROM tblPersonal
WHERE PersLand = 'd'
AND PersPlz BETWEEN 30000 AND 59999
ORDER BY PersPlz DESC;

--Aufgabe 2.10
SELECT perstitel,
	PersVorname,
	PersNachname,
	PersLand,
	PersPlz
FROM tblPersonal
WHERE PersLand = 'd'
AND PersPlz LIKE '[3-5]%'
ORDER BY PersPlz DESC, PersNachname ;

--Aufgabe 2.11
SELECT perstitel,
	PersVorname,
	PersNachname AS Name,
	PersLand,
	PersPlz AS PLZ
FROM tblPersonal
WHERE PersLand = 'd'
AND PersPlz LIKE '[3-5]%'
ORDER BY Plz DESC, Name DESC;

--Aufgabe 2.12
SELECT perstitel,
	PersVorname,
	PersNachname,
	PersAbteilung
FROM tblPersonal
WHERE PersAbteilung IN (10,35,40)
--oder
SELECT perstitel,
	PersVorname,
	PersNachname,
	PersAbteilung
FROM tblPersonal
WHERE PersAbteilung = 10
OR PersAbteilung = 35
OR PersAbteilung = 40

--Aufgabe 2.13
SELECT perstitel,
	PersVorname,
	PersNachname,
	PersAbteilung
FROM tblPersonal
WHERE PersAbteilung = 10
OR PersAbteilung = 35
OR PersAbteilung = 40
ORDER BY PersAbteilung, PersNachname;
 
--Aufgabe 3.1
SELECT TOP 3 perstitel,
	PersVorname,
	PersNachname,
	PersMonatsgehalt
FROM tblPersonal
ORDER BY PersMonatsgehalt DESC
--oder
SELECT perstitel,
	PersVorname,
	PersNachname,
	PersMonatsgehalt
FROM tblPersonal
ORDER BY PersMonatsgehalt DESC
OFFSET 0 ROWS FETCH FIRST 3 ROWS ONLY;

--Aufgabe 3.2
SELECT TOP 4 perstitel,
	PersVorname,
	PersNachname,
	PersMonatsgehalt
FROM tblPersonal
ORDER BY PersMonatsgehalt ASC;
--oder
SELECT perstitel,
	PersVorname,
	PersNachname,
	PersMonatsgehalt
FROM tblPersonal
ORDER BY PersMonatsgehalt ASC
OFFSET 0 ROWS FETCH FIRST 4 ROWS ONLY;

--Aufgabe 3.3
SELECT DISTINCT PersAbteilung
FROM tblPersonal;

--Aufgabe 3.4
SELECT perstitel,
	PersVorname,
	PersNachname
FROM tblPersonal
ORDER BY PersNachname DESC
OFFSET 5 ROWS;

--Aufgabe 3.5
SELECT perstitel,
	PersVorname,
	PersNachname
FROM tblPersonal
ORDER BY PersNachname DESC
OFFSET 5 ROWS FETCH NEXT 10 ROWS ONLY;










