--Aufgabe 7
--Die Aufgabe bezieht sich auf Tabellen in der Datenbank WAWI
--1.	Erstellen Sie eine benutzerdefinierte Funktion fnTag. Diese Funktion soll vom aktuellen Datum den Wochentag in der Kurzform zurückgeben (Mo, Di, etc.). Wählen Sie einen passenden Rückgabetyp.
--2.	Ändern Sie diese Funktion so, dass ein Datum als Parameter übergeben werden muss. Finden Sie mithilfe dieser Funktion heraus, an welchem Wochentag Sie geboren wurden, bzw. an welchem Wochentag sie den nächsten Geburtstag modulo 10 gleich 0 haben.



--Aufgabe 8
--Die Aufgabe bezieht sich auf Tabellen in der Datenbank pro_angSQL
USE pro_angSQL;

--1.	Erstellen Sie eine Tabellenwertfunktion „fnProjektleiter“. Diese Funktion soll eine Tabelle erstellen, die die a_nr des Angestellten, den Namen des Angestellten und die Projektbeschreibungen der Projekte, die der Angestellte leitet, anzeigt.
CREATE FUNCTION fnProjektleiter(@a_nr INT)
RETURNS TABLE
AS
RETURN 
	SELECT ang.a_nr,ang.name, pro.p_beschr 
	FROM ang
	INNER JOIN pro_ang
	ON ang.a_nr = pro_ang.a_nr
	INNER JOIN pro
	ON pro_ang.p_nr = pro.p_nr AND ang.a_nr = pro.p_leiter
	WHERE ang.a_nr = @a_nr;

SELECT * FROM dbo.fnProjektleiter(307)
--Aufgabe 9
--Die Aufgabe bezieht sich auf Tabellen in der Datenbank NordwindSQL.
USE NordwindSQL;

SELECT * FROM Artikel;
SELECT * FROM Bestelldetails;
SELECT * FROM Bestellungen;
SELECT * FROM Kunden;
SELECT * FROM Lieferanten;
SELECT * FROM Personal;

--1.	Erstellen Sie eine Funktion „fnBestellSumme“. Diese Funktion soll eine Bestellnummer als Parameter entgegennehmen. Die Funktion soll die Bestellsumme zurückgeben. Dazu müssen zuerst die Preise der einzelnen Posten errechnet und dann aufsummiert werden.

CREATE ALTER FUNCTION fnBestellSumme(@bestellnummer INT)
RETURNS TABLE
AS
RETURN
	WITH Sum_Artikel AS (SELECT Bestelldetails.[Bestell-Nr], ((Einzelpreis*Anzahl)-(Einzelpreis*Anzahl*Rabatt)) AS Art FROM Bestelldetails WHERE Bestelldetails.[Bestell-Nr] = @bestellnummer)
	SELECT  Bestelldetails.[Bestell-Nr], SUM (Art) AS Sum_Bestellung 
	FROM Bestelldetails 
	INNER JOIN Sum_Artikel
	ON Sum_Artikel.[Bestell-Nr] = Bestelldetails.[Bestell-Nr]
	GROUP BY Bestelldetails.[Bestell-Nr]
	
SELECT * FROM dbo.fnBestellSumme(10248)

--2.	Erstellen Sie eine Tabellenwertfunktion, die für einen Kunden dessen Bestellungen mit der jeweiligen Bestellsumme zurückgibt. In der zurückgegebenen Tabelle sollen die Bestellnummer, das Bestelldatum, der Kundenname, der Name des Sachbearbeiters und natürlich die Bestellsumme enthalten sein.

CREATE FUNCTION fnKun_Best(@kunden_code)
RETURNS @tabelle TABLE (Bestellnummer INT, 
				Bestelldatum DATE, 
				Kundenname nvarchar(max),
				Sachbearbeiter nvarchar(max),
				Bestellsumme INT)
AS
BEGIN
	INSERT INTO @tabelle
	SELECT ang.name, a.name, b.name
	FROM ang
	LEFT JOIN angas a 
	ON ang.vorg= a.a_nr
	LEFT JOIN angAS b 
	on ang.a_nr= b.vorg
	WHERE ang.a_nr= @anr
	RETURN
	END;

SELECT * FROM dbo.fnAngData(205);
