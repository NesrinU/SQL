--Aufgabe 1
--Fügen Sie in der VM-Ware drei neue Festplatten zu Ihrer virtuellen Maschine hinzu. Legen Sie auf den Festplatten 1 den Ordner MDF, auf der Festplatte 2 den Ordner NDF1 und auf Festplatte 3 den Ordner NDF2 sowie den Ordner LDF an.
FERTIG
--Aufgabe 2
--Erstellen Sie eine neue Datenbank mit dem phantasievollen Namen „Neue Datenbank“. Es sollen folgende Eigenschaften für die Datenbank vorhanden sein:
---	Die ND.mdf soll im Ordner MDF liegen
---	Die ND.ldf Logdatei soll im Ordner LDF liegen
CREATE DATABASE [Neue Datenbank]
ON  PRIMARY 
(NAME = N'ND_MDF', 
FILENAME = N'F:\MDF\ND.mdf')
LOG ON 
( NAME = N'ND_LDF', 
FILENAME = N'H:\LDF\ND.ldf');

--Aufgabe 3
--Erstellen Sie eine Datenbank mit dem noch phantasievolleren Namen „Neue Datenbank 2“. Es sollen folgende Eigenschaften für die Datenbank vorhanden sein:
---	Die ND2.mdf soll im Ordner MDF liegen, die Startgröße der Datei soll 20 MB betragen, automatisch um 6 MB bei Bedarf erhöhen und eine Maximalgröße von 50 MB nicht überschreiten
---	Die ND2.ldf Logdatei soll im Ordner LDF liegen, eine Startgröße von 3 MB haben, automatisch bei Bedarf um 1 MB erhöhen und unbegrenzt groß werden dürfen 
CREATE DATABASE [Neue Datenbank 2]
ON  PRIMARY 
(NAME = N'ND2_MDF', 
FILENAME = N'F:\MDF\ND2.mdf',
SIZE = 20 MB,
MAXSIZE = 50 MB,
FILEGROWTH = 6 MB)
LOG ON 
( NAME = N'ND2_LDF', 
FILENAME = N'H:\LDF\ND2.ldf',
SIZE = 3 MB,
FILEGROWTH = 1 MB)
;

--Aufgabe 4
--Erstellen Sie eine Datenbank  „Neue Datenbank 3“. Es sollen folgende Eigenschaften für die Datenbank vorhanden sein:
---	Die ND3.mdf soll im Ordner MDF liegen, die Startgröße der Datei soll 10 MB betragen, automatisch um 5 MB bei Bedarf erhöhen und eine Maximalgröße von 50 MB nicht überschreiten
---	Die sekundären Dateien haben folgende Eigenschaften:
--Dateiname		Dateigruppe		Laufwerk	Ordner
--ND3Tab1.ndf	Tabelle1und2	2			NDF1
--ND3Tab2.ndf	Tabelle1und2	3			NDF2
--ND3Tab3		Tabelle3und4	3			NDF2
--ND3Tab4		Tabelle3und4	2			NDF1

---	Die ND3.ldf Logdatei soll im Ordner LDF liegen, eine Startgröße von 5 MB haben, automatisch bei Bedarf um 20 % erhöhen und unbegrenzt groß werden dürfen.
CREATE DATABASE [Neue Datenbank 3]
ON  PRIMARY 
(NAME = N'ND3_MDF', 
FILENAME = N'F:\MDF\ND3.mdf',
SIZE = 10 MB,
MAXSIZE = 50 MB,
FILEGROWTH = 5 MB
),
FILEGROUP [Tabelle1und2] 
(NAME = N'ND3Tab1', 
FILENAME = N'G:\NDF-1\ND3Tab1.ndf'
),
(NAME = N'ND3Tab2', 
FILENAME = N'H:\NDF-2\ND3Tab2.ndf'
),
FILEGROUP [Tabelle3und4] 
(NAME = N'ND3Tab3', 
FILENAME = N'H:\NDF-2\ND3Tab3.ndf'
), 
(NAME = N'ND3Tab4', 
FILENAME = N'G:\NDF-1\ND3Tab4.ndf'
)
LOG ON 
(NAME = N'ND3_LDF', 
FILENAME = N'H:\LDF\ND3.ldf',
SIZE = 5 MB,
FILEGROWTH = 20%)
;
