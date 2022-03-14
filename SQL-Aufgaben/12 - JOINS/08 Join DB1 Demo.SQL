SET NOCOUNT ON
Use master;
GO

IF EXISTS(SELECT * from sys.databases WHERE name='JoinDB1')  
-- IF DB_ID (N'JoinDB1') IS NOT NULL
BEGIN  
    DROP DATABASE JoinDB1
END  

CREATE DATABASE JoinDB1
ON PRIMARY(
	NAME = DataMain,
	FILENAME = N'C:\Datenbanken\JoinDB1.mdf',
	SIZE = 5 MB,
	MAXSIZE = 11 MB,
	FILEGROWTH = 2 MB
)

Go
Use joinDB1
Go

CREATE TABLE Pers
(
   Nachname CHAR (15),
   Vorname CHAR (15),
   G CHAR (1),
   SV_ID CHAR (15),
   Straße CHAR (20),
   PLZ INT,
   Ort CHAR (15),
   Kfz SMALLINT,
   PRIMARY KEY(SV_ID)
);

CREATE TABLE Kfz
(
   ID SMALLINT NOT NULL,
   Marke CHAR (10),
   Modell CHAR (15),
   Kennzeichen CHAR (10),
   gefahreneKM INTEGER,
   Baujahr SMALLINT,
   HU DATE,
   PRIMARY KEY(ID)
);

INSERT INTO Pers VALUES('Maine','Kathrin','w','25 553455 M 436','Uferstraße 3', 44444,'Musterhausen',2)
INSERT INTO Pers VALUES('Müller','Wolfgang','m','25 100615 M 694','Bahnhofstraße 14', 52252,'Musterheim',5)
INSERT INTO Pers VALUES('Meyer','Günther','m','25 091225 M 463','Am Marktplatz 3',36363,'Musterfelde',NULL)
INSERT INTO Pers VALUES('Hermann','Gerti','w','25 588949 M 723','Bochumer Weg 54',15551,'Musterdorf',2) 
INSERT INTO Pers VALUES('Klein','Liese','w','25 323444 M 542','Bachstraße 5a ',88883,'Mustertal',3)
INSERT INTO Pers VALUES('Weiser','Hans','m','25 424324 M 924','Am Hain 99',77877,'Musterhofen',2)

INSERT INTO Kfz VALUES(1, 'Audi','A4','DU GN 111',59403,year(getdate())-2,dateadd(day,426,getdate()))
INSERT INTO Kfz VALUES(4, 'VW','Caddy','DU AH 678',75493,year(getdate())-4,dateadd(day,-4,getdate()))
INSERT INTO Kfz VALUES(3, 'Opel','Astra','DU PO 664',12738,year(getdate())-8,dateadd(day,654,getdate()))
INSERT INTO Kfz VALUES(7, 'Audi','A3','DU NJ 556',31232,year(getdate())-3,dateadd(day,-26,getdate()))
INSERT INTO Kfz VALUES(6, 'Audi','A3','DU NJ 557',43216,year(getdate())-4,dateadd(day,-22,getdate()))
INSERT INTO Kfz VALUES(5, 'BMW','X6','DU PB 840',32143,year(getdate())-1,dateadd(day,756,getdate()))
INSERT INTO Kfz VALUES(2, 'Audi','A3','DU NJ 555',43218,year(getdate())-5,dateadd(day,-12,getdate()))
INSERT INTO Kfz VALUES(8, 'Opel','Astra','ME PO 667',55462,year(getdate())-8,dateadd(day,-8,getdate()))
INSERT INTO Kfz VALUES(11, 'Opel','Astra','DU PO 661',43325,year(getdate())-8,dateadd(day,654,getdate()))
INSERT INTO Kfz VALUES(10, 'Opel','Astra','KR PO 668',66584,year(getdate())-8,dateadd(day,26,getdate()))
INSERT INTO Kfz VALUES(9, 'Opel','Astra','DU PO 665',66543,year(getdate())-8,dateadd(day,4,getdate()))

ALTER TABLE [pers] ADD CONSTRAINT [FK_kfz] 
	FOREIGN KEY([kfz]) REFERENCES [kfz] ([id])
SET NOCOUNT OFF