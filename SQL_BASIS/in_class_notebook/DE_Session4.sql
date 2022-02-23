	/*===================================================
			Subquery/inner query/nested query
====================================================*/

--A subquery is usually embedded inside the WHERE clause. 
-- It is used to restrict or enhance the data to be queried by the main query, thus restricting or enhancing the output of the main query respectively.

/*SELECT column_name
FROM table_1, table_2
WHERE column_name OPERATOR (
	SELECT column_name
	FROM table_1, table_2);*/

/*Herein the query

SELECT column_name
FROM table_1, table_2
WHERE column_name OPERATOR      is called the outer query.(dis sorgu)


The query
(SELECT column_name
FROM table_1, table_2)          is called inner query (nested or subquery query)


-The inner query is executed first before the outer query. The results of the inner query are passed to the outer query.

There are some rules when using subquery:
A subquery must be enclosed in parentheses.
An ORDER BY clause is not allowed to use in a subquery.
The BETWEEN operator can't be used with a subquery. But you can use BETWEEN within the subquery.*/

select * from employees;


--We'll find the employees who get paid more than Rodney Weaver. Our query should return first name, last name, and salary info of the employees

SELECT first_name, last_name, salary
FROM employees
WHERE salary > 
(SELECT salary
FROM employees WHERE first_name = 'Rodney' )  ;

/*There are three main types of subqueries:

Single-row subqueries
Multiple-row subqueries
Correlated subqueries*/


	/*===================================================
			 Single-Row Subqueries
====================================================*/

--Single-row subqueries return one row with only one column and are used with single-row operators such as =, >, >=, <=, <>, != . 

/*let' s find out the employees who get paid more than the average salary. Our query should return first name, last name, and salary info of the employees. */
SELECT first_name, last_name, salary
FROM employees
WHERE salary > 
    (SELECT AVG(salary) 
    FROM employees);
	
/* albums tablosundaki Title sutunu 'Faceless' olan kaydın albumid'sini elde ederek 
	tracks tablosunda bu değere eşit olan kayıtların bilgilerini SUBQUERY yazarak listeyiniz.
	Listelemede trackid, name ve albumid bilgilerini bulunmalıdır. */
	
SELECT TrackId, Name, AlbumId
FROM tracks
WHERE AlbumId = 
(select AlbumId
	from albums where title= 'Faceless');
	

	

/*===================================================
				Multiple-Row Subqueries	 
====================================================*/
--Multiple-row subqueries return sets of rows and are used with multiple-row operators such as IN, NOT IN, ANY, ALL.  
SELECT first_name, last_name
FROM employees
WHERE emp_id IN
    (SELECT emp_id 
    FROM departments
    WHERE dept_name = 'Operations');
	
/* albums tablosundaki Title sutunu Faceless veya Let There Be Rock olan kayıtların 
	albumid'lerini elde ederek tracks tablosunda bu id'lere eşit olan kayıtların bilgilerini 
	SUBQUERY kullanarak listeyiniz. Listelemede trackid, name ve albumid bilgileri bulunmalıdır. */	
	
SELECT TrackId, Name, AlbumId
	FROM tracks
	WHERE AlbumId IN 
	  (SELECT AlbumId FROM albums 
	  WHERE Title in  ('Faceless' ,'Let There Be Rock'));

-- join kullanarak yapalim ayni soruyu	  

SELECT t.TrackId, t.Name, t.AlbumId
FROM tracks t
JOIN albums a 
ON t.AlbumId= a.AlbumId
WHERE a.Title IN  ('Faceless' ,'Let There Be Rock');

	/*===================================================
					typeof
====================================================*/

select typeof(EmployeeId), typeof(BirthDate), typeof(PostalCode)
from employees;
--string : char, varchar, binary, varbinary, blob, text, enum, set
-- char(max value) = character bellekte o kadar yer ayirtiyor 
-- varcharda deger ne olursa olsun veri kac karakterse o kadar yer kaplar bellekte

