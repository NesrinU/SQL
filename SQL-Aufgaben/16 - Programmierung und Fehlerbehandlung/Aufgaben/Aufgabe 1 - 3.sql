--Aufgabe 1 Schleifen

--Erstellen Sie in der TeachSQL-Datenbank eine neue Tabelle ID_Tab. Darin sollen die Spalten ID (integer) und U_ID (uniqueidentifier --> Recherche!) vorhanden sein.
USE TeachSQL;
GO
CREATE TABLE ID_Tab 
(
ID		INT	,
U_ID	INT	IDENTITY	
)
;
--Mittels einer Schleife sollen in die ID-Spalte alle Zweierpotenzen (1, 2, 4, 8, 16, 32, 64 etc.) bis 2 hoch 15 eingefügt werden. In die U_ID-Spalte sollen automatisch generierte uniqueidentifier-Werte eingefügt werden.

DECLARE @index INT = 0;
		
WHILE POWER (2, @index) <= POWER (2, 15)
	BEGIN
		INSERT INTO ID_Tab (ID)
		VALUES(POWER (2, @index))
		SET @index += 1;
	END;

SELECT * FROM ID_Tab;

--Aufgabe 2 Schleifen und Verzweigungen

--a)	 Erstellen Sie in der TeachSQL-Datenbank eine neue Tabelle FooBar.  Hier sollen die Spalten ID, mod7, mod3 vorhanden sein. Mittels einer Schleife sollen die ID’s von 1 bis 100 eingefügt werden. Ist die ID durch 7 teilbar, kommt in die mod7-Spalte der Schriftzug foo, ist die ID durch 3 teilbar, kommt in die mod3-Spalte der Schriftzug bar.
CREATE TABLE FooBar
	(
	ID		INT,
	mod7	VARCHAR(50),
	mod3	VARCHAR(50)
	);
GO
DECLARE @i INT = 1
WHILE @i <= 100
	BEGIN
	INSERT INTO FooBar (ID)
	VALUES
		(@i)
	IF @i%7=0 
		BEGIN
		    UPDATE FooBar SET mod7 = 'foo' WHERE ID%7=0
		END
	IF @i%3=0
		BEGIN
			UPDATE FooBar SET mod3 = 'bar' WHERE ID%3=0
		END
	SET @i += 1
	END;

SELECT * FROM FooBar;

DELETE FooBar;

--b)	Löschen Sie die Tabelle wieder und erstellen die Tabelle neu, allerdings nur mit 2 Spalten. Für weder durch 3 noch durch 7 teilbare ID’s soll dort dumb  stehen, für durch 3 teilbare ID’s bar, für durch 7 teilbare ID’s foo und für sowohl durch 3 als auch durch 7 teilbare ID’s foobar. Die ID’s sollen auch hier wieder von 1 bis 100 sein.
DROP TABLE FooBar;
GO
CREATE TABLE FooBar 
	(
	ID		INT,
	Dumb	VARCHAR(10)
	);
GO
DECLARE @i INT = 1
WHILE @i <= 100
	BEGIN
	INSERT INTO FooBar (ID)
	VALUES
		(@i)
		SET @i += 1

		UPDATE FooBar SET Dumb = 'foo' WHERE ID%7=0
		UPDATE FooBar SET Dumb = 'bar' WHERE ID%3=0
		UPDATE FooBar SET Dumb = 'foobar' WHERE ID%3=0 AND ID%7=0
	END;
GO
SELECT * FROM FooBar;

DELETE FooBar;
--Aufgabe 3 Try-Catch

--Erstellen Sie eine weitere Tabelle ganz nach dem Schema von der vorherigen Aufgabe b). In einer dritten Spalte sollen integer-Werte stehen. Es sollen die gleichen Werte sein, welche die aktuelle ID ist, mit der Ausnahme, dass alle durch 5 teilbaren Zahlen mit 50 subtrahiert werden. In einer vierten Spalte soll dann der Quotient der ID und der errechneten Zahl stehen. 
ALTER TABLE FooBar
ADD 
	(5bar		INT,
	Quotient	INT)