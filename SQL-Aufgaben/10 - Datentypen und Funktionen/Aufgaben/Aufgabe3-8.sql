--Die folgenden Aufgaben beziehen sich auf die Tabelle dbo.tblPersonal in der Personal-Datenbank
USE Personal;

SELECT * FROM tblPersonal;

--Aufgabe 3
--Zeigen Sie von allen Angestellten den Nachnamen, den Vornamen und den Titel an. Wenn der Titel nicht bekannt ist, soll die Zeichenkette „ohne Titel“ angezeigt werden. Lösen Sie Aufgabe mit ISNULL und anschließend mit COALESCE.

--ISNULL
SELECT PersNachname, PersVorname, ISNULL(PersTitel, 'ohne Title') AS Title 
FROM tblPersonal;
--COALESCE
SELECT PersNachname, PersVorname, COALESCE(PersTitel, 'ohne Title') AS Title 
FROM tblPersonal;

--Aufgabe 4
--Zeigen Sie von allen Angestellten den Nachnamen, den Vornamen und den akademischen Grad an. Wenn der akademische Grad nicht bekannt ist, soll die Zeichenkette „Proletariat“ angezeigt werden, ansonsten der akademische Grad aus der Tabelle. Verwenden Sie IIF. 

--ISNULL
SELECT PersNachname, PersVorname, ISNULL(PersAkadGrad, 'Proletariat') AS [Akademische Grad] 
FROM tblPersonal;
--COALESCE
SELECT PersNachname, PersVorname, COALESCE(PersAkadGrad, 'Proletariat') AS [Akademische Grad] 
FROM tblPersonal;

--Aufgabe 5
--Zeigen Sie von allen Angestellten den Nachnamen, den Vornamen, den akademischen Grad und den Titel an. In einer weiteren Spalte soll ebenfalls der akademische Grad angezeigt werden. Falls dieser Wert unbekannt ist, soll stattdessen der Titel angezeigt werden. Falls auch der unbekannt ist, soll die Zeichenkette „Proletariat“ angezeigt werden.

--ISNULL
SELECT PersNachname, PersVorname, PersAkadGrad, PersTitel, ISNULL(PersAkadGrad, ISNULL(PersTitel, 'Proletariat')) AS [Akademische Grad / Title] 
FROM tblPersonal;
--COALESCE
SELECT PersNachname, PersVorname, COALESCE(PersAkadGrad, COALESCE(PersTitel, 'Proletariat')) AS [Akademische Grad / Title] 
FROM tblPersonal;

--Aufgabe 6
--Lassen Sie von allen Angestellten den Nachnamen, den Vornamen und das Geburtsdatum anzeigen. In einer weiteren Spalte soll angegeben werden, wie viele Tage der Geburtsmonat hatte.
???
SELECT PersNachname, PersVorname, PersGebDat,  DATEDIFF(DAY, REPLACE(PersGebDat, SUBSTRING(PersGebDat, 8, 2), 01), EOMONTH(PersGebDat)) AS [Zahl der Tage der GeburtsMonat] 
FROM tblPersonal;

--Aufgabe 7
--Lassen Sie von allen Angestellten den Nachnamen und den Vornamen mit einem Komma getrennt in einer Spalte anzeigen. In einer weiteren Spalte zeigen Sie den Titel und den akademischen Grad ebenfalls mit einem Komma getrennt an.
???
SELECT CONCAT(PersNachname, ', ', PersVorname) AS [Nachname, Vorname], 
IIF(PersTitel != NULL, CONCAT(PersTitel, ', ', PersAkadgrad), PersAkadgrad) AS [Title, AkGrad] 
FROM tblPersonal;


--Aufgabe 8
--Lassen Sie von allen Angestellten den Nachnamen und den Vornamen anzeigen. Zusätzlich soll die Spalte mit der PLZ in eine ganze Zahl umgewandelt werden. Falls die Konvertierung fehlschlägt, darf keine Fehlermeldung ausgegeben werden.
SELECT PersNachname, PersVorname, PersPlz, IIF(ISNUMERIC(PersPlz)=1, CONVERT(INT, PersPlz), '') AS [PLZ]
FROM tblPersonal;
