SELECT * FROM Artikel;
--SELECT * FROM Kunde;
SELECT * FROM Bestellung;
SELECT * FROM ArtikelBestellung;



-- Löschen der Spalte Status
ALTER TABLE Bestellung
DROP COLUMN Status;

-- Insert in die Bestellungs-Tabelle
INSERT INTO Bestellung (Bestellnummer, Datum, KundenID)
VALUES
(1000, '01.04.2016', 110),
(1010, '05.05.2016', 120),
(1020, '22.05.2016', 110),
(1030, '24.06.2016', 100),
(1040, '11.07.2016', 130);

-- Weitere Spalte in ArtikelBestellung-Tabelle
ALTER TABLE ArtikelBestellung
ADD Menge	INT		CHECK (Menge >= 1);

-- Daten in die ArtikelBestellungs-tabelle
INSERT ArtikelBestellung VALUES
(1, 1000, 2),
(3, 1000, 2),
(7, 1010, 3),
(5, 1010, 2),
(3, 1010, 2),
(1, 1020, 4),
(6, 1020, 1),
(4, 1030, 3),
(5, 1030, 1),
(7, 1030, 1),
(5, 1040, 4),
(6, 1040, 3);
