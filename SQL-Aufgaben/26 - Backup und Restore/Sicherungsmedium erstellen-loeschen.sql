/****** Objekt:  BackupDevice [BackUPStore1]    Skriptdatum: 10/24/2008 12:08:17 ******/
EXEC 
master.dbo.sp_addumpdevice  
@devtype = N'disk', 
@logicalname = N'BackUPStore1', 
@physicalname = N'C:\Databases2005\BackupStore1.bak'


EXEC 
master.dbo.sp_dropdevice 
   @logicalname = N'BackUPStore2'