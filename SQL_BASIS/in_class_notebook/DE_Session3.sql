	/*===================================================
					 
====================================================*/



	/*===================================================
					 COUNT
====================================================*/

-- SELECT COUNT(column_name)
-- FROM table_name;

--invoices tablasunda kac adet fatura bulundugunu  döndüren sorguyu yazin
SELECT COUNT(invoiceId)  FROM invoices;

SELECT COUNT(BillingState)  FROM invoices;

SELECT COUNT(BillingState)  FROM invoices WHERE BillingState IS NULL;

SELECT count(InvoiceId) as num_of_rekords
FROM invoices
WHERE BillingState is NULL;

SELECT count(*) as num_of_rekords
FROM invoices
WHERE BillingState is NULL;

-- SELECT column_name AS alias_name
SELECT COUNT(invoiceId) AS numf_of_records FROM invoices;

--SELECT COUNT(DISTINCT column_name) AS count_of_field FROM table_name;

-- kac tane farkli composer bulundugu

SELECT COUNT(DISTINCT Composer) as Besteci_sayisi from tracks;

	/* invoices tablosunda kaç adet farklı yıl olduğunu hesaplayan sorguyu yazınız*/ 
	
select count(distinct InvoiceDate) ;

	/*===================================================
					 MIN and MAX
====================================================*/

--en az sure suren track name i bulun
SELECT name as Song_name, MIN(Milliseconds)as Min_duration from tracks ;

-- students tablosundaki en düsük ve en yüksek notu listeleyen sorgu
select min(Grade) as min_grade, max(Grade)  as max_grade from students;


	/*===================================================
					 SUM 
====================================================*/
-- invoices tablosundaki faturalarin toplam degeri
select sum(total) as total_invoices 
from invoices;

-- invoices tablosundaki 2009 ile 2013 tarihleri arasindaki faturalarin toplam degeri
select sum(total) as total_invoices 
from invoices
where InvoiceDate between '2009%' and '2013-12-31' ;

	/*===================================================
					 AVG
====================================================*/

--invoices  tablosunda faturalarin ortalamasini  bul 
select AVG(total) as ort_fatura from invoices;
select round(AVG(total),2) as ort_fatura from invoices;

select round(AVG(total),4) as ort_fatura from invoices;

--tracks  tablosunda sarkilarin  ortalama suresini bul ve ortalamadan buyuk degerleri listele
select round(AVG(Milliseconds),2) as ort_sure from tracks;

select name , Milliseconds as ort_fatura from tracks
where Milliseconds > 393599;

/* bu yöntem hard-coded oldugu icin cok mantikli bir cözüm degil.
alt-sorgu (sub-query) ile daha dogru bir yaklasim olacaktir.
sonraki bölümlerde alt-sorguyu ayrintili bir sekilde inceleyecegiz */

select name , Milliseconds as ort_fatura from tracks
where Milliseconds > (select AVG(Milliseconds) from tracks);



	/*===================================================
					 GROUP BY Clause
====================================================*/

-- SELECT column_1, aggregate_function(column_2)
-- FROM table_name
-- GROUP BY column_1;

/* tracks tablosundaki her bir Bestecisinin (Composer) toplam şarkı sayısını 
Besteci adına göre gruplandırarak listeleyen sorguyu yazınız. */
	SELECT Composer, COUNT(Name) 
	FROM tracks 
	WHERE Composer IS NOT NULL
	GROUP BY Composer;
	
/* customers tablosundaki müşterilerin sayılarını Ülkelerine (Country) göre gruplandırarak 
ve müşteri sayısına göre AZALAN şekilde sıralayarak listeleyen sorguyu yazınız*/
	SELECT country,Count(CustomerId)
	FROM customers
	GROUP BY country
	ORDER BY Count(CustomerId) DESC;
	
	SELECT country,Count(CustomerId) as no_of_customers
	FROM customers
	GROUP BY country
	ORDER BY no_of_customers DESC;
	
		/* tracks tablosundaki herbir albumü AlbumId'lerine göre gruplandırarak 
	her albumdeki minumum şarkı sürelerini listeleyen listeleyen sorguyu yazınız */
	SELECT AlbumId, MIN(Milliseconds) as Min_Duration 
	FROM tracks 
	GROUP BY AlbumId;
	
/* invoices tablosundaki her bir ülkenin (BillingCountry) fatura ortalamalarını 
	hesaplayan ve ülke bilgileri ile listeleyen sorguyu yazınız.*/
    SELECT BillingCountry, ROUND(AVG(total)) as ort_fatura
	FROM invoices
	GROUP BY BillingCountry;

/*===================================================
					 JOIN
 The SQL Join clause is used to combine records (rows) from two or more tables into a single table.
====================================================*/

-- INNER JOIN: Returns the common records in both tables.
-- LEFT JOIN: Returns all records from the left table and matching records from the right table.
-- RIGHT JOIN: Returns all records from the right table and matching records from the left table.
-- FULL OUTER JOIN: Returns all records of both left and right tables.
-- CROSS JOIN: Returns the Cartesian product of records in joined tables.
-- SELF JOIN: A join of a table to itself.


--   SELECT columns
--   FROM table_A
--   INNER JOIN table_B ON join_conditions     --join default  inner join alir 

