/*    SQL Programming 

create proc procedure_name
as
sql_statement
Go

*/
CREATE PROCEDURE sp_FirstProc AS
BEGIN
	SELECT 'Welcome to procedural world.' AS message
END

EXECUTE sp_FirstProc

sp_FirstProc

ALTER PROCEDURE sp_FirstProc as
BEGIN
	PRINT 'Welcome to procedural world.' 
END

DROP PROCEDURE sp_FirstProc

---------


create PROC sp_sampleproc1 as
select 'Welcome' as [message]

sp_sampleproc1

EXEC sp_sampleproc1

EXECUTE sp_sampleproc1

Create proc sp_sampleproc2 as
print 'welcome'

sp_sampleproc2


SET NOCOUNT OFF


Create proc sp_sampleproc3 as 
Begin
     select 'welcome' as [message]
end 

drop proc sp_sampleproc3

drop proc sp_sampleproc1

drop proc sp_sampleproc2


CREATE TABLE ORDER_TBL
(
ORDER_ID TINYINT NOT NULL,
CUSTOMER_ID TINYINT NOT NULL,
CUSTOMER_NAME VARCHAR(50),
ORDER_DATE DATE,
EST_DELIVERY_DATE DATE--estimated delivery date
);

INSERT ORDER_TBL VALUES (1, 1, 'Adam', GETDATE()-10, GETDATE()-5 ),
						(2, 2, 'Smith',GETDATE()-8, GETDATE()-4 ),
						(3, 3, 'John',GETDATE()-5, GETDATE()-2 ),
						(4, 4, 'Jack',GETDATE()-3, GETDATE()+1 ),
						(5, 5, 'Owen',GETDATE()-2, GETDATE()+3 ),
						(6, 6, 'Mike',GETDATE(), GETDATE()+5 ),
						(7, 7, 'Rafael',GETDATE(), GETDATE()+5 ),
						(8, 8, 'Johnson',GETDATE(), GETDATE()+5 )




CREATE TABLE ORDER_DELIVERY
(
ORDER_ID TINYINT NOT NULL,
DELIVERY_DATE DATE -- tamamlanan delivery date
)

INSERT ORDER_DELIVERY VALUES (1, GETDATE()-6 ),
				(2, GETDATE()-2 ),
				(3, GETDATE()-2 ),
				(4, GETDATE() ),
				(5, GETDATE()+2 ),
				(6, GETDATE()+3 ),
				(7, GETDATE()+5 ),
				(8, GETDATE()+5 )


CREATE PROC sp_sampleproc3 AS
BEGIN
	SELECT MAX(ORDER_ID) AS LAST_ORDER FROM ORDER_TBL
END
EXEC sp_sampleproc3
INSERT ORDER_TBL VALUES(9,9, NULL , NULL, NULL)

----
-- order_tbl tablosunda istedigim gune ait siparis sayisini döndürsün

create proc sp_sampleproc4 (@DAY date)
as
begin
     select count(ORDER_ID) as CNT_ORDER from ORDER_TBL where ORDER_DATE= @DAY
end

select * from ORDER_TBL


------
alter proc sp_sampleproc4 (@DAY date)
as
begin
     select count(ORDER_ID)  as CNT_ORDER, ORDER_DATE from ORDER_TBL where ORDER_DATE= @DAY group by order_date
end

EXEC sp_sampleproc4 '2022-03-01'

----istenilen müsterinin istenilen tarihteki siparislerini döndüren bir prosedür yazin.

ALTER PROC sp_sampleproc5 (@name NVARCHAR(MAX), @date DATE = NULL)
AS
BEGIN
	SELECT * FROM ORDER_TBL WHERE CUSTOMER_NAME = @name AND ORDER_DATE = @date
END


exec sp_sampleproc5  'Jack', '2022-03-01'

select * from ORDER_TBL

-------
DECLARE @V1 INT 
DECLARE @V2 INT
DECLARE @RESULT INT

SET @V1 = 5
SET @V2 = 6
SET @RESULT = @V1* @V2

SELECT @RESULT  AS RESULT
----
Declare @V1 int , @V2 int, @Result int
----
Declare @V1 int= 5 , @V2 int= 6, @Result int
set @Result= @V1* @V2
select @result
------

