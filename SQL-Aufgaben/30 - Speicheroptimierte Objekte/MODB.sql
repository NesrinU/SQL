-- Speicheroptimierte Tabellen

-- Erstellen einer Datenbank
CREATE DATABASE MODB;
GO

USE MODB;
GO

-- Anlegen einer Tabelle
CREATE TABLE Test
(
	Zahl INT
)
WITH (MEMORY_OPTIMIZED = ON);
GO
-- Fehlermeldung: Ein Primärschlüssel muss definiert sein
-- plus Index muss erstellt werden
-- dann steht da noch was über Durability

-- also erst mal Primärschlüssel definieren
-- wissen: Primärschlüssel richtet Index automatisch ein
CREATE TABLE Test
(
	Zahl INT PRIMARY KEY
)
WITH (MEMORY_OPTIMIZED = ON);
-- Fehler: gruppierte Indizes werden für speicheroptimierte Tabellen nicht unterstützt
-- Lösung: nicht gruppierter Index
CREATE TABLE Test
(
	Zahl INT PRIMARY KEY NONCLUSTERED
)
WITH (MEMORY_OPTIMIZED = ON);
-- Fehler: Eine FILEGROUP (Dateigruppe) muss erstellt werden
-- Dieses entweder per T-SQL oder über die Eigenschaften der Datenbank

-- Hier T-SQL:
USE [master]
GO
ALTER DATABASE [MODB] 
ADD FILEGROUP [MODBDG] 
CONTAINS MEMORY_OPTIMIZED_DATA; 
GO
-- Filegroup ist erstellt, jetzt wieder in die DB wechseln und Tabelle anlegen
USE MODB;
GO

CREATE TABLE Test
(
	Zahl INT PRIMARY KEY NONCLUSTERED
)
WITH (MEMORY_OPTIMIZED = ON);
-- mindestens ein Container wird gebraucht
-- also in der master einen Container anlegen
USE master;
GO

ALTER DATABASE [MODB] 
ADD FILE 
(	NAME = N'MODBDF', 
	FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\MODBDF' ) 
TO FILEGROUP [MODBDG];
GO

-- und wieder einmal versuchen, die Tabelle anzulegen
USE MODB;
GO

CREATE TABLE Test
(
	Zahl INT PRIMARY KEY NONCLUSTERED
)
WITH (MEMORY_OPTIMIZED = ON,
		DURABILITY = SCHEMA_ONLY);


-- nun hat es funktioniert
-- Das Erstellen hat ein bisschen länger als üblich gedauert
-- Das liegt daran, dass für Memory-Optimized tables dll's angelegt werden


-- wenn alles per T-SQL erstellt wurde, dann ruhig mal die Eigenschaften
-- der Datenbank ansehen und die Dateigruppen / Dateien ansehen

-- Daten einfügen
INSERT Test
VALUES
(4711),
(0815),
(1234);

SELECT * FROM Test;

-- jetzt ruhig mal --SMMS beenden und wieder starten
SELECT * FROM Test;

-- Daten sind vorhanden
-- Beim Modus DURABILITY = SCHEMA_ONLY
-- (im Gegensatz zum default DURABILITY = SCHEMA_AND_DATA)
-- würden die Daten verloren sein

-- Eine weitere Art Tabelle im RAM, nur ohne Unterstützung von Datenträgern
CREATE TYPE EinTabellenTyp AS TABLE
(
	ID INT PRIMARY KEY NONCLUSTERED,
	Daten NVARCHAR(max) NOT NULL
)
WITH (MEMORY_OPTIMIZED = ON);

DECLARE @tab EinTabellenTyp;

INSERT INTO @tab
VALUES
(1, 'haha');

SELECT * FROM @tab;

GO

-- Gespeicherte speicheroptimierte Prozedur
CREATE PROCEDURE usp_beispiel(@zahl int)
WITH 
	NATIVE_COMPILATION, SCHEMABINDING
AS
	BEGIN ATOMIC 
	WITH 
		(TRANSACTION ISOLATION LEVEL = SNAPSHOT,
		LANGUAGE = 'german')

			INSERT INTO dbo.Test
			VALUES (@zahl);
	END;

GO

-- Aufruf der gespeicherten Prozedur
DECLARE	@return_value int

EXEC	@return_value = [dbo].[usp_beispiel]
		@zahl = 12345

SELECT	'Return Value' = @return_value

SELECT * FROM Test;

-- Funktionen auch mittlerweile speicheroptimiert, siehe Link:
-- https://docs.microsoft.com/de-de/sql/relational-databases/in-memory-oltp/faster-temp-table-and-table-variable-by-using-memory-optimization?view=sql-server-ver15
-- (eventuell nur SQL Server 2019)

