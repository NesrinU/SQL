USE Uebungsdatenbank;

-- Ansehen der Tabelle
SELECT * FROM Artikel;

-- Aufgabe a)

-- Einf�gen der Spalte Artikelname

ALTER TABLE Artikel ADD
Artikelname varchar(50) NOT NULL;

-- �ndern der Spalte Vorhanden

ALTER TABLE Artikel
ALTER COLUMN Vorhanden INT NOT NULL;

-- Einf�gen der Daten
INSERT INTO Artikel(Artikelnummer, Artikelname, Vorhanden, Preis)
VALUES
(1, 'Snickers', 30, 0.99),
(2,'Nogger', 14, 1.40),
(3, 'Nutella', 27, 1.99),
(4, 'Bifi', 42, 0.80),
(5, 'Chips', 18, 0.70),
(6, 'Kaugummi', 31, 0.59),
(7, 'D�ner mit alles', 22, 3.50);


-- Aufgabe b) Erh�hen des Preises f�r Chips
UPDATE Artikel
SET Preis = 0.80
WHERE [Artikelname] LIKE 'Chips'

-- Aufgabe c) alle Preise 8% rauf
UPDATE Artikel
SET Preis = Preis * 1.08;

SELECT * FROM Artikel;

-- Aufgabe d) Prozente auf alle Artikel > 25 St�ck

UPDATE Artikel 
SET Preis = Preis * 0.97 
OUTPUT inserted.Preis, deleted.Preis 
WHERE Vorhanden > 25;

SELECT * FROM Artikel;



-- Aufgabe e) Nogger l�schen 

DELETE FROM Artikel
WHERE [ARTIKELNAME] = 'Nogger'
;


-- Aufgabe 2
------------------------------------------

-- ansehen der Tabelle Kunde
SELECT * FROM Kunde;

-- Aufgabe a) Telefon hinzuf�gen
ALTER TABLE Kunde
ADD
Telefon		VARCHAR(50)
CONSTRAINT chk_Tel CHECK (Telefon LIKE '+[0-9][0-9] ([0-9]%) [0-9]%')
;

-- Aufgabe b) L�schen und Einf�gen von Spalten
ALTER TABLE Kunde DROP COLUMN Typ;
ALTER TABLE Kunde ADD Vorname VARCHAR(30) NOT NULL;
ALTER TABLE Kunde ADD Nachname VARCHAR(50) NOT NULL;
SELECT * FROM Kunde;
ALTER TABLE Kunde ADD Stra�e VARCHAR(100) NOT NULL;

ALTER TABLE Kunde ADD Hausnummer INT NOT NULL;

ALTER TABLE Kunde ADD PLZ VARCHAR(5) CHECK (PLZ LIKE '[0-9][0-9][0-9][0-9][0-9]');

ALTER TABLE Kunde ADD Stadt VARCHAR(30) NOT NULL;

ALTER TABLE Kunde ADD Land VARCHAR(30) NOT NULL;


-- Aufgabe c) Datens�tze einf�gen
INSERT INTO Kunde
	(Kundennummer, Rabatt, Stra�e, Hausnummer, PLZ,
	Stadt, Land, Telefon, Vorname, Nachname)
VALUES
(100, 0, 'Lange Stra�e', 5, 26421, 'Bonn', 'Deutschland', '+49 (2345) 9283746', 'Hans', 'Wurst'),
(110, 3, 'Hauptstra�e', 28, 63987, 'K�ln', 'Deutschland', '+49 (9382) 192837', 'Daisy', 'Duck'),
(120, 5, 'Bahnhofstra�e', 9, 11439, 'Siegen', 'Deutschland', '+49 (6354) 13579', 'Micky', 'Maus'),
(130, 0, 'Schlossalee', 54, 53248, 'Berlin', 'Deutschland', '+49 (8642) 97531', 'Kim', 'Possible'),
(140, 3, 'Parkstra�e', 2, 61424, 'Werl', 'Deutschland', '+49 (5647) 271809', 'Road', 'Runner')
;

SELECT * FROM Kunde;
