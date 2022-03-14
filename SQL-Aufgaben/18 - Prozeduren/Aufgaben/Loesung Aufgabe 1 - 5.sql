USE NordwindSQL;
GO
--Aufgabe 1.1
CREATE PROCEDURE usp_Kat5
AS
BEGIN
	SELECT a.Artikelname,
		a.Einzelpreis,
		k.Kategoriename
	FROM Artikel AS a
	INNER JOIN Kategorien AS k
	ON a.[Kategorie-Nr] = k.[Kategorie-Nr]
	WHERE k.[Kategorie-Nr] = 5;
END

EXEC usp_Kat5;
GO
--Aufgabe 1.2
CREATE PROCEDURE usp_Kat5_var
	@knr int
AS
BEGIN
	SELECT a.Artikelname,
		a.Einzelpreis,
		k.Kategoriename
	FROM Artikel AS a
	INNER JOIN Kategorien AS k
	ON a.[Kategorie-Nr] = k.[Kategorie-Nr]
	WHERE k.[Kategorie-Nr] = @knr;
END
GO

EXEC usp_Kat5_var 5;

--Aufgabe 1.3
SELECT * INTO ArtikelKop
FROM Artikel
GO
CREATE PROCEDURE usp_Plutz20
AS
BEGIN
	UPDATE ArtikelKop
	SET Einzelpreis *=  1.2
	WHERE [Lieferanten-Nr] = (
		SELECT [Lieferanten-Nr]
		FROM Lieferanten
		WHERE Firma LIKE 'Plutzer%'
	)
END
GO
SELECT * FROM ArtikelKop WHERE [Lieferanten-Nr] = 12;

--Aufgabe 1.3a
GO
ALTER PROCEDURE usp_Plutz20Proz
	@proz int
AS
BEGIN
	UPDATE ArtikelKop
	SET Einzelpreis *=  1 + CAST(1 as decimal(5,2))/100*@proz
	WHERE [Lieferanten-Nr] = (
		SELECT [Lieferanten-Nr]
		FROM Lieferanten
		WHERE Firma LIKE 'Plutzer%'
	)
END
GO
SELECT * FROM ArtikelKop WHERE [Lieferanten-Nr] = 12;

EXEC usp_Plutz20Proz 50;
GO
--Aufgabe 1.4
CREATE PROCEDURE usp_Billigartikel
	@preis as money
AS
BEGIN
	SELECT Artikelname, Einzelpreis
	FROM Artikel
	WHERE Einzelpreis < @preis;
END
GO

EXEC usp_Billigartikel 5;
GO
--Aufgabe 2
CREATE PROCEDURE proc_greetuser
	@name varchar(50)  = NULL
AS
BEGIN
	DECLARE @gruss varchar(100)
	DECLARE @zeit time = cast(getdate() AS time)
		SET @gruss=
		CASE 
			WHEN @zeit BETWEEN '07:00' AND '11:59' THEN 'Guten Morgen'
			WHEN @zeit BETWEEN '12:00' AND '17:59' THEN 'Guten Tag'
			WHEN @zeit BETWEEN '18:00' AND '22:00' THEN 'Guten Abend'
			ELSE 'Bitte nicht stören!'
		END
		IF @name IS NULL
		SELECT @gruss + ' ' + SYSTEM_USER;
		ELSE
		SELECT @gruss + ' ' + @name;
END
GO

EXEC proc_greetuser 'Gerwin';
EXEC proc_greetuser;


GO
--Aufgabe 3
CREATE PROCEDURE proc_GGT
	@zahl1 int,
	@zahl2 int
AS
BEGIN
	set @zahl1 = ABS(@zahl1);
	set @zahl2 = ABS(@zahl2);
	WHILE @zahl1 != @zahl2
	BEGIN
		IF @zahl1 > @zahl2
			SET @zahl1 -= @zahl2;
		ELSE
			SET @zahl2 -= @zahl1;
	END
	SELECT @zahl1;
END
GO

EXEC proc_GGT -28, 21;
GO
--Aufgabe 4
CREATE PROCEDURE usp_Fak
	@zahl int
AS
BEGIN
	DECLARE @ergebnis int = 1;
	DECLARE @zaehler int = 1;
	WHILE @zaehler <= @zahl
	BEGIN
		SET @ergebnis *=@zaehler;
		SET @zaehler+=1;
	END
	RETURN @ergebnis;
END	 
GO

DECLARE @ergebnis int;
EXEC @ergebnis=usp_fak 5;
SELECT @ergebnis;

--Aufgabe 5
USE TeachSQL;
GO

CREATE TABLE tblKunde 
(
	KundenNr varchar(20) primary key ,
	[Name] varchar(50),
	[Vorname] varchar(50),
	[Ort] varchar(30),
	[PLZ] char(5)
)
GO
--Naiver Ansatz
CREATE PROCEDURE proc_insert_new_customer
	@Name varchar(50),
	@Vorname varchar(50),
	@Ort varchar(30),
	@PLZ char(5)