-- date, datetime, timestamp, year  ayri veri tipleridir sqlite de bunlar yoktur.
-- integer(32 bittir) , (folating-point --> REAL)  , fixed-point types
--storage classes:

SELECT
    typeof('100'),
    typeof(100),
    typeof(10.0),
    typeof(x'1000'),
    typeof(NULL);


/*===================================================
					CREATE TABLE
====================================================*/

/*CREATE TABLE database_name.table_name (
  column1 data_type,
  column2 data_type,
  ...
); */

/*personel adinda bir tabalo oluşturunuz.  Tabloda first_name, last_name 
	age(INT) ve hire_date (Date) sutunuları bulunmalıdır.
	*/
CREATE TABLE personal ( 
first_name VARCHAR(20),
last_name Text,
age INT,
hire_date DATE) ;

	
/* Aynı isimle yeniden bir veritabanı oluşturlmak istenirse hata verir. Bu hatayı
almamak için IF NOT EXISTS keywordu kullanılabilir */

CREATE TABLE IF NOT EXISTS personal ( 
first_name VARCHAR(20),
last_name Text,
age INT,
hire_date DATE) ;

/*Veritabanında vacation_plan adında yeni bir tablo oluşturunuz.  Sutun isimleri
	place_id, country, hotel_name, employee_id, vacation_length,budget 	*/

CREATE TABLE vacation_plan	(
place_id INTEGER, 
country TEXT, 
hotel_name TEXT, 
employee_id INTEGER, 
vacation_length INTEGER,
budget REAL
);
/*===================================================
					DROP TABLE
====================================================*/
-- TABLOYU TAMAMEN SILER
 
-- personal tablosunu siliniz 

DROP TABLE personal;

/* BIR TABLOYU SILERKEN TABLO BULUNMAZSA HATA VERIR: BU HATAYI GORMEMEK ICIN if EXISTS KEYWORDU KULLANILABILIR:*/

DROP TABLE  IF EXISTS personal;

	-- NOT: SQL'de TRUNCATE TABLE komutu bulunmasına karşın SQLite bu komutu 
	-- desteklememektedir. Truncate komutu  bir tabloyu değil içindeki tüm verileri 
	-- silmek için kullanılır.
	
	
/*------------------------------------------------------------------------------------------
	  INSERT INTO
----------------------------------------------------------------------------------------*/

	/* vacation_plan tablosuna 2 kayıt gerçekletiriniz.*/
	
INSERT INTO vacation_plan VALUES (34, 'Turkey', 'Happ hotel', 1, 7, 3000);
	
INSERT INTO vacation_plan VALUES (34, 'Turkey', 'Happ hotel', 1, 7, 3000);
	-- NOT: Aynı komut tekrar çalıştırılırsa herhangi bir kısıt yoksa ise aynı veriler
	-- tekrar tabloya girilmiş olur.

INSERT INTO vacation_plan VALUES (48, 'Turkey', 1);    -- table vacation_plan has 6 columns but 3 values were supplied

 
	
/*vacation_plan tablosuna vacation_lenght ve budget sutunlarını eksik olarak veri girişi 
	yapınız*/
	
	INSERT INTO vacation_plan (place_id, country, hotel_name, employee_id ) 
	VALUES(35, 'Turkey', 'Comfort Hotel',144);
	
	-- NOT : giriş yapılmayan sutunlara NULL atanır.
	
INSERT INTO vacation_plan (place_id,country,employee_id) VALUES (48, 'Turkey', 1);


CREATE TABLE teachers(name TEXT, lesson TEXT, salary INT);

.table;


/*------------------------------------------------------------------------------------------
	    CONSTRAINTS - KISITLAMALAR 
-----------------------------------------------------------------------------------------

	NOT NULL - Bir Sütunun NULL içermemesini garanti eder. 

    UNIQUE - Bir sütundaki tüm değerlerin BENZERSİZ olmasını garanti eder.  

    PRIMARY KEY - Bir sütünün NULL içermemesini ve sütundaki verilerin 
                  BENZERSİZ olmasını garanti eder.(NOT NULL ve UNIQUE birleşimi gibi)

    FOREIGN KEY - Başka bir tablodaki Primary Key'i referans göstermek için kullanılır. 
                  Böylelikle, tablolar arasında ilişki kurulmuş olur. 

    DEFAULT - Herhangi bir değer atanmadığında Başlangıç değerinin atanmasını sağlar.
	/*----------------------------------------------------------------------------------------*/

