-- Aufgabe 1
USE Container;
GO
SELECT * FROM tbl_Container;
GO

-- Aufgabe 1.1

CREATE OR ALTER FUNCTION fn_contSurface (@ContID INT)
RETURNS INT
AS
BEGIN
	DECLARE @SurfaceValue INT;
	SELECT @SurfaceValue = ((2 * C.Length * C.Width) + (2 * C.Length * C.Height) + (2 * C.Width * C.Height))
	FROM 
		tbl_Container AS C
	WHERE C.ContID = @ContID;
	RETURN @SurfaceValue;
END;
GO

SELECT dbo.fn_contSurface(3);
GO

-- Aufgabe 1.2
CREATE OR ALTER FUNCTION fn_squareMMtoM (@mm FLOAT)
RETURNS FLOAT
AS
BEGIN
	-- SELECT @mm = @mm / 1000000
	RETURN @mm / 1000000;
END;
GO 

SELECT dbo.fn_squareMMtoM (dbo.fn_contSurface(3));
GO

-- Aufgabe 1.3
CREATE OR ALTER FUNCTION fn_squareMtoMM (@m FLOAT)
RETURNS FLOAT
AS
BEGIN
	RETURN @m * 1000000;
END;
GO

SELECT dbo.fn_squareMtoMM(60);
GO

-- Aufgabe 1.4
CREATE OR ALTER FUNCTION fn_superConverter (@m float, @dir nvarchar(3))
RETURNS FLOAT
AS
BEGIN
	IF @dir = 'mm'   --> meter zu mm
		RETURN dbo.fn_squareMtoMM(@m);
	ELSE IF @dir = 'm' --> mm zu meter
		RETURN dbo.fn_squareMMtoM(@m);
	RETURN NULL;
END;
GO


SELECT dbo.fn_superConverter(50000,'krabbe');
GO


-- Aufgabe 2)
USE pro_angSQL;
GO


CREATE OR ALTER FUNCTION ProjektMitarbeiterZeit(@anr INT)
RETURNS TABLE 
AS RETURN
	SELECT
	pa.proz_arb,
	a.a_nr,
	a.[name], 
	p.p_beschr
	FROM pro_ang pa
	INNER JOIN pro p ON p.p_nr = pa.p_nr
	INNER JOIN ang a ON a.a_nr = pa.a_nr
	WHERE @anr = pa.a_nr;
GO

SELECT * FROM dbo.ProjektMitarbeiterZeit(198);

DROP FUNCTION ProjektMitarbeiterZeit;
GO

-- Etwas andersmit LEFT JOIN 

CREATE OR ALTER FUNCTION ProjektMitarbeiterZeit2(@anr INT)
RETURNS TABLE 
AS RETURN
	SELECT
	pa.proz_arb,
	a.a_nr,
	a.[name],
	p.p_beschr
	FROM ang a
	LEFT JOIN pro_ang pa ON a.a_nr = pa.a_nr
	LEFT JOIN pro p ON pa.p_nr = p.p_nr
	WHERE a.a_nr = @anr;
GO

SELECT * FROM dbo.ProjektMitarbeiterZeit2(112);

DROP FUNCTION ProjektMitarbeiterZeit2;
GO

-- Aufgabe 3)

/*
USE Personal;
GO
CREATE FUNCTION trimmer()
RETURNS @trimmed TABLE
	(
		Vorname varchar(50),
		Nachname varchar(59),
		Strasse varchar(50),
		Plz varchar(6),
		Ort varchar(50)
	)
AS
BEGIN
	INSERT @trimmed
	SELECT	LTRIM(RTRIM(p.Vorname)), 
			LTRIM(RTRIM(p.nachname)), 
			LTRIM(RTRIM(p.Strasse)), 
			p.PLZ, 
			LTRIM(RTRIM(p.Ort)) 
	FROM personen p;
	RETURN;
END;
GO
SELECT * FROM dbo.trimmer();

MERGE INTO Personen AS target_table
USING dbo.trimmer() AS source_table
ON target_table.Nachname LIKE '%'+source_table.Nachname+'%' AND target_table.Plz = source_table.Plz
WHEN MATCHED THEN
UPDATE SET Nachname = source_table.Nachname, 
	Vorname = source_table.Vorname, 
	Strasse = source_table.Strasse,
	Ort = source_table.Ort;


GO
*/

CREATE FUNCTION trimString(@input VARCHAR(MAX))
RETURNS VARCHAR(MAX)
AS
BEGIN
	RETURN LTRIM(RTRIM(@input));
END;
GO

SELECT LEN(LTRIM(RTRIM('    Blabla        ')));


--3.2
SELECT dbo.trimString(p.Vorname), 
	dbo.trimString(p.Nachname),
	dbo.trimString(p.Strasse),
	dbo.trimString(p.PLZ),
	dbo.trimString(p.Ort)
FROM personen p;

SELECT * FROM personen;


--3.3
UPDATE Personen SET
	Vorname = dbo.trimString(Vorname),
	Nachname = dbo.trimString(Nachname),
	Strasse = dbo.trimString(Strasse),
	PLZ = dbo.trimString(PLZ),
	Ort = dbo.trimString(Ort);

SELECT * FROM Personen;


SELECT dbo.fn_Trim(Vorname) Vorname ,dbo.fn_Trim(Nachname) Nachname ,dbo.fn_Trim(Strasse)Strasse,dbo.fn_Trim(PLZ)PLZ,dbo.fn_Trim(Ort)Ort
INTO Personen2
FROM personen

 

DROP TABLE personen

 

SELECT * INTO Personal.dbo.Personen FROM Personal.dbo.personen2

 

DROP TABLE Personen2