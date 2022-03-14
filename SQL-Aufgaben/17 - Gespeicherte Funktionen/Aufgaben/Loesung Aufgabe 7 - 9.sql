--Aufgabe 7

--Die Aufgabe bezieht sich auf Tabellen in der Datenbank WAWI
--1.	Erstellen Sie eine benutzerdefinierte Funktion fnTag. 
--Diese Funktion soll vom aktuellen Datum den Wochentag in der Kurzform zurückgeben (Mo, Di, etc.). 
--Wählen Sie einen passenden Rückgabetyp.
USE WAWI_BASIS;
GO

CREATE OR ALTER FUNCTION fnTag()
RETURNS CHAR(2)
AS
BEGIN 
	RETURN  DATENAME(DW, GETDATE());
END;
GO

SELECT dbo.fnTag();
GO

-- andere Möglichkeit
CREATE OR ALTER FUNCTION fnTag_2()
RETURNS CHAR(10)
AS
BEGIN
	DECLARE @var CHAR(10);
	SET @var = SUBSTRING(DATENAME(DW, GETDATE()), 0, 3);
	RETURN @var;
END;
GO

SELECT dbo.fnTag_2();
GO

-- andere Möglichkeit
CREATE OR ALTER FUNCTION fnTag_3()
RETURNS CHAR(2)
AS
BEGIN
	DECLARE @var CHAR(10);
	SET @var = FORMAT(GETDATE(), 'ddd');
	RETURN @var;
END;
GO

SELECT dbo.fnTag_3();
GO


--2.	Ändern Sie diese Funktion so, dass ein Datum als Parameter übergeben werden muss.
CREATE OR ALTER FUNCTION fnTag_4(@datum DATE)
RETURNS CHAR(2)
AS
BEGIN 
	RETURN  DATENAME(DW, @datum);
END;
GO

SELECT dbo.fnTag_4('07.03.1978');
GO


--Aufgabe 8
--Die Aufgabe bezieht sich auf Tabellen in der Datenbank pro_angSQL
--1.	Erstellen Sie eine Tabellenwertfunktion „fnProjektleiter“. 
--Diese Funktion soll eine Tabelle erstellen, die die a_nr des Angestellten, 
--den Namen des Angestellten und die Projektbeschreibungen der Projekte, die der Angestellte leitet, anzeigt.
USE pro_angSQL;
GO

CREATE OR ALTER FUNCTION fnProjektleiter(@angNr INT)
RETURNS TABLE
AS
RETURN 
	SELECT a.a_nr, a.name, p.p_beschr
	FROM ang a
	LEFT JOIN pro p
	ON a.a_nr = p.p_leiter
	WHERE a.a_nr = @angNr;
GO

SELECT * FROM dbo.fnProjektleiter(117);
SELECT * FROM dbo.fnProjektleiter(112);
SELECT * FROM dbo.fnProjektleiter(307);



--Aufgabe 9
--Die Aufgabe bezieht sich auf Tabellen in der Datenbank NordwindSQL.
--1.	Erstellen Sie eine Funktion „fnBestellSumme“. Diese Funktion soll eine Bestellnummer 
--als Parameter entgegennehmen. Die Funktion soll die Bestellsumme zurückgeben. 
--Dazu müssen zuerst die Preise der einzelnen Posten errechnet und dann aufsummiert werden.
USE NordwindSQL;
GO

CREATE OR ALTER FUNCTION fn_Bestellsumme(@bstnr INT)
RETURNS REAL
AS
BEGIN
	DECLARE @summe REAL;

	-- hier ausrechnen
	SELECT @summe = SUM(Einzelpreis * Anzahl - ((Einzelpreis * Anzahl * Rabatt))) 
	FROM Bestelldetails
	WHERE @bstnr = [Bestell-Nr];

	-- hier zurückgeben
	RETURN @summe;
END;
GO

SELECT dbo.fn_Bestellsumme(10248);
SELECT dbo.fn_Bestellsumme(10254);
GO

-- alternativ
CREATE OR ALTER FUNCTION fn_Bestellsumme_2(@bstnr INT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @summe FLOAT;

	-- hier ausrechnen
	SELECT @summe = ROUND(SUM(Einzelpreis * Anzahl * (1 - Rabatt)), 2) 
	FROM Bestelldetails
	WHERE @bstnr = [Bestell-Nr];

	-- hier zurückgeben
	RETURN @summe;
END;
GO

SELECT dbo.fn_Bestellsumme_2(10248);
SELECT dbo.fn_Bestellsumme_2(10254);
SELECT dbo.fn_Bestellsumme_2(10258);
GO

SELECT * FROM Bestelldetails;
GO

--2.	Erstellen Sie eine Tabellenwertfunktion, die für einen Kunden dessen Bestellungen 
--mit der jeweiligen Bestellsumme zurückgibt. In der zurückgegebenen Tabelle sollen die Bestellnummer, 
--das Bestelldatum, der Kundenname, der Name des Sachbearbeiters und natürlich die Bestellsumme enthalten sein.

CREATE OR ALTER FUNCTION fn_BestSummeUndSachbearbeiter (@kdcode NVARCHAR(5))
RETURNS @tab TABLE
		-- wie soll diese Tabelle aussehen?
		(
			Bestellnummer INT,
			Bestelldatum  DATETIME,
			Kundenname	  NVARCHAR(50),
			Sachbearbeiter NVARCHAR(50),
			Bestellsumme  MONEY
		)
AS
BEGIN
	INSERT INTO @tab
	SELECT b.[Bestell-Nr], b.Bestelldatum, k.Firma, p.Vorname + ' ' + p.Nachname,
			dbo.fn_Bestellsumme_2(b.[Bestell-Nr])
	FROM Bestellungen b
	INNER JOIN Kunden k
	ON k.[Kunden-Code] = b.[Kunden-Code]
	INNER JOIN Personal p
	ON p.[Personal-Nr] = b.[Personal-Nr]
	WHERE k.[Kunden-Code] = @kdcode;
	RETURN;
END;
GO

SELECT * FROM fn_BestSummeUndSachbearbeiter('ALFKI');

