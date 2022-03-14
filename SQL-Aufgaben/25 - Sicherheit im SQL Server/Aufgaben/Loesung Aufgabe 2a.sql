-- Aufgabe 2a

-- 1)
CREATE DATABASE SecurityTest;
GO

-- 2)
USE SecurityTest;
GO

-- Rollen db_dev, db_user_prod, db_user_store
CREATE ROLE db_dev;
EXEC sp_addrole 'db_user_prod';
CREATE ROLE db_user_store;

--Anwender steve, will, tom, jerry
CREATE LOGIN steve WITH PASSWORD = 'P@ssw0rd';
CREATE LOGIN will WITH PASSWORD = 'P@ssw0rd';
CREATE LOGIN tom WITH PASSWORD = 'P@ssw0rd';
CREATE LOGIN jerry WITH PASSWORD = 'P@ssw0rd';

CREATE USER steve FOR LOGIN steve;
CREATE USER will FOR LOGIN will;
CREATE USER tom FOR LOGIN tom;
CREATE USER jerry FOR LOGIN jerry;
GO

-- Schemas Produkte und Lager (Teil von Aufgabe 3)
CREATE SCHEMA Produkte AUTHORIZATION db_dev;
GO
CREATE SCHEMA Lager AUTHORIZATION db_dev;
GO


-- 3)
ALTER ROLE db_ddladmin
ADD MEMBER db_dev;
ALTER ROLE db_datareader
ADD MEMBER db_dev;
ALTER ROLE db_datawriter
ADD MEMBER db_dev;
-- Alternativ EXEC sp_addrolemember (veraltet)

GRANT 
	VIEW DEFINITION,
	CREATE ASSEMBLY,
	CREATE PROCEDURE,
	CREATE FUNCTION 
TO db_dev;

-- 4)
ALTER ROLE db_dev
ADD MEMBER steve;
ALTER ROLE db_dev
ADD MEMBER will;

-- 5)
ALTER ROLE db_user_prod
ADD MEMBER tom;

-- 6)
ALTER ROLE db_user_store
ADD MEMBER jerry;

-- 7)
ALTER USER steve
WITH DEFAULT_SCHEMA = dbo;

ALTER USER will
WITH DEFAULT_SCHEMA = dbo;

ALTER USER tom
WITH DEFAULT_SCHEMA = Produkte;

ALTER USER jerry
WITH DEFAULT_SCHEMA = Lager;

-- 8)
GRANT SELECT, INSERT, DELETE, UPDATE
ON SCHEMA::Produkte TO db_user_prod;

-- 9)
GRANT SELECT, INSERT, DELETE, UPDATE
ON SCHEMA::Lager TO db_user_store;
