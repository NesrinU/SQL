-- Beispiele


CREATE DATABASE NeueDatenbank
ON  PRIMARY 
( NAME = N'Primaerfile', 
 FILENAME = N'F:\NDB1MDF\primaerfile.mdf')
, 
 FILEGROUP [Sekundaerfile] 
( NAME = N'FG2a', 
FILENAME = N'G:\NDB1NDF\sekfile1.ndf'
),
(
 NAME = N'FG2b',
 FILENAME = N'G:\NDB1NDF\sekfile2.ndf'
)
 LOG ON 
( NAME = N'NDB1Log', 
FILENAME = N'H:\NDB1LOG\logfile.ldf')
;


DROP DATABASE NeueDatenbank;
