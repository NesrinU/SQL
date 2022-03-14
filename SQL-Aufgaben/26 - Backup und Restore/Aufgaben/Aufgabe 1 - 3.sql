
--Aufgabe 1

--Machen Sie sich mit der WITH-Klausel für Backups vertraut (siehe Link in Folien)
--Aufgabe 2

--Erledigen Sie die folgenden Aufgaben mit der Oberfläche des SSMS: 
 
--1.	Legen Sie auf dem SQLSRV2 (alternativ aktuell installierter Server) eine neue Datenbank BackupTest an. 
--Die Datenbank soll das „vollständige Wiederherstellungsmodell“ verwenden.
CREATE DATABASE BackupTest;
GO
USE BackupTest;
GO
ALTER DATABASE BackupTest SET RECOVERY FULL;
GO 
--2.	Erstellen Sie ein Sicherungsmedium auf der Freigabe 
--\\SQLDC\Backup\ BackupTest.bak. Verwenden Sie dieses Sicherungsmedium für alle Sicherungen! (alternativ einen Ordner auf einer vorhandenen Festplatte wählen)
--BACKUP DATABASE [BackupTest] TO  DISK = N'C:\Backup\BackupTest.bak';
EXEC master.dbo.sp_addumpdevice  
	@devtype = N'disk', 
	@logicalname = N'BackupTest', 
	@physicalname = N'C:\Backup\BackupTest.bak'
GO
--3.	Legen Sie in der Datenbank eine Tabelle „Filme“ und eine Tabelle „Personen“ an.
SELECT * INTO Filme 
FROM Movies.dbo.MOV_FILM
WHERE 1=2;

SELECT * INTO Personen 
FROM Movies.dbo.MOV_PERSON
WHERE 1=2;

--4.	Kopieren Sie aus der Movie-Datenbank (Tabelle MOV_FILM) alle Filme, deren Titel  mit den Buchstaben  „a-f“ beginnen, in die Tabelle „Filme“. 
INSERT INTO Filme 
SELECT * FROM Movies.dbo.MOV_FILM
WHERE Movies.dbo.MOV_FILM.titel LIKE '[a-f]%'

SELECT * FROM Filme;
--5.	Erstellen Sie eine Vollsicherung der Datenbank. 
BACKUP DATABASE BackupTest
TO DISK = 'C:\Backup\Backuptest.bak'
WITH NAME = 'Vollsicherung bis F'; 
GO
--6.	Löschen Sie die Datenbank und stellen Sie diese anschließend aus der eben erstellten Sicherung wieder her. 
USE master;
GO
DROP DATABASE BackupTest;

RESTORE HEADERONLY
FROM DISK = 'C:\Backup\Backuptest.bak';

RESTORE DATABASE BackupTest
FROM DISK = 'C:\Backup\Backuptest.bak'
WITH FILE=1;

--7.	Fügen Sie an die Filmtabelle die Filme, deren Titel mit  „g-m“ beginnen an und erstellen Sie eine differentielle Sicherung. 
USE BackupTest;
GO
INSERT INTO Filme 
SELECT * FROM Movies.dbo.MOV_FILM
WHERE Movies.dbo.MOV_FILM.titel LIKE '[g-m]%';
GO
SELECT * FROM Filme;

BACKUP DATABASE BackupTest
TO DISK = 'C:\Backup\Backuptest.bak'
WITH DIFFERENTIAL, name = 'Diff g-m';
GO
--8.	Kopieren Sie alle Zeilen aus der Tabelle MOV_PERSON in die Tabelle „Personen“. Erstellen Sie eine weitere differentielle Sicherung.
INSERT INTO Personen 
SELECT * FROM Movies.dbo.MOV_PERSON;
GO
BACKUP DATABASE BackupTest
TO DISK = 'C:\Backup\Backuptest.bak'
WITH DIFFERENTIAL, name = 'Personen';

--9.	Löschen Sie die DB erneut und stellen Sie die DB aus den Sicherungen wieder her. Welche Sicherungen benötigen Sie dazu? 
USE master;
GO
DROP DATABASE BackupTest;

--Voll- und Diffr. Backups

RESTORE HEADERONLY
FROM DISK = 'C:\Backup\BackupTest.bak';

USE [master]
RESTORE DATABASE [BackupTest] 
FROM  DISK = N'C:\Backup\BackupTest.bak' 
WITH FILE = 1, NORECOVERY
GO
RESTORE DATABASE [BackupTest] 
FROM  DISK = N'C:\Backup\BackupTest.bak' 
WITH FILE = 3, RECOVERY

--10.	Fügen Sie nun die Filme, die mit „n-r“ beginnen an die Tabelle „Filme“ an.  
USE BackupTest;
GO
INSERT INTO Filme 
SELECT * FROM Movies.dbo.MOV_FILM
WHERE Movies.dbo.MOV_FILM.titel LIKE '[n-r]%'

SELECT * FROM Filme;

--11.	Sichern Sie das Transaktionsprotokoll. 

BACKUP LOG BackupTest
TO DISK = 'C:\Backup\BackupTest.bak'
WITH NAME = 'Transaktionsprotokoll';

--12.	Löschen Sie die Datenbank stellen Sie die DB aus den Sicherungen komplett wieder her. 
USE master;
GO
DROP DATABASE BackupTest;

RESTORE HEADERONLY
FROM DISK = 'C:\Backup\BackupTest.bak';

RESTORE DATABASE BackupTest
FROM DISK = 'C:\Backup\Backuptest.bak'
WITH  FILE = 1, NORECOVERY
RESTORE DATABASE [BackupTest] 
FROM  DISK = N'C:\Backup\BackupTest.bak' 
WITH  FILE = 3, NORECOVERY
RESTORE LOG [BackupTest] 
FROM  DISK = N'C:\Backup\BackupTest.bak' 
WITH  FILE = 4, RECOVERY
GO
--13.	Nun fügen Sie auch noch die restlichen Filme hinzu, erstellen erneut eine Sicherung des Transaktionsprotokolls.
USE BackupTest;
GO
INSERT INTO Filme 
SELECT * FROM Movies.dbo.MOV_FILM
WHERE Movies.dbo.MOV_FILM.titel NOT LIKE '[a-r]%'

SELECT * FROM Filme;

BACKUP LOG BackupTest
TO DISK = 'C:\Backup\Backuptest.bak'
WITH NAME = 'Reste Filme';
--14.	Löschen Sie die Tabelle „Filme“ und stellen Sie die Daten aus den Sicherungen wieder her.
DROP TABLE Filme;

RESTORE HEADERONLY
FROM DISK = 'C:\Backup\BackupTest.bak';

USE master;
GO
RESTORE DATABASE BackupTest
FROM DISK = 'C:\Backup\Backuptest.bak'
WITH  FILE = 1, NORECOVERY, REPLACE
RESTORE DATABASE [BackupTest] 
FROM  DISK = N'C:\Backup\BackupTest.bak' 
WITH  FILE = 3, NORECOVERY 
RESTORE LOG [BackupTest] 
FROM  DISK = N'C:\Backup\BackupTest.bak' 
WITH  FILE = 4, NORECOVERY 
RESTORE LOG [BackupTest]
FROM DISK = 'C:\Backup\Backuptest.bak'
WITH RECOVERY, FILE = 5 

--Aufgabe 3 
--Wiederholen Sie die Schritte aus der ersten Aufgabe, aber verwenden Sie ausschließlich (soweit möglich) T-SQL-Kommandos. 
 






