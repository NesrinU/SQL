--Aufgabe Schleifen
USE TeachSQL;
GO
--Erstellen Sie in der TeachSQL-Datenbank eine neue Tabelle ID_Tab. 
--Darin sollen die Spalten ID (integer) und U_ID (uniqueidentifier  Recherche!) vorhanden sein.
--Mittels einer Schleife sollen in die ID-Spalte alle Zweierpotenzen (1, 2, 4, 8, 16, 32, 64 etc.) 
--bis 2 hoch 15 eingefügt werden. In die U_ID-Spalte sollen automatisch generierte uniqueidentifier-Werte
--eingefügt werden.

CREATE TABLE ID_Tab 
		(
			ID		INTEGER, 
			U_ID	UNIQUEIDENTIFIER	DEFAULT NEWID()
		);
GO

DECLARE @MaxID INT;
SET @MaxID = 32768;
DECLARE @ID INT;

SET @ID = 1;
WHILE @ID <= @MaxID
	BEGIN
	INSERT INTO ID_Tab(ID) VALUES(@ID);
	SET @ID = @ID  * 2;
	END;
GO

DECLARE @ID INTEGER = 0;
WHILE @ID < 16
	BEGIN
	INSERT INTO ID_Tab (ID)	VALUES (POWER(2,@ID));
	SET @ID = @ID + 1;
	END;
GO

SELECT * FROM ID_Tab;


-- Aufgabe 2
CREATE TABLE FooBar
(
       ID int,
	   mod7 VARCHAR(3),
	   mod3 VARCHAR(3),
);
GO

DECLARE @ID INT = 1;
DECLARE @mod3 NVARCHAR(3) = '';
DECLARE @mod7 NVARCHAR(3) = '';

WHILE @ID <= 100
      BEGIN


	       IF @ID % 3 = 0
	       SET @mod3 = 'bar'
		   ELSE
		   SET @mod3 = NULL;

           IF @ID % 7 = 0
	       SET @mod7 = 'foo'
		   ELSE 
		   SET @mod7 = NULL;

           INSERT INTO FooBar (ID, mod3, mod7)
           VALUES (@ID, @mod3, @mod7);

           SET @ID += 1;
       END;
GO

DECLARE @i INT = 1;
WHILE @i <= 100
BEGIN
    INSERT INTO FooBar
    VALUES (@i, IIF(@i % 7 = 0, 'foo', NULL), IIF(@i % 3 = 0, 'bar', NULL));
    SET @i += 1;
END

SELECT * FROM FooBar;

-- Aufgabe 2b
CREATE TABLE FooBar2
(
	ID	INT,
	Typ VARCHAR(6)
);

DECLARE @ID INT = 1;
WHILE @ID < 101
	BEGIN
	IF @ID%7 !=0 AND @ID%3 !=0
		BEGIN
			INSERT INTO FooBar2 (ID,Typ)
			VALUES (@ID, 'dumb')
		END
	ELSE
	IF @ID%7 =0 AND @ID%3!=0
		BEGIN
			INSERT INTO FooBar2 (ID,Typ)
			VALUES (@ID, 'Foo')
		END
	ELSE
	IF @ID%3 =0 AND @ID%7!=0
		BEGIN
			INSERT INTO FooBar2 (ID,Typ)
			VALUES (@ID, 'Bar')
		END
	ELSE
		BEGIN
			INSERT INTO FooBar2 (ID,Typ)
			VALUES (@ID,'FooBar')
		END
		SET @ID = @ID + 1;
	END;

SELECT * FROM FooBar2;
GO


DECLARE @s VARCHAR(6);
DECLARE @i INT = 1;
WHILE @i <= 100
BEGIN
    SET @s = '';
    IF @i % 7 = 0
         SET @s = 'foo';
    IF @i % 3 = 0
         SET @s += 'bar';

 

    INSERT INTO FooBar
    VALUES (@i, IIF(@s = '', 'dumb', @s));

 

    SET @i += 1;
END

DECLARE @counter INT = 1, @mod7 VARCHAR(3), @mod3 VARCHAR(3);
WHILE (@counter <= 100)
BEGIN
    SET @mod7 = IIF(@counter % 7 = 0,'foo',NULL)
    SET @mod3 = IIF(@counter % 3 = 0,'bar',NULL)

 

    INSERT INTO FooBar
    VALUES (@counter, COALESCE(@mod7+@mod3, @mod7, @mod3, 'dumb'));



-- Aufgabe 3
CREATE TABLE Dumb
	(
		ID			INT,
		[Status]	VARCHAR(6),
		minus_50	INT,
		Quotient	FLOAT
	);

DECLARE @ID INT = 1;
DECLARE @status VARCHAR(6) = 'dumb';
DECLARE @minus_50 INT = 1;
DECLARE @Quotient FLOAT;

WHILE @ID < 101
BEGIN
	IF @ID%3=0 AND @ID%7=0
		SET @status = 'foobar'
		ELSE IF @ID%7=0
			SET @status = 'foo'
				ELSE IF @ID%3=0
					SET @status = 'bar'
						ELSE
							SET @status = 'dumb';

	SET @minus_50 = @ID;
	IF @ID%5=0
		SET	@minus_50 = @ID - 50;

	BEGIN TRY
		SET @Quotient = CAST(@ID AS FLOAT)/@minus_50;
	END TRY
	BEGIN CATCH
		SET @status = 'D_by_Z';
		SET @Quotient = NULL;
	END CATCH;

	INSERT INTO DUMB
	VALUES(@ID,@status,@minus_50,@Quotient);

	SET @ID = @ID+1
END;

SELECT * FROM Dumb;

 

    SET @counter += 1;
END


