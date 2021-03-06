-- Aufgabe 5.1

CREATE DATABASE [NewDB1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( 
	NAME = N'NewDB1', 
	FILENAME = N'E:\TestDatabases\NewDB1.mdf' , 
	SIZE = 15360KB , 
	MAXSIZE = 51200KB , 
	FILEGROWTH = 5120KB )
 LOG ON 
( 
	NAME = N'NewDB1_log', 
	FILENAME = N'F:\TestLogs\NewDB_Log.ldf' , 
	SIZE = 8192KB , 
	FILEGROWTH = 65536KB )
GO

USE NewDB1;


CREATE TABLE NewDBTabelle
(
	ID INT IDENTITY PRIMARY KEY,
	Daten NVARCHAR(MAX)
);

DECLARE @var INT = 1;

WHILE @var < 500
BEGIN
	INSERT NewDBTabelle(Daten)
	VALUES (CAST(@var AS char(8000)));
	SET @var +=1;
END



WHILE @var < 500
BEGIN
	INSERT NewDBTabelle(Daten)
	VALUES (REPLICATE(@var, 1000));
	SET @var +=1;
END
