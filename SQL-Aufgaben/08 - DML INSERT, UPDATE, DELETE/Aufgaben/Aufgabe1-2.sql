--Aufgabe 1
--a)	Wechseln Sie in die Uebungsdatenbank. 
--Fügen Sie der Tabelle „Artikel“ eine Spalte „Artikelname“ zu. Anschließend ändern Sie den Datentyp der Spalte „Vorhanden“ auf INT. 
--Füllen Sie die von Ihnen erstelle Tabelle „Artikel“ mit folgenden Daten:

USE Übungsdatenbank;

DROP TABLE ArtikelBestellung;
DROP TABLE Artikel;
DROP TABLE Bestellung;
DROP TABLE Kunde;
DROP TABLE Kunden;


CREATE TABLE Artikel
(
	Artikelnummer	INT			NOT NULL,
	Name			VARCHAR(50)	NOT NULL,
	Vorhanden		INT			NOT NULL,
	Preis			MONEY,
);

INSERT Artikel (Artikelnummer, Name, Vorhanden, Preis)
OUTPUT inserted.*
VALUES 
(1, 'Snickers',			30,	'0,99'),
(2,	'Nogger',			14,	'1,40'),
(3, 'Nutella',			27,	'1,99'),
(4, 'Bifi',				42,	'0,80'),
(5,	'Chips',			18,	'0,70'),
(6,	'Kaugummi',			31,	'0,59'),
(7,	'Döner mit alles',	22,	'3,50');

--DELETE Artikel;
--SELECT * FROM Artikel

--b)	Erhöhen Sie den Preis für Chips auf 0,80 €.
UPDATE Artikel
SET Preis = 0,80
WHERE Name = 'Chips';

--c)	Erhöhen Sie alle Preise um 8%.
UPDATE Artikel
OUTPUT inserted.*, deleted.*
SET Preis = Preis / 100 * 108;

--d)	Geben Sie 3 % Rabatt auf alle Artikel, von denen mehr als 25 vorhanden sind.
UPDATE Artikel
OUTPUT inserted.*, deleted.*
SET Preis = Preis / 100 * 97
WHERE Vorhanden > 25;

--e)	Löschen Sie das Nogger aus dem Sortiment
DELETE FROM Artikel
WHERE Name = 'Nogger';

--Aufgabe 2
--a)	Fügen Sie in der Tabelle Kunde eine Spalte „Telefon“ hinzu. Es sollen nur Telefonnummern mit Ländervorwahl, mit Vorwahl in runden Klammern und Durchwahl eingegeben werden können.
CREATE TABLE Kunde 
(
	Telefon INT	NOT NULL,
	CHECK (Telefon LIKE '+[0-9][0-9]([0-9][0-9][0-9][0-9])%')
);

--b)	Fall 1: keine Tabelle Lieferadresse: Löschen Sie die Spalten „Typ“, „Ansprechpartner“ und „Zeiten“ aus der Tabelle, fügen Sie anschließend die Spalten „Vorname“ und „Nachname“ ein. 

--Fall 2: Tabelle Lieferadresse vorhanden: Löschen Sie die Lieferadresse-Tabelle und erweitern die Kunden-Tabelle um das unten stehende Schema. 

--c)	Fügen Sie die folgenden Datensätze in die Tabelle „Kunde“ ein:
--Kundennummer	Rabatt	Straße			Haus-nummer	PLZ		Stadt	Land		Telefon				Vorname	Nachname
--100			0		Lange Straße	5			26421	Bonn	Deutschland	+49 (2345) 9283746	Hans	Wurst
--110			3		Hauptstraße		28			63987	Köln	Deutschland	+49 (9382) 192837	Daisy	Duck
--120			5		Bahnhofstraße	9			11439	Siegen	Deutschland	+49 (6354) 13579	Micky	Maus
--130			0		Schlossallee	54			53248	Berlin	Deutschland	+49 (8642) 97531	Kim		Possible
--140			3		Parkstraße		2			61424	Werl	Deutschland	+49 (5647) 271809	Road	Runner

