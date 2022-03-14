--Aufgabe 1

--Erstellen Sie eine speicheroptimierte Tabelle mit einem Schema Ihrer Wahl in einer Datenbank Ihrer Wahl. Sorgen Sie dafür, dass die Daten nicht persistent gespeichert werden. Füllen Sie die Tabelle mit Daten. Starten Sie den Server danach einmal neu und sehen sich die Daten der Tabelle an.
USE SecurityTest;
GO
CREATE SCHEMA spei_opt;
GO
CREATE TABLE spei_opt.Schlange
	(
	ZAHL	INT		PRIMARY KEY NONCLUSTERED
	)
	WITH (MEMORY_OPTIMIZED = ON,
			DURABILITY = SCHEMA_ONLY);

DECLARE @nr INT = 1;
WHILE @nr < 10 
	BEGIN 
		INSERT INTO spei_opt.Schlange VALUES (@nr);
		SET @nr = @nr + 1;
	END
;
GO
SELECT * FROM spei_opt.Schlange;

--Aufgabe 2

--Wiederholen Sie die Arbeitsschritte aus Aufgabe 1, allerdings hier mit einer Tabelle, deren Daten auch speicheroptimiert sind und persistent bleiben sollen.
CREATE TABLE spei_opt.Schlange2
	(
	ZAHL	INT		PRIMARY KEY NONCLUSTERED
	)
	WITH (MEMORY_OPTIMIZED = ON,
			DURABILITY = SCHEMA_AND_DATA);

DECLARE @nr INT = 1;
WHILE @nr < 10 
	BEGIN 
		INSERT INTO spei_opt.Schlange2 VALUES (@nr);
		SET @nr = @nr + 1;
	END
;
GO
SELECT * FROM spei_opt.Schlange;

--Aufgabe 3

--Erstellen Sie einen datenbankeigenen Tabellentyp und schreiben auch in diesen einige Daten.
CREATE TYPE TabellenTyp AS TABLE
	(
	ID		INT		PRIMARY KEY NONCLUSTERED,
	Name	VARCHAR(50)
	)
WITH (MEMORY_OPTIMIZED = ON);

DECLARE @tabelle_typ TabellenTyp;

INSERT INTO @tabelle_typ
VALUES
	(1, 'Emre'),
	(2, 'Hasan'),
	(3, 'Sümeyra');

SELECT * FROM @tabelle_typ;


--Aufgabe 4

--Erstellen Sie eine speicheroptimierte Prozedur, welche Sie für Einträge in eine der erstellten speicheroptimierten Tabellen verwenden sollen. Testen Sie diese Prozedur.


--Aufgabe 5

--Sehen Sie sich den Link aus den Beispielen an und ermitteln Sie, welche weiteren speicheroptimierten Objekte Sie noch erstellen können. Legen Sie dafür Beispiele an.
