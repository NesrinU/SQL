﻿/*   INDEX SEEK     */

create table website_visitor
(
visitor_id int,
ad varchar(50),
soyad varchar(50),
phone_number bigint,
city varchar(50)
);

DECLARE @i int = 1
DECLARE @RAND AS INT
WHILE @i<200000
BEGIN
	SET @RAND = RAND()*81
	INSERT website_visitor
		SELECT @i , 'visitor_name' + cast (@i as varchar(20)), 'visitor_surname' + cast (@i as varchar(20)),
		5326559632 + @i, 'city' + cast(@RAND as varchar(2))
	SET @i +=1
END;



set statistics io on 
set statistics time on
select * from website_visitor
where [ad]= 

sp_spaceused website_visitor



--------------

DECLARE @I AS INT=0
WHILE @I < 10000
BEGIN
DECLARE @AD AS VARCHAR (50)
DECLARE @SOYAD VARCHAR (50)
DECLARE @DOGUMTARIHI DATE
DECLARE @YAS AS INT
DECLARE @YASGRUBU AS VARCHAR (30)
DECLARE @EPOSTA AS VARCHAR (30)
DECLARE @EPOSTAT AS VARCHAR (30)
DECLARE @STATE AS VARCHAR(30)
DECLARE @CITY AS VARCHAR (30)
DECLARE @STREET AS VARCHAR (50)
DECLARE @ZIP AS INT	
DECLARE @PHONE AS INT
SELECT @AD=AD FROM ISIMLER WHERE ID =ROUND(RAND() * 1676,0)
SELECT @SOYAD=SOYISIM FROM SOYISIMLER WHERE ID =ROUND(RAND() * 1676,0)
SELECT @EPOSTA=EMAILDOMAIN FROM EMAIL WHERE ID =ROUND(RAND() * 9,0)
SELECT @STREET=STREET FROM STREET WHERE ID =ROUND(RAND() * 1000,0)
SELECT @CITY=CITY, @STATE=STATENAME FROM STATE WHERE ID =ROUND(RAND() * 50,0)
SET @ZIP= ROUND(RAND()*99999,0);
SET @DOGUMTARIHI= DATEADD (DAY, ROUND(RAND()*18250,0),'1950-01-01')
SET @YAS =DATEDIFF(YEAR, @DOGUMTARIHI,GETDATE())
SET @EPOSTAT = @AD+ @SOYAD+'@'+@EPOSTA
SET @PHONE = ROUND(RAND()*10000000,0);
IF @YAS BETWEEN 10 AND 20
SET @YASGRUBU ='KUCUK'
	IF @YAS BETWEEN 21 AND 40
SET @YASGRUBU ='ORTA YAS'
	IF @YAS BETWEEN 41 AND 60
SET @YASGRUBU ='BUYUK'
	IF @YAS >60
SET @YASGRUBU ='YAŞLI'
INSERT INTO KISILER (AD, SOYISIM, DOGUMTARIHI, YAS, YASGRUBU,EPOSTA, STATENAME, CITY, STREET, ZIP, PHONE) VALUES (@AD, @SOYAD, @DOGUMTARIHI, @YAS, @YASGRUBU, @EPOSTAT, @STATE, @CITY, @STREET,@ZIP, @PHONE)
SET @I=@I+1
END