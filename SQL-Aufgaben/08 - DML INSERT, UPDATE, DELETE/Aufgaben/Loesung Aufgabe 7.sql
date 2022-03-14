-- Datenbank TSQL2012
USE TSQL2012;

-- Kopieren aus TeachSQL in TSQL2012
SELECT * INTO Filme
FROM TeachSQL.dbo.MOV_FILM
WHERE punkte > 7;


-- ansehen
SELECT * FROM Filme;

-- Schlüsseleigenschaften alte Tabelle
USE TeachSQL;
SELECT * FROM sys.tables;
SELECT object_id
FROM sys.tables
WHERE name = 'MOV_FILM';

-- hier 597577167
SELECT * 
FROM sys.key_constraints
WHERE parent_object_id = 597577167;


-- in der kopierten Tabelle:
USE TSQL2012;

SELECT * FROM sys.tables;
SELECT object_id
FROM sys.tables
WHERE name = 'Filme';

-- hier 1701581100
SELECT * 
FROM sys.key_constraints
WHERE parent_object_id = 1701581100;

-- offensichtlich:


CREATE TABLE Schauspieler
(
	PID	INT NOT NULL,
	Schauspielername VARCHAR(100) NOT NULL
);

INSERT INTO Schauspieler
SELECT id, name
FROM TeachSQL.dbo.MOV_PERSON;

SELECT * FROM Schauspieler;

INSERT INTO Schauspieler
VALUES
(10000, 'Hui Buh'),
(10000, 'Hui Buh');

SELECT * FROM Schauspieler
WHERE PID = 10000;

ALTER TABLE Schauspieler
ADD CONSTRAINT PK_Schauspieler
PRIMARY KEY (PID);

DELETE FROM Schauspieler 
WHERE PID = 10000;

ALTER TABLE Schauspieler
ADD CONSTRAINT PK_Schauspieler
PRIMARY KEY (PID);
