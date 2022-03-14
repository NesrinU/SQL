USE JoinDB1;

SELECT *
FROM Kfz;

--Erstellen Sie jeweils eine geeignete Abfrage: 
--1. Wie viele Tage sind es noch bis zur n�chsten Hauptuntersuchung?
SELECT 
ID,
DATEDIFF(DAY, GETDATE(), HU) AS [N�chse HU]
FROM Kfz;

--2. Wie viele Personen fahren ein Kfz?
SELECT COUNT(Nachname) AS Person_KFZ
FROM Pers
WHERE KFZ IS NOT NULL;

--3. Wie viele Fahrzeuge wurden vor 2018 hergestellt?
SELECT COUNT(Baujahr) AS [Vor 2018]
FROM Kfz
WHERE Baujahr < 2018;

--4. Welche Modellnamen beginnen nicht mit einem A? 
SELECT Modell
FROM Kfz
WHERE Modell LIKE '[^a]%';

--5. Ermitteln Sie f�r jedes Fahrzeug das Datum der Erstzulassung (15. Juli des Baujahrs).
SELECT ID, Marke, Kennzeichen , 
CONCAT('15. Juli ', Baujahr) AS Erstzulassung
FROM Kfz;

--ODER
SELECT Kennzeichen , 
DATEFROMPARTS(Baujahr, 7, 15) AS Erszulassung
FROM Kfz;


--6. Welche Fahrzeuge m�ssen im kommenden Jahr zur Hauptuntersuchung?
SELECT 
ID, Kennzeichen, HU 
FROM Kfz
WHERE DATEDIFF(YEAR, GETDATE(), HU) = 1;

--ODER

SELECT 
ID, Kennzeichen, HU 
FROM Kfz
WHERE YEAR(HU) = 2022;

--7. Wie viele Marke/Modell-Kombinationen liegen vor?
SELECT COUNT(DISTINCT (Marke + Modell)) AS Kombinationen
FROM Kfz;
--ODER
SELECT Marke +' '+Modell AS Kombi, 
COUNT(DISTINCT (Marke +' '+Modell)) AS Kombinationen
FROM Kfz
GROUP BY Marke +' '+Modell;

--8. Wie viele Fahrzeuge sind nicht in Duisburg zugelassen?
SELECT COUNT(Kennzeichen)
FROM Kfz
WHERE Kennzeichen LIKE '[^DU]%';

--9. Wie viele Fahrzeuge wurden in welchem Jahr hergestellt? 
SELECT Baujahr, COUNT(ID)
FROM Kfz
GROUP BY Baujahr;

--10. Welche Personen haben keine symmetrische Postleitzahl?
SELECT Nachname, Vorname, PLZ 
FROM Pers
WHERE LEFT(PLZ,2) != REVERSE(RIGHT(PLZ, 2)) ;
--ODER
SELECT Nachname, Vorname, PLZ 
FROM Pers
WHERE PLZ != REVERSE(PLZ) ;

--11. Welches Baujahr hat der �lteste Audi?
SELECT Marke, MIN(Baujahr) AS Baujahr
FROM Kfz
WHERE Marke = 'Audi'
GROUP BY Marke;

--12. Welche Fahrzeuge haben im folgenden Monat Hauptuntersuchung?
SELECT 
ID, Kennzeichen, HU 
FROM Kfz
WHERE DATEDIFF(MONTH, GETDATE(), HU) = 1;

--13. Anzahl und durchschnittliche km-Zahl f�r jede Marke. 
SELECT
Marke, COUNT (Marke) AS Anzahl, AVG(gefahreneKM) AS [durchschnittliche km-Zahl]
FROM Kfz
GROUP BY Marke;

--14. In welchem Kreis sind wie viele Fahrzeuge zugelassen?
SELECT LEFT (Kennzeichen, 2) AS Kreis, COUNT(ID) AS Anzahl
FROM Kfz
GROUP BY LEFT (Kennzeichen, 2);

--ODER
SELECT LEFT (Kennzeichen, 2) AS Kreis, COUNT(LEFT (Kennzeichen, 2) ) AS Anzahl
FROM Kfz
GROUP BY LEFT (Kennzeichen, 2);

--15. Wie viele Fahrzeuge m�ssen in welchem Jahr ihre n�chste Hauptuntersuchung? 
SELECT YEAR(HU) AS HU, COUNT(ID) AS KFZ
FROM Kfz
GROUP BY YEAR(HU); 
