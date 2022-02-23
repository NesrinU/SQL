/* 
Date Function 
*/


CREATE TABLE t_date_time (
	A_time time,
	A_date date,
	A_smalldatetime smalldatetime,
	A_datetime datetime,
	A_datetime2 datetime2,
	A_datetimeoffset datetimeoffset
	)


	SELECT GETDATE()


	INSERT t_date_time VALUES (GETDATE(), GETDATE(), GETDATE(), GETDATE(), GETDATE(), GETDATE())

	select * from t_date_time

	INSERT t_date_time VALUES
('12:00:00', '2021-07-17', '2021-07-17','2021-07-17', '2021-07-17', '2021-07-17' )

----
SELECT CONVERT (VARCHAR, GETDATE(), 3 )    ---'21/02/22' VARCHAR TIPINDE VERIYOR 

SELECT CONVERT(DATE, '21/02/22' , 3)   --- 2022-02-21 SISTEMIN DATE FORMATINA DÖNÜSTÜRÜYOR

SELECT CONVERT(datetime, '21/02/22' , 3)       --2022-02-21 00:00:00.000  

SELECT CONVERT(varchar , '21/02/22' , 3)       --21/02/22

SELECT DATENAME( WEEKDAY, GETDATE())   --Monday

SELECT DATENAME(HOUR, GETDATE())        

SELECT DATENAME(DAY, GETDATE())      --21

SELECT DATENAME(YEAR, GETDATE())

SELECT DATEPART(HOUR, GETDATE())

SELECT DATEPART(DAY, GETDATE())        --21

SELECT DATEPART(YEAR, GETDATE())

SELECT DAY(GETDATE())      --21

SELECT MONTH(GETDATE())

SELECT YEAR(GETDATE())

SELECT DATEDIFF(DAY, '2022-10-22', '2021-10-22')
SELECT DATEDIFF(DAY, '2021-10-22', '2022-10-22')
SELECT DATEDIFF(YEAR, '2021-10-22', GETDATE())
SELECT DATEDIFF(HOUR, '2021-10-22', GETDATE())
----
SELECT DATEADD(DAY, 3, GETDATE())
SELECT DATEADD(MINUTE, 3, GETDATE())
SELECT DAY(EOMONTH(GETDATE(), 2))
--------
--- Question-1: Write a query that returns orders that are shipped more than two days after the ordered date.

SELECT TOP 10*
FROM sale.orders;

SELECT *
FROM sale.orders
WHERE DATEDIFF(DAY, order_date, shipped_date) >= 2 ;

SELECT order_id, DATEDIFF(DAY, order_date, shipped_date)  as datediff
FROM sale.orders
WHERE DATEDIFF(DAY, order_date, shipped_date)> 2 ;

-- LEN 

select len('data science')    --12

select len('data science ')    --12   sondaki boslugu saymiyor

select len('  data science ')    --14  bastaki boslugu sayiyor

select len(164098509)     --9

-- CHARINDEX

SELECT CHARINDEX('C', 'CHARACTER')   --1


SELECT CHARINDEX('C', 'CHARACTER', 2)   --6

SELECT CHARINDEX(' ', 'CHARAC TER')


SELECT CHARINDEX('CT', 'CHARACTER')     --6

SELECT CHARINDEX(' ', 'CHARACTER')     --0

SELECT CHARINDEX('Ct', 'CHARACTER')    --6  CASE-SENSITIVE DEGIL 

SELECT CHARINDEX('C', 'cHARACTER')    --1

--PATINDEX
SELECT PATINDEX('CHARACTER', 'CHARACTER')

SELECT PATINDEX('CH%', 'CHARACTER')

SELECT PATINDEX('CH_', 'CHARACTER')    -- 0 

SELECT PATINDEX('CH_', 'CHA')     --1

SELECT PATINDEX('CH_%', 'CHARACTER')  --1

SELECT PATINDEX('%R', 'CHARACTER')    --9

SELECT PATINDEX('%R%', 'CHARACTER')    --4

--LEFT

SELECT LEFT('CHARACTER', 3)      --CHA

SELECT LEFT(' CHARACTER', 3)     --CH

SELECT RIGHT('CHARACTER', 3)      --TER

SELECT SUBSTRING('CHARACTER',1,3)    --CHA

