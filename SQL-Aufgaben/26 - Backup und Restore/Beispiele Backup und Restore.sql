USE NordwindSQL;


SELECT * FROM Artikel;

-- Vollständige Sicherung
BACKUP DATABASE NordwindSQL
TO DISK = 'H:\Backup\northwindbackup.bak';

-- Änderungen an Tabelle vornehmen
UPDATE Artikel
SET Artikelname = 'Schai'
WHERE [Artikel-Nr] = 1;

SELECT * FROM Artikel;

-- Differentielles Backup
BACKUP DATABASE NordwindSQL
TO DISK = 'H:\Backup\northwindbackup.bak'
WITH DIFFERENTIAL;

-- Weitere Änderungen
UPDATE Artikel
SET Artikelname = 'Komischer Tee'
WHERE [Artikel-Nr] = 1;

SELECT * FROM Artikel;


-- Transaktionsprotokollsicherung
BACKUP LOG NordwindSQL
TO DISK = 'H:\Backup\northwindbackup.bak';


USE master;

DROP DATABASE NordwindSQL;


-- Was ist in der Sicherungsdatei?
RESTORE HEADERONLY
FROM DISK = 'H:\Backup\northwindbackup.bak';


-- Wiederherstellen
RESTORE DATABASE NordwindSQL 
FROM DISK = 'H:\Backup\northwindbackup.bak';

USE NordwindSQL;

SELECT * FROM Artikel;


-- Wiederherstellen bis differentielle Sicherung
RESTORE DATABASE NordwindSQL 
FROM DISK = 'H:\Backup\northwindbackup.bak'
WITH NORECOVERY, FILE = 1;

RESTORE DATABASE NordwindSQL 
FROM DISK = 'H:\Backup\northwindbackup.bak'
WITH NORECOVERY, FILE = 2;

RESTORE DATABASE NordwindSQL 
WITH RECOVERY;


USE NordwindSQL;

SELECT * FROM Artikel;



USE master;

DROP DATABASE NordwindSQL;

-- Wiederherstellung bis einschl. TAP
RESTORE DATABASE NordwindSQL 
FROM DISK = 'H:\Backup\northwindbackup.bak'
WITH NORECOVERY, FILE = 1;

RESTORE DATABASE NordwindSQL 
FROM DISK = 'H:\Backup\northwindbackup.bak'
WITH NORECOVERY, FILE = 2;

RESTORE DATABASE NordwindSQL 
FROM DISK = 'H:\Backup\northwindbackup.bak'
WITH RECOVERY, FILE = 3;



USE NordwindSQL;

SELECT * FROM Artikel;
