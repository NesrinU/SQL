
CREATE TABLE Testtabelle
(
	ID INT,
	[Text] NVARCHAR(MAX)
);

INSERT INTO Testtabelle
VALUES
(1, 'Blablablabla'),
(2, 'Schwadronier'),
(3, 'Sülzsülz');

SELECT * FROM Testtabelle;

UPDATE Testtabelle
SET [Text] = 'Doppelsülz'
WHERE ID = 3;
GO

CREATE TABLE Testtabelle_Historie
(
	ID INT,
	[Text] NVARCHAR(MAX)
);
GO

CREATE TRIGGER tr_Historie
ON Testtabelle
AFTER UPDATE, DELETE
AS
	BEGIN
		INSERT INTO Testtabelle_Historie
		SELECT * FROM deleted
	END
RETURN

UPDATE Testtabelle
SET [Text] = 'SülzSülz'
WHERE ID = 3;
GO

SELECT * FROM Testtabelle;
SELECT * FROM Testtabelle_Historie;
