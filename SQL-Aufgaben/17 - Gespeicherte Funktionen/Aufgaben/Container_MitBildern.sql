---------------------------------------------------------
-- (c) 2008
-- Achtung!!!!!!!!!!!!!!!!!!! 
-- Dieses Beispiel benötigt die Bild-Dateien aus
-- dem Ordner "ContainerBilder" aus dem Übungsordner.
-- Kopieren Sie den Ordner direkt nach C:\, so dass
-- der volle Pfad "C:\ContainerBilder" lautet!
---------------------------------------------------------

IF not EXISTS (
  SELECT * 
    FROM sys.databases 
   WHERE name = N'Container'
)
CREATE DATABASE Container
GO
Use Container
GO

IF OBJECT_ID('tbl_Container', 'U') IS NOT NULL
  DROP TABLE [tblContainer]
GO

CREATE TABLE [tbl_Container] 
(
	[ContID]		int identity(1,1) primary key,
	[CType]			varchar(50) not null,			
	[Length]		float not null default 0,			-- in mm
	[Width]			float not null default 0,			-- in mm
	[Height]		float not null default 0,			-- in mm
	[TareWeight]	float not null default 0,		-- in kg
	MaxGrossWeight	float not null default 0,	-- in kg
	[Pic]			varbinary(max) not null
)
GO

INSERT INTO [tbl_Container] ([CType],[Length],[Width],[Height],[TareWeight],[MaxGrossWeight],[Pic])
	SELECT 'Standard-Container',5895,2350,2392,2250,30480,BulkColumn from Openrowset( Bulk 'C:\ContainerBilder\cont1.jpg', Single_Blob) as Pic
INSERT INTO [tbl_Container] ([CType],[Length],[Width],[Height],[TareWeight],[MaxGrossWeight],[Pic])
	SELECT 'Tank-Container',6058,2438,2438,4190,30480,BulkColumn from Openrowset( Bulk 'C:\ContainerBilder\conttank.jpg', Single_Blob) as Pic
INSERT INTO [tbl_Container] ([CType],[Length],[Width],[Height],[TareWeight],[MaxGrossWeight],[Pic])
	SELECT 'High-Cube-Container',12024,2350,2697,4020,30480,BulkColumn from Openrowset( Bulk 'C:\ContainerBilder\cont3.jpg', Single_Blob) as Pic
INSERT INTO [tbl_Container] ([CType],[Length],[Width],[Height],[TareWeight],[MaxGrossWeight],[Pic])
	SELECT 'Hardtop-Container',5886,2342,2388,2700,30480,BulkColumn from Openrowset( Bulk 'C:\ContainerBilder\cont3.jpg', Single_Blob) as Pic
INSERT INTO [tbl_Container] ([CType],[Length],[Width],[Height],[TareWeight],[MaxGrossWeight],[Pic])
	SELECT 'Open Top-Container',5897,2350,2377,2350,30480,BulkColumn from Openrowset( Bulk 'C:\ContainerBilder\cont4.jpg', Single_Blob) as Pic
INSERT INTO [tbl_Container] ([CType],[Length],[Width],[Height],[TareWeight],[MaxGrossWeight],[Pic])
	SELECT 'Isolier- und Kühl-Container',5770,2260,2110,2900,24100,BulkColumn from Openrowset( Bulk 'C:\ContainerBilder\cont91.jpg', Single_Blob) as Pic
INSERT INTO [tbl_Container] ([CType],[Length],[Width],[Height],[TareWeight],[MaxGrossWeight],[Pic])
	SELECT 'Bulk-Container',5931,2358,2326,2370,24000, BulkColumn from Openrowset( Bulk 'C:\ContainerBilder\cont10.jpg', Single_Blob) as Pic
GO




select * from tbl_Container