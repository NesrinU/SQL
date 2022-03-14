--Die folgenden Aufgaben beziehen sich auf die Tabelle dbo.tblPersonal in der Personal-Datenbank
USE Personal;

--Aufgabe 4
--Erstellen Sie eine Abfrage, die Titel, Vorname und Nachname anzeigt.
SELECT PersTitel, PersVorname, PersNachname
FROM tblPersonal;

SELECT *
FROM tblPersonal;

--Aufgabe 5 (mehrere Bedingungen)
--Ergänzen Sie jeweils die Abfrage aus Aufgabe 4 mit den folgenden Bedingungen. Lassen Sie dabei zusätzlich die Spalten, die in den Bedingungen verwendet werden anzeigen, damit Sie die Ergebnisse besser überprüfen können.
--1.	Es sollen nur noch die Daten der Doktoren angezeigt werden.
SELECT PersTitel, PersVorname, PersNachname, PersAkadGrad
FROM tblPersonal
WHERE PersAkadGrad = 'dr.';

--2.	Es sollen nur noch die weiblichen Angestellten angezeigt werden.
SELECT PersTitel, PersVorname, PersNachname, PersGeschlecht
FROM tblPersonal
WHERE PersGeschlecht = 1;

--3.	Es sollen nur noch die Angestellten aus Abteilung 40 angezeigt werden.
SELECT PersTitel, PersVorname, PersNachname, PersAbteilung
FROM tblPersonal
WHERE PersAbteilung = 40;

--4.	Es sollen nur noch die weiblichen Angestellten aus Abteilung 40 angezeigt werden.
SELECT PersTitel, PersVorname, PersNachname, PersAbteilung, PersGeschlecht
FROM tblPersonal
WHERE PersAbteilung = 40 AND PersGeschlecht = 1;

--5.	Es sollen alle Angestellten aus den Abteilungen 40 und 55 angezeigt werden.
SELECT PersTitel, PersVorname, PersNachname, PersAbteilung
FROM tblPersonal
WHERE PersAbteilung = 40 OR PersAbteilung = 55;

--6.	Es sollen alle Angestellten, die keinen Titel haben angezeigt werden.
SELECT PersTitel, PersVorname, PersNachname
FROM tblPersonal
WHERE PersTitel IS NULL;

--7.	Es sollen alle Angestellten angezeigt werden, die noch beschäftigt sind.
SELECT PersTitel, PersVorname, PersNachname, PersAustritt
FROM tblPersonal
WHERE PersAustritt IS NULL;

--8.	Es sollen alle österreichischen Angestellten angezeigt werden, deren PLZ mit einer 8 beginnt
SELECT PersTitel, PersVorname, PersNachname, PersLand, PersPlz
FROM tblPersonal
WHERE PersLand = 'A' AND PersPlz LIKE '8%';

--9.	Es sollen alle deutschen Angestellten aus dem PLZ-Bereich 3-5 angezeigt werden. Das Ergebnis soll nach PLZ absteigend sein.
SELECT PersTitel, PersVorname, PersNachname, PersLand, PersPlz
FROM tblPersonal
WHERE PersLand = 'D' AND PersPlz LIKE '[3-5]%'
ORDER BY PersPlz DESC;

--10.	Erweitern Sie die vorige Abfrage so, dass innerhalb einer PLZ die Angestelltennamen aufsteigend sortiert sind.
SELECT PersTitel, PersVorname, PersNachname, PersLand, PersPlz
FROM tblPersonal
WHERE PersLand = 'D' AND PersPlz LIKE '[3-5]%'
ORDER BY PersPlz;

--11.	Ändern Sie die vorherige Abfrage so, dass innerhalb einer PLZ die Angestelltennamen absteigend sortiert sind. Vergeben Sie anschließend Aliasnamen für die PLZ und den Angestelltennamen. Verwenden Sie dann diese Aliasnamen in der Sortierung.


--12.	Es sollen alle Angestellten aus den Abteilungen 10, 35 und 40 angezeigt werden.
--13.	Ändern Sie die vorherige Abfrage so, dass nach Abteilungsnummern aufsteigend und Angestelltennamen aufsteigend sortiert wird.

--Aufgabe 6 (Verschiedenes)
--1.	Zeigen Sie die 3 Angestellten mit den höchsten Gehältern an.
SELECT TOP 3
PersTitel, PersVorname, PersNachname, PersMonatsgehalt
FROM tblPersonal
ORDER BY PersMonatsgehalt DESC;

--2.	Zeigen Sie die 4 Angestellten, die am wenigsten verdienen.
SELECT TOP 4
PersTitel, PersVorname, PersNachname, PersMonatsgehalt
FROM tblPersonal
ORDER BY PersMonatsgehalt ASC;

--3.	Zeigen Sie alle Abteilungen an. Sorgen Sie dafür, dass jede Abteilung nur einmal vorkommt.
SELECT DISTINCT PersAbteilung
FROM tblPersonal;

--4.	Zeigen Sie die Angestellten nach Name absteigend sortiert an. Es sollen die ersten 5 Angestellten übersprungen werden.
SELECT
PersTitel, PersVorname, PersNachname
FROM tblPersonal
ORDER BY PersNachname DESC
OFFSET 5 ROWS;

--5.	Erweitern Sie die vorherige Abfrage so, dass nur 10 Angestellte angezeigt werden. Testen Sie, ob sich das Ergebnis ändert, wenn Sie First oder NEXT verwenden.
SELECT
PersTitel, PersVorname, PersNachname
FROM tblPersonal
ORDER BY PersNachname DESC
OFFSET 5 ROWS FETCH FIRST 10 ROWS ONLY;