--We can define the constraints with the CREATE TABLE statement or ALTER TABLE statement.

/*CREATE TABLE table_name (
    column1 DATATYPE CONSTRAINT,
    column1 DATATYPE CONSTRAINT,
    ...
);  */

/*                      Constraints 

Constraint Name	    Definition
NOT NULL	   Ensures that a column cannot have a NULL value
DEFAULT	       Sets a default value for a column when no value is specified
UNIQUE	       Ensures that all values in a column are different
PRIMARY KEY	   Uniquely identifies each row in a table
FOREIGN KEY	   Uniquely identifies a row/record in another table      */

/* 
CREATE TABLE table_name(
    column_1 INT PRIMARY KEY,
    column_2 TEXT,
    ...
);  */

/*
CREATE TABLE table_name(
    column_1 INT,
    column_2 TEXT,
    ...
    PRIMARY KEY (column_1));    */

--The primary key column cannot contain NULL values.

CREATE TABLE workers ( 
    id INTEGER PRIMARY KEY,
	id_number VARCHAR(11) UNIQUE NOT NULL,
	name TEXT DEFAULT 'NONAME',
	salary INTEGER NOT NULL 
	);
	
INSERT INTO workers  VALUES(1, '12345678910' , 'HALIL PATRON' , 120000);

 -- NOT NULL Violation 
 INSERT INTO workers (id, id_number, name) VALUES (3, '12345678220' , 'KENAN BASKAN');  --(salary girmek zorundayz)
 
 
 
/*vacation_plan tablosunu place_id sutunu PK ve employee_id sutununu ise FK olarak  değiştirirek
	vacation_plan2 adinda yeni bir tablo oluşturunuz. Bu tablo, employees tablosu ile ilişkili olmalıdır*/
CREATE TABLE vacation_plan2	(
	place_id INTEGER , 
	country TEXT, 
	hotel_name TEXT, 
	employee_id INTEGER, 
	vacation_length INTEGER,
	budget REAL,
	PRIMARY KEY(place_id)
	FOREIGN KEY(employee_id) REFERENCES employees(EmployeeId)
);


INSERT INTO vacation_plan2 VALUES(48, 'TR', 'CALIFORNIA HOTEL', 1, 7, 4000);

/* Employees tablosunda bulunmayan bir kişi için (EmployeeId=9) olan kişi için bir tatil planı giriniz.*/


INSERT INTO vacation_plan2 VALUES(52, 'TR' , 'YILDIZ HOTEL' , 9, 7, 5000);

INSERT INTO vacation_plan2 VALUES(42, 'TR' , 'MEVLANA HOTEL' , 2, 5, 5000);

INSERT INTO vacation_plan2 VALUES(01, 'NL' , 'RED LIGHT' , 3, 4, 5000);

INSERT INTO vacation_plan2 VALUES(34, 'TR' , 'HAPPY HOTEL' , 4, 5, 5000);

INSERT INTO vacation_plan2 VALUES(07, 'TR' , 'ASRIN HOTEL' , 5, 3, 9000);

	/* EmployeeId=1 olan çalışanın FirstName, LastName, vacation_length,hotel_name ve 
	budget bilgilerini getiren sorguyu yazınız.*/
	
SELECT  e.FirstName, e.LastName, v.hotel_name, v.vacation_length, v.budget
FROM employees e
JOIN vacation_plan2 v
ON e.EmployeeId = v.employee_id
WHERE e.EmployeeId= 1 ;

SELECT  e.FirstName, e.LastName, v.hotel_name, v.vacation_length, v.budget
FROM employees e
JOIN vacation_plan2 v
ON e.EmployeeId = v.employee_id AND e.EmployeeId= 2 ;

select * from vacation_plan2;





