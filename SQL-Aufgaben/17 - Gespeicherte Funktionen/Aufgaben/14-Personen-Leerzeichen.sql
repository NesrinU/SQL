USE Personal
GO

SELECT PersVorname AS Vorname, PersNachname AS Nachname, PersStrasse AS Strasse,
	PersPLZ AS PLZ, PersOrt AS Ort
INTO personen
FROM dbo.tblPersonal
GO

CREATE PROCEDURE SF_Personen
AS
BEGIN
	DECLARE @vorname varchar(50), @nachname  varchar(50),
			@strasse  varchar(50), @ort varchar(40) 
	DECLARE  test CURSOR  FORWARD_ONLY 
	FOR SELECT Vorname, 
			Nachname, 
			Strasse, 
			Ort
		FROM personen
	FOR UPDATE
	OPEN test
	FETCH NEXT FROM test INTO @vorname, @nachname, @strasse, @ort

	WHILE @@fetch_status = 0
	BEGIN
		UPDATE dbo.personen
		SET Vorname = SPACE(CAST(RAND()*10 AS int))+Vorname+SPACE(CAST(RAND()*10AS int)),
			 Nachname = SPACE(CAST(RAND()*10 AS int))+Nachname+SPACE(CAST(RAND()*10AS int)),
			 STrasse = SPACE(CAST(RAND()*10 AS int))+Strasse+SPACE(CAST(RAND()*10AS int)),
			 ORT = SPACE(CAST(RAND()*10 AS int))+Ort+SPACE(CAST(RAND()*10AS int))
		WHERE CURRENT of test

		FETCH NEXT FROM test INTO @vorname, @nachname, @strasse, @ort
	END
	CLOSE test
	DEALLOCATE test
END
GO

EXEC SF_Personen
GO

SELECT * FROM personen
