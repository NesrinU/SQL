USE [TeachSQL]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblDevice]') AND type in (N'U'))
DROP TABLE [dbo].[tblDevice]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblVendor]') AND type in (N'U'))
DROP TABLE [dbo].[tblVendor]
GO


CREATE TABLE tblVendor
(
	ID			INT				CONSTRAINT PK_VENDOR PRIMARY KEY NONCLUSTERED,
	Name		VARCHAR(100)	NOT NULL
);
GO
CREATE CLUSTERED INDEX IDX_NAME ON tblVendor(Name);
GO
INSERT INTO tblVendor VALUES (1,'Apple'),(2,'Compaq/HP'),(3,'Lenovo'),(4,'DELL'),(5,'Samsung'),(6,'Asus'),(7,'Toshiba'),(8,'Sony');
GO

CREATE TABLE tblDevice
(
	ID			INT				IDENTITY CONSTRAINT PK_DEVICE PRIMARY KEY NONCLUSTERED,
	Name		VARCHAR(100)	NOT NULL,
	Location    VARCHAR(100)	NOT NULL,
	VendorID	INT	NULL
);
CREATE CLUSTERED INDEX IDX_DEVICE_NAME ON tblDevice(Name);
GO
INSERT INTO tblDevice (Name, Location, VendorID) VALUES 
('iPad (Gen1)','Office - Schwab',1),
('iPad (Gen2)','Office - Schwab',1),
('iPad (Gen3)','Office - Schwab',1),
('iPhone 4s','Office - Schwab',1),
('iMac - 2011','Home-Office - Schwab',1),
('MacBook Pro - 2012','Home-Office - Schwab',1),
('PS3','Home-Office - Paul',8),
('PS Vita','Home-Office - Paul',8),
('Laptop - 08/15','Office - Paul',2),
('Radio','Office - Voß',5),
('Switch - 10Mbit','Office - Voß', 12),
('Bridge - 10Mbit','Office - Voß', 100);
GO
-------------------------------------------------------------------------------
-- Lösungen
-------------------------------------------------------------------------------

-- Hersteller und Geräte in den Büros
SELECT
	d.Location,
	v.Name Vendor, 
	d.Name Device
FROM 
	tblVendor v
INNER JOIN
	tblDevice d
ON v.ID = d.VendorID


-- Hersteller ohne Geräte in den Büros

SELECT
	v.Name
FROM 
	tblVendor v
LEFT OUTER JOIN
	tblDevice d
ON v.ID = d.VendorID
WHERE d.VendorID IS NULL

-- oder 

SELECT
	v.Name
FROM 
	tblDevice d	
RIGHT OUTER JOIN
	tblVendor v
ON v.ID = d.VendorID
WHERE d.VendorID IS NULL

-- Geräte in den Büros ohne gültigen Hersteller
SELECT
	D.Name, D.Location
FROM 
	tblVendor v
RIGHT OUTER JOIN
	tblDevice d
ON v.ID = d.VendorID
WHERE v.ID IS NULL

-- oder 

SELECT
	D.Name, D.Location
FROM 
	tblDevice d
LEFT OUTER JOIN
	tblVendor v
ON v.ID = d.VendorID
WHERE v.ID IS NULL

-- Hersteller korrigieren
--Aufgabe 3
select tblDevice.name from tblVendor right outer join tblDevice
on tblDevice.VendorID = tblVendor.ID
where tblVendor.id is null
-- oder where tblVendor.name is null

--Alternative
select tblDevice.name from tblDevice left outer join tblVendor
on tblDevice.VendorID = tblVendor.ID
where tblVendor.id is null

-- 'Toshiba'  in der Anzeige zuordnen
select tbldevice.name as Gerätename, 
case 
when tblvendor.name is null then 'Toshiba' 
end as Hersteller
from tbldevice
left outer join tblvendor
on tbldevice.vendorid = tblvendor.id
where tblvendor.name is null


update tbldevice
set vendorID = 
(select ID from tblvendor where Name = 'Toshiba')
where ID in (select tbldevice.id
From
tblDevice AS d
left outer join tblvendor as v
on v.id = d.vendorid
where v.id is null and tbldevice.Name is null)
go


select * from tblvendor where Name in (select tblDevice.name from tblVendor right outer join tblDevice
on tblDevice.VendorID = tblVendor.ID
where tbldevice.id is null)

update tbldevice
set vendorID = 
(select ID from tblvendor where Name = 'Toshiba')
where ID in (select tbldevice.id
From
tblDevice AS d
left outer join tblvendor as v
on v.id = d.vendorid
where v.id is null and tbldevice.Name is null)
go


UPDATE tblDevice 
 SET VendorID = (SELECT ID FROM tblVendor WHERE Name = 'Toshiba')
 WHERE
 ID IN (
SELECT
	D.ID
FROM 
	tblDevice d
LEFT OUTER JOIN
	tblVendor v
ON v.ID = d.VendorID
WHERE v.ID IS NULL
);


-- Aufgabe 4
alter table tbldevice add
CONSTRAINT FK_VENDOR FOREIGN KEY (VendorID) REFERENCES tblVendor(ID)

-- Foreign Key erstellen
ALTER TABLE tblDevice ADD CONSTRAINT FK_VENDOR FOREIGN KEY (VendorID) REFERENCES tblVendor(ID);
GO



