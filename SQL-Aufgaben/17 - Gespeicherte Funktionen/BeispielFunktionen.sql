CREATE OR ALTER FUNCTION GGT(@zahl1 INT, @zahl2 INT)
RETURNS INT
AS
	BEGIN
		WHILE @zahl2 != 0
            BEGIN
                DECLARE @temp int = @zahl1;
                SET @zahl1 = @zahl2;
                SET @zahl2 = @temp % @zahl2;
            END

            RETURN @zahl1;
	END;
GO

SELECT dbo.GGT(42, 70) AS Ergebnis;

GO

CREATE OR ALTER FUNCTION Split(@zeichenkette NVARCHAR(MAX), @seperator CHAR)
RETURNS @tab TABLE 
			(
				value	NVARCHAR(MAX)	NOT NULL
			)
AS
	BEGIN
		-- Zähler anlegen
		DECLARE @zaehler INT = 1;


		-- Schleife solange durchlaufen, solange noch ein @seperator-zeichen vorhanden ist
		WHILE CHARINDEX(@seperator, @zeichenkette) != 0
			BEGIN
				
				-- Suche @seperator
				DECLARE @stelle INT = CHARINDEX(@seperator, @zeichenkette);
				
				-- Alles bis zur @stelle in @tab schreiben
				INSERT INTO @tab
				VALUES (SUBSTRING(@zeichenkette, 0, @stelle));

				-- @zaehler hochsetzen
				SET @zaehler += 1;

				-- @zeichenkette kürzen
				SET @zeichenkette = SUBSTRING(@zeichenkette, @stelle + 1, LEN(@zeichenkette));

				
			END

			-- Rest in @tab einfügen
			IF LEN(@zeichenkette) > 0
				BEGIN
					INSERT @tab
					VALUES (@zeichenkette);
				END

		RETURN;
	END;

GO

SELECT CHARINDEX('w', 'Hallo');

SELECT * INTO SplitTabelle
FROM STRING_SPLIT('Hallo Welt! Heute ist ein schöner Tag!', ' ');

SELECT * 
INTO SplitTabelle 
FROM dbo.Split('Hallo Welt! Heute ist ein schöner Tag!', ' ');

SELECT * FROM SplitTabelle;
GO


CREATE FUNCTION Ausgabe(@startzeichen CHAR)
RETURNS TABLE
AS
RETURN	SELECT * 
		FROM Testtabelle
		WHERE LEFT(Text, 1) = @startzeichen;

GO


SELECT * FROM Ausgabe('S');