AS
BEGIN
	--Knd = initialen und 1. Buchstabe Ort
	DECLARE @kdnr varchar(10)= LEFT(@name,1) + 
				LEFT(@vorname,1)+
				LEFT(@ort,1);
	--Wenn schon vorhanden, Zähler hinzufügen 
	IF @kdnr NOT IN (SELECT KundenNr FROM tblKunde)
		INSERT INTO tblKunde
		VALUES(@kdnr,@Name,@Vorname,@Ort,@PLZ);
	ELSE
	BEGIN
		DECLARE @lfdnr int =(
			SELECT COUNT(*) FROM tblKunde
			WHERE KundenNr LIKE @kdnr+'%')
		INSERT INTO tblKunde
		VALUES(@kdnr + '-'+CAST(@lfdnr AS varchar(5)),
			@Name,@Vorname,@Ort,@PLZ);
	END
END
EXEC proc_insert_new_customer 'Polzien','Bert','Leipzig','87654'
EXEC proc_insert_new_customer 'Pršll','Britta','Mainz','74654'
EXEC proc_insert_new_customer 'Portmann','Brigitte','Kšln','46345'
EXEC proc_insert_new_customer 'Huber','Alois','MŸnschen','83654'
EXEC proc_insert_new_customer 'Huber','Lise','MŸnchen','83354'
EXEC proc_insert_new_customer 'HŸbner','Ludwig','MŸnchen','83354'
EXEC proc_insert_new_customer 'Pracht','Bernd','Kšln','46345'
EXEC proc_insert_new_customer 'Preus','Bernd','Kšln','46345'
EXEC proc_insert_new_customer 'Huber','Alfons','MŸnschen','83654'

SELECT * FROM tblKunde;
DELETE FROM tblKunde
WHERE KundenNr = 'PBK-1'
GO
--While-SChleife
CREATE PROCEDURE proc_insert_new_customer1
	@Name varchar(50),
	@Vorname varchar(50),
	@Ort varchar(30),
	@PLZ char(5)
AS
BEGIN
	DECLARE @kdnr varchar(10)= LEFT(@name,1) + 
				LEFT(@vorname,1)+
				LEFT(@ort,1);
	DECLARE @zaehler int=1;
	WHILE @kdnr IN (SELECT * FROM tblKunde)
	BEGIN
		SET @kdnr = LEFT(@kdnr,3)+'-'+CAST(@zaehler AS varchar(5));
		SET @zaehler += 1;
	END
	INSERT INTO tblKunde
	VALUES (@kdnr,@Name,@Vorname,@Ort,@PLZ);
END
GO
EXEC proc_insert_new_customer1 'Polzien','Bert','Leipzig','87654'
EXEC proc_insert_new_customer1 'Pršll','Britta','Mainz','74654'
EXEC proc_insert_new_customer1'Portmann','Brigitte','Kšln','46345'
EXEC proc_insert_new_customer1'Huber','Alois','MŸnschen','83654'
EXEC proc_insert_new_customer1 'Huber','Lise','MŸnchen','83354'
EXEC proc_insert_new_customer1 'HŸbner','Ludwig','MŸnchen','83354'
EXEC proc_insert_new_customer1 'Pracht','Bernd','Kšln','46345'
EXEC proc_insert_new_customer1 'Preus','Bernd','Kšln','46345'
EXEC proc_insert_new_customer1 'Huber','Alfons','MŸnschen','83654'
DELETE FROM tblKunde
SELECT * FROM tblKunde

DELETE FROM tblKunde
WHERE KundenNr = 'PBK-1'

--Geplänkel
DECLARE @kdnr AS varchar(20) ='ABC-105542'
SELECT max( CAST(SUBSTRING(@kdnr,CHARINDEX('-',@kdnr)+1,len(@kdnr)) AS int))
--Max-Wert suchen
GO
ALTER PROCEDURE proc_insert_new_customer2
	@Name varchar(50),
	@Vorname varchar(50),
	@Ort varchar(30),
	@PLZ char(5)
AS
BEGIN
	DECLARE @kdnr varchar(10)= LEFT(@name,1) + 
				LEFT(@vorname,1)+
				LEFT(@ort,1);
	DECLARE @lfdnr int =0;
	SET @lfdnr=(
			SELECT max( CAST(SUBSTRING(kundennr,5,len(kundennr)) AS int))
			FROM tblKunde WHERE KundenNr LIKE @kdnr + '%'
		);
	IF @lfdnr >= 0
	BEGIN
		SET @kdnr = @kdnr + '-' + CAST(@lfdnr +1 AS varchar(5));
		
	END
	INSERT INTO tblKunde
	VALUES(@kdnr,@Name,@Vorname,@Ort,@PLZ)
END
EXEC proc_insert_new_customer2 'Polzien','Bert','Leipzig','87654'
EXEC proc_insert_new_customer2 'Pršll','Britta','Mainz','74654'
EXEC proc_insert_new_customer2'Portmann','Brigitte','Kšln','46345'
EXEC proc_insert_new_customer2'Huber','Alois','MŸnschen','83654'
EXEC proc_insert_new_customer2 'Huber','Lise','MŸnchen','83354'
EXEC proc_insert_new_customer2 'HŸbner','Ludwig','MŸnchen','83354'
EXEC proc_insert_new_customer1 'Pracht','Bernd','Kšln','46345'
EXEC proc_insert_new_customer2 'Preus','Bernd','Kšln','46345'
EXEC proc_insert_new_customer2 'Huber','Alfons','MŸnschen','83654'
SELECT * FROM tblKunde
DELETE FROM tblKunde
WHERE kundennr = 'PBK-1'
