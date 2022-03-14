CREATE DATABASE Test
ON PRIMARY 
	(
		NAME = N'Primaerfile',
		FILENAME = N'C:\Test\primaerfile.mdf'
	)
,
FILEGROUP [SekFile]
	(
		NAME = N'Sekundaerfile',
		FILENAME = N'C:\Test\Sekundaerfile.ndf'
	)
LOG ON
	(
		NAME = N'Protokollierung',
		FILENAME = N'C:\Test\Protokollierung.ldf'
	);