--table_A.column = table_B.column


/*SELECT columns
  FROM table_A
  INNER JOIN table_B 
    ON join_conditions1 AND join_conditions2
  INNER JOIN table_C
    ON join_conditions3 OR join_conditions4 */



/*SELECT columns
  FROM table_A
  LEFT JOIN table_B ON join_conditions */

  --If no match is found for a particular row, NULL is returned.
  
  
/*===================================================
        JOINS
====================================================*/
    
--     Join islemleri farkli tablolardan secilen sutunlar ile yeni bir tablo 
--     olusturmak icin kullanilabilir.
--     
--     JOIN islemleri Iliskisel Veritabanlari icin cok onemli bir ozelliktir. Çunku
--    	Foreign Key'ler ile iliskili olan tablolardan istenilen sutunlari cekmek 
--     icin JOIN islemleri kullanilabilir.

--     Standart SQL'de en çok kullanılan Join islemleri:
--   	1) FULL JOIN:  Tablodaki tum sonuclari gosterir
--     2) INNER JOIN:  Tablolardaki ortak olan sonuc kumesini gosterir
--     3) LEFT JOIN:  Ilk tabloda (Sol) olup digerinde olmayan sonuclari gosterir
--     4) RIGHT JOIN: Sadece Ikinci tabloda olan tum sonuclari gosterir.

--		NOT: SQLite Sadece INNER, LEFT VE CROSS JOIN İşlemlerini desteklemektedir.
 
 /*===================================================*/   

  /* araclar.db adındaki veritabanını kullanarak Markalar ve Siparisler tablolarındaki 
 marka_id'si ayni olan kayıtların marka_id, marka_adi, siparis_adedi ve siparis_tarihi   
 bilgilerini  listeleyen bir sorgu yaziniz.*/
select * from siparisler;
select * from markalar;

SELECT  siparisler.marka_id, markalar.marka_adi, siparisler.siparis_adedi,siparisler.siparis_tarihi
FROM siparisler
JOIN  markalar  ON siparisler.marka_id = markalar.marka_id;

-- daha kisa olarak
SELECT  s.marka_id, m.marka_adi, s.siparis_adedi,s.siparis_tarihi
FROM siparisler s
JOIN  markalar m ON s.marka_id = m.marka_id;

-- markalar ve sipraisler yer degistirirse 

SELECT  siparisler.marka_id, markalar.marka_adi, siparisler.siparis_adedi,siparisler.siparis_tarihi
FROM markalar
JOIN  siparisler  ON siparisler.marka_id = markalar.marka_id;

-- bize  yukaridaki iki sorgu ayni sonucu veriyor inner join oldugu icin. 5 satir 


/* Markalar ve Siparisler tablolarındaki tüm araç markalarının siparis bilgilerini
   (marka_id,marka_adi,siparis_adedi,siparis_tarihi) listeleyen bir sorgu yaziniz.*/
--left join

SELECT  siparisler.marka_id, markalar.marka_adi, siparisler.siparis_adedi,siparisler.siparis_tarihi
FROM markalar
LEFT JOIN  siparisler  ON siparisler.marka_id = markalar.marka_id; 
 --7 satir



/* Chinook veritabanındaki tracks tablosunda bulunan her bir şarkının türü (genre)
listeleyiniz.*/
SELECT genres.Name as genre_type,tracks.Name
FROM tracks
JOIN genres
on tracks.GenreId = genres.GenreId;

SELECT g.Name as genre_type,t.Name
FROM tracks t
JOIN genres g
on t.GenreId = g.GenreId;

select * from tracks;
select * from genres ;



 /* invoice tablosundaki faturaların her birinin müşteri adını (FirstName),
 soyadını (lastName), fatura tarihi (InvoiceDate) ve fatura meblağını (total) 
 listeleyen sorguyu yazınız */
 select * from invoices;
 select * from customers;
 
 SELECT customers.Firstname, customers.LastName, invoices.InvoiceDate, 
 invoices.Total
 FROM invoices
 JOIN customers 
 on customers.CustomerId = invoices.CustomerId;
 
 
 SELECT customers.Firstname, customers.LastName, invoices.InvoiceDate, 
 invoices.Total
 FROM invoices
 LEFT JOIN customers 
 on customers.CustomerId = invoices.CustomerId;

 
 
/* artists tablosunda bulunan kişilerin albums tablosunda bulunan albümlerinin
listeleyen sorguyu yazınız. Sorguda ArtistId, Name, Title ve AlbumId olmalıdır*/
select * from artists;
select * from albums;

SELECT artists.ArtistId, artists.Name, albums.Title, albums.AlbumId
FROM artists
JOIN albums on artists.ArtistId = albums.ArtistId;

/* artists tablosunda bulunan tüm kişilerin albums tablosunda bulunan albümlerini
listeleyen sorguyu yazınız. Sorguda ArtistId, Name, Title ve AlbumId olmalıdır*/

SELECT artists.ArtistId, artists.Name, albums.Title, albums.AlbumId
FROM artists
LEFT JOIN albums on artists.ArtistId = albums.ArtistId;

SELECT artists.ArtistId, artists.Name, albums.Title, albums.AlbumId
FROM albums
LEFT JOIN artists on artists.ArtistId = albums.ArtistId;