Declare @V1 int= 5 , @V2 int= 6, @Result int
select @Result= @V1* @V2
select @result
----

Declare @V1 int , @V2 int, @Result int
select @V1= 5, @V2= 6 , @Result= @V1 * @V2
select  @result
----

Declare @V1 int= 5
select *
from ORDER_TBL
where ORDER_ID= @V1

---------
----------
/* CONDITION 

IF CONDITION 
   SQL_SYNTAX
ELSE
   SQL_SYNTAX

------

IF CONDITION1
   SQL_SYNTAX
ELSE IF CONDITION2
   SQL_SYNTAX
ELSE IF CONDITION3 
   SQL_SYNTAX
ELSE
   SQL_SYNTAX
   */

IF DATENAME(weekday, GETDATE()) IN (N'Saturday', N'Sunday')
       SELECT 'Weekend' AS day_of_week;
ELSE 
       SELECT 'Weekday' AS day_of_week;

----------

IF 1 = 1 PRINT 'Boolean_expression is true.'  
ELSE PRINT 'Boolean_expression is false.' ;

----------

if exists (select 1)
   select * from order_tbl

if not exists (select 1)
    select * from order_tbl



DECLARE @PAR1 INT = 6
IF NOT EXISTS (SELECT 1)
	SELECT * FROM ORDER_TBL
ELSE IF @PAR1 = 7
	PRINT  'PARAMETER EQUAL TO 7'
ELSE
	SELECT NULL


DECLARE @PAR1 INT = 7
IF NOT EXISTS (SELECT 1)
	SELECT * FROM ORDER_TBL
ELSE IF @PAR1 = 7
	PRINT  'PARAMETER EQUAL TO 7'
ELSE
	SELECT NULL

--------

-- iki parametre tanimlayin
-- eger biri digerine esitse iki degeri carpin
-- eger parametre1 parametre2den kücükse iki parametreyi toplayin
-- parametre2 parametre1 den kücükse cikarin

DECLARE	@P1 INT= 5, @P2 INT= 8
IF @P1 = @P2
	SELECT @P1*@P2  as carpim 
ELSE IF @P1 < @P2
	SELECT @P1 + @P2  as toplam
ELSE IF @P1 > @P2
	SELECT @P2 - @P1  as fark 
------

declare @V1 INT = 6, @V2 INT = 5, @RESULT1 INT,  @RESULT2 INT,  @RESULT3 INT
SET @RESULT1 = @V1*@V2
SET @RESULT2 = @V1+@V2
SET @RESULT3 = @V1-@V2

IF @V1 = @V2
    select @RESULT1
IF @V1 < @V2
    select @RESULT2
IF @V1 > @V2
    select @RESULT3

-------

DECLARE	@P1 INT = 2, @P2 INT = 4
IF @P1 = @P2
	SELECT 'CARPIM' = @P1*@P2
ELSE IF @P1 < @P2
	SELECT 'TOPLAM' = @P1 + @P2
ELSE
	SELECT 'FARK' = @P2 - @P1

----istenilen tarihte verilen siparis sayisi 5ten kucukse 'lower than 5'
---  5 ile 10 arsindaysa siparis sayisi , 10'dan büyükse 'upper than 10' yazdiran sorgu 

DECLARE @date DATE = '2018-01-01'
IF (SELECT COUNT(order_id) FROM sale.orders WHERE order_date = @date) < 5
	select 'lower than 5'
ELSE IF (SELECT COUNT(order_id) FROM sale.orders WHERE order_date = @date) > 10
	SELECT 'upper than 10'
ELSE
	SELECT 'arada'

---
DECLARE @DATE date
DECLARE @rowcount INT 
set @DATE= '2018-12-06'

select @rowcount= count(*) 
from sale.orders where order_date= @date

IF @rowcount<5
   print 'lower than 5'
else if @rowcount between 5 and 10
   select @rowcount
else 
    print 'upper than 10'

-----

SELECT ORDER_DATE,  COUNT (order_id) FROM sale.orders GROUP BY ORDER_DATE
HAVING COUNT (order_id) >3 

