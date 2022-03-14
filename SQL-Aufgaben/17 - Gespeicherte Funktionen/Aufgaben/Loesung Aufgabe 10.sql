-- Aufgabe 10
USE ÜDB;
GO


-- 10.1
-- RAND() in Funktionen wird nicht funktionieren
-- Behelf: View für RAND() basteln





CREATE VIEW vw_Zufall AS
SELECT RAND() AS Zufallszahl;
GO

SELECT * FROM vw_Zufall;
GO


CREATE OR ALTER FUNCTION fn_Random(@nachkommastellen INT)
RETURNS REAL
AS
	BEGIN
		DECLARE @zufallszahl REAL = 
			(
			SELECT Zufallszahl
			FROM vw_Zufall
			);

		RETURN ROUND(@zufallszahl, @nachkommastellen);
	END;
GO

-- test:
SELECT dbo.fn_Random(1);
GO

-- Vergin'sche Lösung
CREATE OR ALTER FUNCTION fn_Random(@länge INT)
RETURNS FLOAT
AS
    BEGIN
        RETURN ROUND((SELECT Zufallszahl FROM vw_Zufall), @länge)
    END;
GO


SELECT dbo.fn_Random(4);
GO


-- 10.2
CREATE OR ALTER FUNCTION fn_Random_Range(@min INT, @max INT, @nachkommastellen INT)
RETURNS FLOAT
AS
	BEGIN

		-- Range richtig herum?
		IF @min > @max
			BEGIN
				DECLARE @temp DECIMAL = @min;
				SET @min = @max;
				SET @max = @temp;
			END
		
		-- Zufallszahl erzeugen
		DECLARE @rangeMax DECIMAL = @max - @min;
		DECLARE @zufallszahl FLOAT = 
			(
				SELECT Zufallszahl
				FROM vw_Zufall
			) * @rangeMax;
		RETURN ROUND(@zufallszahl + @min, @nachkommastellen);
	END;
GO






-- testen:
SELECT dbo.fn_Random_Range(-200, 300, 5);




GO

CREATE OR ALTER FUNCTION fn_Random_Range(@bereich1 INT, @bereich2 INT)
RETURNS REAL
AS
BEGIN
    DECLARE @zahl REAL;
    DECLARE @zahl2 REAL;
    SET @zahl = (SELECT Zufallszahl FROM vw_Zufall);
    SET @zahl2 = @zahl * (@bereich2-@bereich1)+@bereich1;
RETURN @zahl2
END
GO


CREATE TABLE Zufallszahlen
(
	Zufallszahl DECIMAL
);

DECLARE @laufindex INT = 0;

WHILE @laufindex < 100
	BEGIN
		INSERT INTO Zufallszahlen
		SELECT dbo.fn_Random_Range(0, 99, 3);
		SET @laufindex += 1;
	END;

SELECT * FROM Zufallszahlen
ORDER BY Zufallszahl;

TRUNCATE TABLE Zufallszahlen;
GO

-- 10.3
-- keine Lösung gefunden
-- Problem: kein THROW in Funktionen möglich
-- Behelf: DECLARE @zahl INT = CAST('Hallo Welt' AS INT);

CREATE OR ALTER FUNCTION fn_Random_Range(@min INT, @max INT, @nachkommastellen INT)
RETURNS FLOAT
AS
	BEGIN


		-- Nachkommastellen prüfen
		IF @nachkommastellen < 0 OR @nachkommastellen > 7
			DECLARE @zahl INT = CAST('Hallo Welt' AS INT);

		-- Range richtig herum?
		IF @min > @max
			BEGIN
				DECLARE @temp DECIMAL = @min;
				SET @min = @max;
				SET @max = @temp;
			END
		
		-- Zufallszahl erzeugen
		DECLARE @rangeMax DECIMAL = @max - @min;
		DECLARE @zufallszahl FLOAT = 
			(
				SELECT Zufallszahl
				FROM vw_Zufall
			) * @rangeMax;
		RETURN ROUND(@zufallszahl + @min, @nachkommastellen);
	END;
GO

SELECT dbo.fn_Random_Range(-10, 10, 10);



-- 10.4 Semineth
GO
CREATE VIEW vw_getRANDValue
AS
SELECT RAND() AS Value;

 

GO
CREATE OR ALTER FUNCTION fn_randRange(@min FLOAT, @max FLOAT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @number FLOAT = (SELECT Value FROM vw_getRANDValue);
    RETURN @min+(@max - @min)*@number;
END;
GO


 

GO
CREATE OR ALTER FUNCTION fn_damnBigRandom()
RETURNS DECIMAL(38,28)
AS
BEGIN
    DECLARE @MAX_INT FLOAT = POWER(2.0,31)-1;            --     2.147.483.647 --
    DECLARE @MIN_INT FLOAT = POWER(-2.0,31);            --    -2.147.483.648 --
    DECLARE @leftPart DECIMAL(38,28);
    SET @leftPart = CONVERT(DECIMAL(38,28), dbo.fn_randRange(@MIN_INT, @MAX_INT - 1));
    DECLARE @tail DECIMAL(38,28);
    SET @tail = CONVERT(DECIMAL(38,28), dbo.fn_randRange(0, 1));
    DECLARE @damnBigRandom DECIMAL(38,28);
    SET @damnBigRandom = @leftPart + @tail;
    RETURN @damnBigRandom;
END;
GO


SELECT dbo.fn_damnBigRandom();
