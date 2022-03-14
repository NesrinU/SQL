CREATE DATABASE TestDB;
GO

USE TestDB;
GO


CREATE TABLE [dbo].[tbl_Kunde](
		[Nr] [int] NULL,
		[Geschlecht] [char](1) NULL,
		[Vorname] [varchar](35) NULL,
		[Nachname] [varchar](35) NULL,
		[Str] [varchar](35) NULL,
		[Hausnummer] [int] NULL,
		[Ort] [varchar](50) NULL,
		[Bundesland] [varchar](50) NULL,
		[PLZ] [char](10) NULL,
		[Geb] [date] NULL,
		[Einkommen] [decimal](10, 2) NULL,
		[Kunde_Seit] [date] NULL,
		[AustrittAm] [date] NULL     );

-- Import/Export Assistenten (Win - Import --> 64 bit)
-- Startseite überspringen
-- Datenquelle Flatfilequelle
-- Datei suchen --> auf Desktop finden
-- kein Unicode, Trennzeichen CR LF, Spalten, Vorschau
-- in Tabelle speichern, oder neue Tabelle erstellen, wie gewünscht
-- wenn in obiger Tabelle, dann auf "Fehler ignorieren" klicken (ziel: native sql)

SELECT COUNT(*) FROM tbl_Kunde;

-- alles da, kann also losgehen

SELECT TOP 100 * FROM tbl_Kunde;

SELECT TOP 100 Nachname, Einkommen FROM tbl_Kunde
ORDER BY Einkommen DESC;

-- Zuerst mal einen Table-Scan
-- dafür Statistiken einschalten

SET STATISTICS IO ON;

SELECT * FROM tbl_Kunde
WHERE Einkommen = 5441.87; -- E/A Kosten: 29,x

SELECT AVG(Einkommen) FROM tbl_Kunde; -- E/A Kosten: 29,x

-- Lesevorgänge sind bei beiden Abfragen 39696
-- Jetzt ein ROWSTORE-Index erstellen

CREATE NONCLUSTERED INDEX IX_ROW
ON tbl_Kunde(Einkommen ASC);

-- immer noch 39696 Lesevorgänge, aber sehen wir weiter:


SELECT * FROM tbl_Kunde
WHERE Einkommen = 5441.87; -- Logische Lesevorgänge: 10, E/A Kosten 0,00x

SELECT AVG(Einkommen) FROM tbl_Kunde; -- Logische Lesevorgänge: 8556, E/A-Kosten: 6,3x

-- Schnelles Picken von Daten, langsame Berechnung über die Datenmenge

-- nun Index löschen
DROP INDEX IX_ROW
ON tbl_Kunde;

-- Jetzt erstellen eines Columnstore Index
CREATE COLUMNSTORE INDEX IX_COL
ON tbl_Kunde (Einkommen);

-- Jetzt die gleichen Abfragen wie oben durchführen:
SELECT * FROM tbl_Kunde
WHERE Einkommen = 5441.87; -- Logische Lesevorgänge: 7, E/A-Kosten: 1,3x

SELECT AVG(Einkommen) FROM tbl_Kunde; -- Logische Lesevorgänge: 0, E/A-Kosten: 0,24x

-- Das ist doch schon der Wahnsinn
-- wie ist es mit einem gruppierten Columnstore?
DROP INDEX IX_COL ON tbl_Kunde;

CREATE CLUSTERED COLUMNSTORE INDEX IX_CCOL
ON tbl_Kunde;

-- wieder einmal Daten abfragen:
SELECT * FROM tbl_Kunde
WHERE Einkommen = 5441.87; -- Logische Lesevorgänge: 0, E/A-Kosten: 1,686x

SELECT AVG(Einkommen) FROM tbl_Kunde; -- Logische Lesevorgänge: 0, E/A-Kosten: 0,24x


DROP INDEX IX_CCOL ON tbl_Kunde;

-- Zusammenfassend:
-- Columnstore ist besser bei Aggregatfunktionen
-- Rowstore ist besser beim Picken von Daten