-- Master Datenbank nutzen
USE master;
GO

--Aufgabe 1.1
CREATE LOGIN SecAdmin1
WITH PASSWORD = 'P@ssw0rd';

CREATE LOGIN SecAdmin2
WITH PASSWORD = 'P@ssw0rd';

CREATE LOGIN SecAdmin3
WITH PASSWORD = 'P@ssw0rd';

--Aufgabe 2
CREATE SERVER ROLE LoginAdmins;

CREATE SERVER ROLE DatabaseAdmins;

--Aufgabe 3
EXEC sp_srvrolepermission;
SELECT * FROM sys.server_permissions;

--EXEC sp_dbfixedrolepermission;
--habe fertig geguckt

--Aufgabe 4
GRANT ALTER ANY LOGIN 
TO LoginAdmins;

--Aufgabe 5
GRANT ALTER ANY DATABASE
TO DatabaseAdmins;

--Aufgabe 6
ALTER SERVER ROLE LoginAdmins
ADD MEMBER SecADmin1;

ALTER SERVER ROLE DatabaseAdmins
ADD MEMBER SecADmin2;

--Aufgabe 7
GRANT ALTER ON SERVER ROLE::DatabaseAdmins
TO SecADmin3;

--Aufgabe 8
SELECT SUSER_NAME()
--secadmin1
EXECUTE AS LOGIN = 'SecAdmin1';
ALTER LOGIN SecADmin2
WITH PASSWORD = 'P@ssw0rd';

CREATE LOGIN blubb2
WITH PASSWORD = 'P@ssw0rd'

--geht nicht
DROP DATABASE BackupTest;
SELECT SUSER_NAME()

REVERT;
--SecADmin2
EXECUTE AS LOGIN = 'SecAdmin2';
CREATE DATABASE blubb1;

ALTER DATABASE BackupTest
SET RECOVERY Simple;

--geht nicht
DROP LOGIN blubb2;

SELECT SUSER_NAME()
REVERT;

--SecADmin3
EXECUTE AS LOGIN = 'SecAdmin3';
SELECT SUSER_NAME()

ALTER SERVER ROLE DatabaseADmins
ADD MEMBER blubb2;

DROP LOGIN blubb2;
REVERT;

--Aufgabe 9
SELECT * FROM sys.server_principals;

--Aufgabe 10
SELECT * FROM sys.sql_logins;

--Aufgabe 11
SELECT * FROM sys.server_principals AS p
INNER JOIN sys.server_permissions pe
ON p.principal_id = pe.grantee_principal_id
WHERE name = 'DatabaseAdmins'

--Aufgabe 12
SELECT * FROM sys.server_principals AS p
INNER JOIN sys.server_permissions pe
ON p.principal_id = pe.grantee_principal_id
WHERE name = 'LoginAdmins'

SELECT SUSER_NAME();

EXEC sp_srvrolepermission 'SecurityAdmin';

--Aufgabe 13
ALTER SERVER ROLE LoginAdmins
ADD MEMBER SecAdmin3;


--Aufgabe 14
DENY ALTER ON LOGIN::SecAdmin2
TO SecAdmin3;


--AFugabe 15
EXECUTE AS LOGIN = 'SecAdmin3';
ALTER LOGIN SecAdmin2
WITH DEFAULT_DATABASE = [master];
REVERT;

SELECT SUSER_NAME();

--Aufgabe 16
DENY CONNECT SQL TO [SecAdmin3];
