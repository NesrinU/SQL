use master;
GO
--Aufgabe 2.1
CREATE DATABASE BackupTest;
GO
ALTER DATABASE backuptest
SET RECOVERY FULL;
GO

--Aufgabe 2.2
USE [master]
GO

EXEC master.dbo.sp_addumpdevice  
	@devtype = N'disk', 
	@logicalname = N'TestBackup', 
	@physicalname = N'\\sqldc\Backup\Testbackup.bak'
GO

--Aufgabe 2.3
USE backuptest;
GO

SELECT * INTO Filme
FROM Movies.dbo.MOV_FILM
WHERE 1=2

SELECT * INTO Person
FROM Movies.dbo.MOV_Person
WHERE 1=2

--Aufgabe 2.4
INSERT INTO Filme
SELECT * FROM Movies.dbo.MOV_FILM
WHERE titel LIKE '[a-f]%';

--Aufgabe 2.5
BACKUP DATABASE backuptest
TO [TestBackup]
WITH name = 'Vollsicherung bis F',
	INIT
GO

--Aufgabe 2.6
USE master;
GO

DROP DATABASE BackupTest;

RESTORE HEADERONLY
FROM testBackup;

RESTORE DATABASE BackupTest
FROM TestBackup
WITH RECOVERY, 
	FILE = 1

--Aufgabe 2.7
USE BackupTest;
GO

INSERT INTO Filme
SELECT * FROM Movies.dbo.MOV_FILM
WHERE titel LIKE '[g-m]%';

BACKUP DATABASE BackupTest
TO Testbackup
WITH DIFFERENTIAL, NOINIT, name = 'Diff g-m';

--Aufgabe 2.8
INSERT INTO Person
SELECT * FROM Movies.dbo.MOV_Person;

BACKUP DATABASE BackupTest
TO Testbackup
WITH DIFFERENTIAL, NOINIT, name = 'Personen';

--Aufgabe 2.9
RESTORE HEADERONLY 
FROM testbackup

USE master;
GO
DROP DATABASE BackupTest;

RESTORE DATABASE Backuptest
FROM Testbackup
WITH NORECOVERY, FILE =1
GO

RESTORE DATABASE Backuptest
FROM Testbackup
WITH RECOVERY, FILE =3
GO

USE backuptest;
GO

SELECT * FROM filme
ORDER BY titel DESC

SELECT * FROM Person;

--Aufgabe 2.10
INSERT INTO Filme
SELECT * FROM Movies.dbo.MOV_FILM
WHERE titel LIKE '[n-r]%';

--Aufgabe 2.11
BACKUP LOG backuptest
TO testbackup
WITH NOINIT,
name = 'Filme n - r';

--Aufgabe 2.12
USE master;

RESTORE HEADERONLY 
FROM testBackup
;

DROP DATABASE Backuptest;

RESTORE DATABASE Backuptest
FROM Testbackup
WITH NORECOVERY, FILE =1
GO

RESTORE DATABASE Backuptest
FROM Testbackup
WITH NORECOVERY, FILE =3
GO

RESTORE LOG Backuptest
FROM Testbackup
WITH NORECOVERY, FILE =4
GO

--RECOVERY vergessen!
RESTORE DATABASE backuptest
WITH RECOVERY;

--alles wieder gut
USE Backuptest;
GO

SELECT * FROM filme
ORDER BY titel DESC

SELECT * FROM Person;

--Aufgabe 2.13
INSERT INTO Filme
SELECT * FROM Movies.dbo.MOV_FILM
WHERE titel NOT LIKE '[a-r]%';

BACKUP LOG backuptest
TO testbackup
WITH NOINIT,
name = 'restliche Filme';

--Aufgabe 2.14
USE Backuptest;
GO

DROP TABLE Filme;

USE master;
GO

BACKUP LOG Backuptest
TO testbackup
WITH NOINIT, NO_TRUNCATE, NORECOVERY;

RESTORE HEADERONLY FROM testbackup;

RESTORE DATABASE Backuptest
FROM Testbackup
WITH NORECOVERY, FILE =1
GO

RESTORE DATABASE Backuptest
FROM Testbackup
WITH NORECOVERY, FILE =3
GO

RESTORE LOG Backuptest
FROM Testbackup
WITH NORECOVERY, FILE =4
GO

RESTORE LOG Backuptest
FROM Testbackup
WITH NORECOVERY, FILE =5
GO

RESTORE LOG Backuptest
FROM Testbackup
WITH RECOVERY, FILE =6
GO

USE backuptest
GO

SELECT * FROM filme;
--Ups, Fehler gemacht . In diesem Fall besser kein RESTORE des letzten LOGS (Löschbefehl)

--Neuer Versuch
USE MAster;
GO
RESTORE DATABASE Backuptest
FROM Testbackup
WITH NORECOVERY, FILE =1, REPLACE
GO

RESTORE DATABASE Backuptest
FROM Testbackup
WITH NORECOVERY, FILE =3
GO

RESTORE LOG Backuptest
FROM Testbackup
WITH NORECOVERY, FILE =4
GO

RESTORE LOG Backuptest
FROM Testbackup
WITH RECOVERY, FILE =5
GO

RESTORE VERIFYONLY FROM TestBackup;

RESTORE FILELISTONLY FROM TestBackup;

