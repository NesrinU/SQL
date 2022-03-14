-- Aufgabe 4)
USE TeachSQL;
GO


--Aufgabe 4

CREATE OR ALTER FUNCTION fn_ggt (@zahl1 int, @zahl2 int )
RETURNS int
AS 
	BEGIN 
		DECLARE @temp int = 0;
		
		WHILE @zahl1 % @zahl2 !=0
		BEGIN
			SET @temp = @zahl1 % @zahl2;
			SET @zahl1 = @zahl2;
			SET @zahl2 = @temp;
		END 
		
	RETURN @zahl2;
END;
GO

SELECT dbo.fn_ggt (42, 70);
GO


-- mit Rekursion
CREATE OR ALTER FUNCTION fn_GGT_rec(@a int, @b int)
RETURNS INT
AS
BEGIN
	IF @a = @b
		RETURN @a;
	ELSE
		BEGIN
			IF @a > @b
				RETURN dbo.fn_GGT_rec(@a - @b, @b);
			ELSE
				RETURN dbo.fn_GGT_rec(@b - @a, @a);
		END
	RETURN NULL;
END;
GO

SELECT dbo.fn_GGT_rec(105, 42);
GO

-- Aufgabe 5)
CREATE OR ALTER FUNCTION KGV_ZWEIER_ZAHLEN (@ZAHL INT, @ZAHL2 INT)
RETURNS INT
BEGIN
	DECLARE @KGV INT
	SET @KGV = @ZAHL * @ZAHL2 / dbo.fn_ggt(@ZAHL,@ZAHL2);
RETURN @KGV
END;
GO
SELECT dbo.KGV_ZWEIER_ZAHLEN(12,15);
GO

-- Aufgabe 6)
GO
CREATE OR ALTER FUNCTION fn_Between(@zahl1 FLOAT , @zahl2 FLOAT, @zahl3 FLOAT)
RETURNS nvarchar(5)
BEGIN
IF @zahl3>@zahl1 AND @zahl3<@zahl2
    BEGIN
    RETURN 'TRUE'
    END
RETURN 'FALSE'
END
GO



CREATE OR ALTER FUNCTION fn_Between(@z1 FLOAT, @z2 FLOAT, @z3 FLOAT) 
RETURNS BIT 
AS 
BEGIN 
	IF (@z3 >= @z1 and @z3 <= @z2) OR
	(@z3 <= @z1 and @z3 >= @z2) 
		RETURN 1;
	RETURN 0;
END 
go

--Alternativ 
SELECT IIF (@z3 BETWEEN @z2 AND @z3, 1, 0);

SELECT dbo.fn_Between(5,2,3);
