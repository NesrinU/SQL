CREATE DATABASE NewDB2
ON PRIMARY
(
		Name = N'NewDB2_F1',
		Filename = N'E:\Testdatabases\NewDB2_F1.mdf',
		Size = 10 MB,
		Filegrowth = 25%,
		Maxsize = 150 MB),
(
		Name = N'NewDB2_F2',
		Filename = N'G:\Testdatabases\NewDB2_F2.ndf',
		Size = 15 MB,
		Filegrowth = 10 MB,
		Maxsize = 1 GB)
LOG ON
(
		Name = N'NewDB2_Log',
Filename = N'F:\Testlogs\NewDB2_Log.ldf');