SELECT SUBSTRING('CHARACTER',4,LEN('CHARACTER'))

SELECT SUBSTRING('CHARACTER',4,2)   --RA

--QUESTION-2: Just upper the first letter of 'character' while other letters remain lower

SELECT Upper(LEFT('character', 1))+RIGHT('character',8)

SELECT UPPER(LEFT('character',1))+LOWER(SUBSTRING('character',2,LEN('character')))

SELECT CONCAT ( UPPER(LEFT('character', 1)), LOWER(SUBSTRING('character',2,LEN('character'))))


SELECT CONCAT ( UPPER(LEFT(first_name, 1)), LOWER(SUBSTRING(first_name,2,LEN(first_name))))
FROM sale.customer;

SELECT trim('  character  '  ) 

select trim('$' from '  $character   $')

select trim('$, ' from '  $character   $')

SELECT ltrim('  character  ') 

SELECT rtrim('  character  ') 

----STRING SPLIT

SELECT VALUE FROM string_split('AUDI, RENAULT, PEGOUT', ',')

SELECT * FROM string_split('AUDI, RENAULT, PEGOUT', ',')

SELECT VALUE AS BRAND FROM string_split('AUDI, RENAULT, PEGOUT', ',')


---REPLACE---

SELECT REPLACE('CHARACTER', 'TER', '%%%')

---STR---

SELECT STR(1234.345,8)
 --   1234

SELECT STR(1234.345,4)
--1234

SELECT STR(1234.345,7,2)
--1234.35

SELECT CAST(1231546 AS VARCHAR)

SELECT CONVERT(VARCHAR, 1231546)


SELECT cast(1234.345 as numeric(7,2))    --1234.35

SELECT cast(1234.345 as numeric(7,3))    --1234.345

----
select coalesce(NULL, NULL, 'ALI', NULL)   --ALI

select coalesce(NULL, 'NULL', 'ALI', NULL)   --NULL

select nullif(10, 10)  --null

select nullif(10, 8)    --10  

select isnull(NULL , 2)   --2

select isnull(3 , 2)    --3

select isnull(nullif('ali', 'ahmet'), 1)

-----
--Q-3: How many yahoo mails in customer’s email column?

select * from sale.customer

select email, patindex('%yahoo%', email) as ind_of_yahoo
from sale.customer

select email, patindex('%yahoo%', email) as ind_of_yahoo
from sale.customer
where  patindex('%@yahoo%', email)>0


select count(*)
from sale.customer
where  patindex('%@yahoo%', email)<>0

-- Q-4: Write a query that returns the characters before the '@' character in the email column.

SELECT email,  LEFT( [email] ,CHARINDEX('@', [email] )-1) as Chars
FROM [sale].[customer]

Select email, SUBSTRING(email,1,charindex('@',email)-1) as Chars
from sale.customer;

-- Q-5: Add a new column to the customers table that contains the customers' contact information. 
--If the phone is available, the phone information will be printed, if not, the email information will be printed.

select  isnull( phone, email ) as contact 
from sale.customer


select customer_id, phone, email, coalesce(phone, email) as contact
from sale.customer

select *,  isnull( phone, email ) as contact 
from sale.customer

--Q-6 Write a query that returns streets. The third character of the streets is numerical

select street , substring(street, 3, 1) as third_char
from sale.customer
where isnumeric(substring(street, 3, 1)) = 1 

select street,
case when isnumeric(substring(street, 3, 1)) = 1 then substring(street, 3, 1) else substring(street, 1, 1) end as third_char
from sale.customer


select street, 

/*Q-7 List the product names in ascending order where the part from the beginning to the first space 
character is "Samsung" in the product_name column. */
 
 select product_name
from [product].[product]
where Left(product_name, 8)= 'Samsung '
Order by  product_name ASC;

/* Q-8 Write a query that returns streets in ascending order. 
The streets have an integer character lower than 5 after the "#" character end of the street.  */

select street 
from sale.customer
where Substring(street, Charindex( '#', street)+1 , len(street))= 4

-- Q-9 Split the values in the email column into two parts with “@”

select email, substring(email, 1 , charindex('@', email)-1) as left_part,
substring(email, charindex('@', email)+1, len(email)) as right_part
from sale.customer

