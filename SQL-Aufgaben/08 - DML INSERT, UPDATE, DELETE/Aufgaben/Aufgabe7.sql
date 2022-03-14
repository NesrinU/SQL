--Wechseln Sie in die vorbereitete Datenbank TSQL2012.
USE TSQL2012

--Kopieren Sie Daten aus der TeachSQL-Datenbank, Tabelle MOV_FILM in eine Tabelle mit Namen „Filme“.  Es sollen nur Filme kopiert werden, deren Punkte größer als 7 sind.
SELECT * INTO TSQL2012.dbo.Filme FROM TeachSQL.dbo.MOV_FILM
WHERE TeachSQL.dbo.MOV_FILM.Punkte > 7;

SELECT * FROM Filme;

--Benutzen Sie dazu das „SELECT * INTO …“ – Kommando.

--Welche Schlüsseleigenschaften hat die alte Tabelle?

--Welche Schlüsseleigenschaften hat die neue Tabelle?

--Erstellen Sie eine Tabelle „Schauspieler“ in der TSQL2012-Datenbank. Die Spalten sollen nur  PID und ein Schauspielername sein, es sollen keine Constraints vergeben werden. Kopieren Sie alle Daten aus der Tabelle TeachSQL.dbo.MOV_PERSON in die Tabelle Schauspieler. 
CREATE TABLE Schauspieler
(
	PID					INT			NOT NULL,
	Schauspielername	VARCHAR(50)	NOT NULL
);

INSERT INTO TSQL2012.dbo.Schauspieler 
SELECT * FROM TeachSQL.dbo.MOV_PERSON;

SELECT * FROM Schauspieler;

--Versuchen Sie, einen Datensatz doppelt in die Tabelle einzufügen.

INSERT INTO Schauspieler
VALUES
(10000, 'Hui Buh'),
(10000, 'Hui Buh');

SELECT * FROM Schauspieler
WHERE PID = 10000;


--Versuchen Sie dann die Spalte PID mit einer Primärschlüsseleigenschaft zu versehen.
ALTER TABLE Schauspieler
ADD CONSTRAINT PK_Schauspieler
PRIMARY KEY (PID);
--Meldung 2627, Ebene 14, Status 1, Zeile 30
--Verletzung der PRIMARY KEY-Einschränkung "PK_Schauspieler". Ein doppelter Schlüssel kann in das dbo.Schauspieler-Objekt nicht eingefügt werden. Der doppelte Schlüsselwert ist (10000).
--Die Anweisung wurde beendet.

DELETE FROM Schauspieler 
WHERE PID = 10000;

ALTER TABLE Schauspieler
ADD CONSTRAINT PK_Schauspieler
PRIMARY KEY (PID);