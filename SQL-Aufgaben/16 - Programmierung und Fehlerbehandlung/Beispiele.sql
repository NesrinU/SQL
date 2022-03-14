-- Beispiele Programmierung

-- Variablen deklarieren
DECLARE @zahl INT = 43;


-- IF - ELSE
IF @zahl = 42
	BEGIN
		PRINT 'Zahl ist richtig';
	END
ELSE IF @zahl = 43
	BEGIN
		PRINT 'Zahl ist fast richtig';
	END
ELSE
	BEGIN
		PRINT 'Zahl ist falsch';
	END;


-- Schleife
DECLARE @index INT = 1;

WHILE @index <= 10
	BEGIN
		PRINT @index;
		SET @index += 1;
	END;


-- Try-Catch-Konstrukte
BEGIN TRY
	SELECT 1 / 1;
END TRY
BEGIN CATCH
	PRINT 'Es wurde durch Null geteilt';
END CATCH;


DECLARE @angNr INT, @abtNr INT, @proNr INT;

SELECT @angNr = a.a_nr, @abtNr = a.abt_nr, @proNr = p.p_nr
FROM ang a INNER JOIN pro_ang PA ON a.a_nr = pa.a_nr
			INNER JOIN pro p ON p.p_nr = pa.p_nr
WHERE a.gehalt = 5240;

PRINT @angNr +  @abtNr +  @proNr;


DECLARE @i INT = 0;

WHILE @i <= 100
	BEGIN
		
		SET @i += 1;

		IF @i = 7
			BEGIN
				CONTINUE;
			END

		IF @i = 9
			BEGIN
				BREAK;
			END

		PRINT 'Die aktuelle Zahl ist ' + CAST(@i AS NVARCHAR(10)); 
	END;



