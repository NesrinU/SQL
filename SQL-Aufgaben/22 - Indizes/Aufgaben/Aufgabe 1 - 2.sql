--Aufgabe 1
--Beschäftigen Sie sich mit dem Thema Indizes mithilfe der folgenden Links: 
--https://technet.microsoft.com/de-de/library/ms189051(v=sql.105).aspx (neu)
--https://msdn.microsoft.com/de-de/library/jj835095%28v=sql.120%29.aspx
--Aufgabe 2
--Nutzen Sie das MOV_FILM_SQL_SERVER….. Skript um die neue Datenbank zu erstellen.
--Entfernen Sie in der Datenbank TeachSQL (oder Movies) von den Tabellen MOV_FILM, MOV_PERSON und MOV_BESETZUNG alle bestehenden Schlüssel und Indizes (verwenden Sie dazu den Objekt-Explorer des SSMS). Entfernen Sie auch alle bisher vorhandenen Statistiken von den drei Tabellen, falls noch welche da sind-
USE TeachSQL;
GO
SELECT * FROM MOV_BESETZUNG;
SELECT * FROM MOV_FILM;
SELECT * FROM MOV_PERSON;

--Erstellen Sie folgende Indizes und Schlüssel neu:

--	MOV_PERSON:

--o	Die Spalte „ID“ soll der PK werden (nicht gruppiert)
ALTER TABLE MOV_PERSON
ADD CONSTRAINT PK_Person PRIMARY KEY NONCLUSTERED (id);

--o	Die Spalte „Name“ erhält einen gruppierten Index 
CREATE CLUSTERED INDEX ix_Person_Name
ON MOV_PERSON (name);

--	MOV_BESETZUNG:

--o	Die Spalte „filmid“ erhält einen eigenen, nicht gruppierten Index, schließen Sie die Spalte „ord“ mit ein
CREATE NONCLUSTERED INDEX ix_Besetzung_filmid
ON MOV_BESETZUNG (filmid)
INCLUDE (ord);

--o	Die Spalte „persid“ erhält einen eigenen, nicht gruppierten Index, schließen Sie die Spalte „ord“ mit ein
CREATE NONCLUSTERED INDEX ix_Besetzung_persid
ON MOV_BESETZUNG (persid)
INCLUDE (ord);

--	MOV_FILM:

--o	Die Spalte „ID“ soll der PK werden (nicht gruppiert)
ALTER TABLE MOV_FILM
ADD CONSTRAINT PK_Film PRIMARY KEY NONCLUSTERED (id);

--o	Die Spalte „Titel“ erhält einen gruppierten Index
CREATE CLUSTERED INDEX ix_Film_titel
ON MOV_FILM (titel);

--o	Die Spalte „Jahr“ erhält einen nicht gruppierten Index
CREATE NONCLUSTERED INDEX ix_Film_Jahr
ON MOV_FILM (Jahr);

--o	Die Spalte „Punkte“ erhält einen nicht gruppierten Index, absteigend sortiert
CREATE NONCLUSTERED INDEX ix_Film_Punkte
ON MOV_FILM (Punkte DESC);

--o	Die Spalte „Stimmen“ erhält einen nicht gruppierten, gefilterten Index, absteigend sortiert. In den Index sollen nur Zeilen eingehen, mit einem Wert für Stimmen >= 10000
CREATE NONCLUSTERED INDEX ix_Film_Stimmen
ON MOV_FILM (Stimmen)
WHERE Stimmen >= 10000;