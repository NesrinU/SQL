--Aufgabe 1
--Die Aufgabe bezieht sich auf die Container-Tabelle in der Datenbank TeachSQL
USE Container;

SELECT * FROM tbl_Container;

--1.	Erstellen Sie eine Funktion, die die Oberfläche eines Containers ermittelt.
CREATE FUNCTION fn_Oberfläche(@ContID INT)
RETURNS INT 
AS
BEGIN
	DECLARE  @Oberfläche INT
	SELECT @Oberfläche = (Length * Width) AS Oberfläche-mm2 FROM tbl_Container WHERE @ContID = ContID
RETURN  @Oberfläche 
END

SELECT dbo.fn_Oberfläche(7);
--2.	Erstellen Sie eine Funktion, die mm² in m² umrechnet.
CREATE ALTER FUNCTION fn_Convert_mm2(@mm2 INT)
RETURNS INT 
AS
BEGIN
	DECLARE  @m2 DECIMAL(6,2)
	SELECT @m2 = (@mm2 / 1000000)
RETURN  @m2
END;

SELECT dbo.fn_Convert_mm2(159357123);
--3.	Erstellen Sie eine Funktion, die m² in mm² umrechnet.
CREATE FUNCTION fn_Convert_m2(@m2 INT)
RETURNS INT 
AS
BEGIN
	DECLARE  @mm2 INT
	SELECT @mm2 = (@m2 * 1000000)
RETURN  @mm2
END;

SELECT dbo.fn_Convert_m2(159);
--4.	Zusatzaufgabe: Erstellen Sie eine Funktion, die in der Lage ist, in beide Richtungen umzurechnen. Dazu muss die Funktion als zweiten Parameter die „Richtung“ erhalten.
CREATE FUNCTION fn_Convert_m2_mm2(@wert INT, @richtung VARCHAR)
RETURNS INT 
AS
BEGIN
	DECLARE  @umrechnung INT
	IF @richtung = 'm2'
		SELECT @umrechnung = (@wert / 1000000)
	ELSE IF @richtung = 'mm2'
		SELECT @umrechnung = (@wert * 1000000)
RETURN  @umrechnung
END;

SELECT dbo.fn_Convert_m2_mm2(159,'mm2');

--Aufgabe 2
--Die Aufgabe bezieht sich auf Tabellen in der Datenbank pro_angSQL
USE pro_angSQL;
SELECT * FROM pro;
GO
SELECT * FROM pro_ang;
GO
SELECT * FROM ang;
GO
SELECT * FROM abt;

--Erstellen Sie eine Inline-Funktion, die auflistet in welchen Projekten ein Mitarbeiter wie viel seiner Zeit aufwendet. Die Funktion soll als Parameter die a_nr des Mitarbeiters entgegen nehmen.
CREATE FUNCTION fn_angzeit(@a_nr INT)
RETURNS TABLE 
AS 
RETURN 
	SELECT ang.a_nr,ang.name, pro.p_beschr, pro_ang.proz_arb 
	FROM ang
	INNER JOIN pro_ang
	ON ang.a_nr = pro_ang.a_nr
	INNER JOIN pro
	ON pro_ang.p_nr = pro.p_nr
	WHERE ang.a_nr = @a_nr;

SELECT * FROM dbo.fn_angzeit(117);
--Aufgabe 3
--Die Aufgabe bezieht sich auf Tabellen in der Datenbank Personal.
USE Personal;
SELECT * FROM personen;

--•	Führen Sie das Skript „14-Personen-Leerzeichen.sql“ aus.
--Sie bekommen aus der Personalabteilung immer wieder Tabellen, in deren Spalten unnötige, führende und folgende Leerzeichen enthalten sind. 
--1.	Schreiben Sie eine Funktion, die die Leerzeichen vor und nach dem eigentlichen Wert entfernt.
BEGIN TRAN
UPDATE personen SET Vorname = LTRIM(RTRIM(Vorname));
ROLLBACK

CREATE alter FUNCTION fn_LeerEnt(@data VARCHAR)
RETURNS TABLE 
AS 
RETURN 
	SELECT LTRIM(RTRIM(@data)) FROM personen;

SELECT * FROM dbo.fn_LeerEnt(personen.Vorname);

--2.	Testen Sie die Funktion an der Tabelle „Personen“ mit einer SELECT-Anweisung.


--3.	Aktualisieren Sie die Tabelle „Personen“ mit dieser Funktion.