-----WHILE------
/*
WHILE Boolean_expression   
     { sql_statement | statement_block | BREAK | CONTINUE }  */

DECLARE @COUNTER INT = 1

WHILE @COUNTER <10
    BEGIN
      print @COUNTER
	  set @COUNTER += 1 
	END
----
DECLARE @COUNTER INT = 1

WHILE @COUNTER <10
    BEGIN
      select @COUNTER
	  set @COUNTER += 1 
	END
----
--order_TBL tablosunda 10 ile 20 id'li siparisleri ekleyin.(customer_id' lerde 10 ile 20 arasinda olsun)

select * from ORDER_TBL

declare @idcounter int = 10
while @idcounter   < 21 
begin
INSERT ORDER_TBL VALUES (@idcounter, @idcounter,NULL, NULL, NULL)

set @idcounter += 1
end
-----

DECLARE @COUNTER INT = 1

WHILE @COUNTER <10
    BEGIN
	  if @COUNTER = 5
	  break
      print @COUNTER
	  set @COUNTER += 1 
	END

-------
DECLARE @COUNTER INT = 1
WHILE @COUNTER <10
    BEGIN
	  if @COUNTER = 5
	     BEGIN
	        set @COUNTER+=1
	        continue
		 END
      print @COUNTER
	  set @COUNTER += 1 
	END

--------
-- Declaring a @count variable to delimited the while loop.
DECLARE @count as int

--Setting a starting value to the @count variable
SET @count=1

--Generating the while loop

WHILE  @count < 30 -- while loop condition
BEGIN  	 	
	SELECT @count, @count + (@count * 0.20) -- Result that is returned end of the statement.
	SET @count +=1 -- the variable value raised one by one to continue the loop.
	IF @count % 3 = 0 -- this is the condition to break the loop.
		BREAK -- If the condition is met, the loop will stop.
	ELSE
		CONTINUE -- If the condition isn't met, the loop will continue.
END;
--------

----USER VALUED FUNCTIONS ------

----SCALAR VALUED FUNCTIONS

CREATE FUNCTION fn_upperfirst1()
RETURNS VARCHAR (MAX)
AS
BEGIN
	RETURN  UPPER (LEFT ('character', 1)) + LOWER (RIGHT ('character', len ('character')-1))
END
SELECT dbo.fn_upperfirst1()


CREATE FUNCTION fn_upperfirst2 (@par VARCHAR(MAX))
RETURNS VARCHAR (MAX)
AS
BEGIN
	RETURN UPPER (LEFT (@par, 1)) + LOWER (RIGHT (@par, len (@par)-1))
END
SELECT dbo.fn_upperfirst2('welcome')


create function fn_factorial( @number int)
returns bigint
as
begin
	  Declare @result int = 1
    while @number >= 1
    BEGIN
      set @result = @number* @result
	  set @number -= 1	  
	END
return @result
end

select dbo.fn_factorial(5)

----- Table-Valued Function Example:


CREATE FUNCTION fn_sampletablevalued1()
RETURNS table
AS
	RETURN SELECT * FROM ORDER_TBL
SELECT *
FROM dbo.fn_sampletablevalued1()
------------
CREATE FUNCTION fn_sampletablevalued2(@date DATE)
RETURNS table
AS
	RETURN SELECT * FROM ORDER_TBL WHERE ORDER_DATE = @date
SELECT *
FROM dbo.fn_sampletablevalued2('2022-02-24')
------------------
declare @v1 int
declare @table TABLE (column1 int, column2 varchar(20))
	INSERT @table VALUES (1, 'Adam')
select * from @table
---------------
CREATE FUNCTION fn_sampletablevalued3 (@ORDER_ID INT)
RETURNS @table TABLE (ORDER_ID INT, DEL_TYPE VARCHAR(20) )
AS
BEGIN
	INSERT @table
	SELECT A.ORDER_ID, 'ON TIME'
	FROM ORDER_TBL A, ORDER_DELIVERY B
	WHERE A.EST_DELIVERY_DATE = B.DELIVERY_DATE
	AND A.ORDER_ID= B.ORDER_ID
	AND		A.ORDER_ID = @ORDER_ID
	
	RETURN
END
SELECT * FROM dbo.fn_sampletablevalued3(10)

