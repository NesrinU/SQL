SELECT name FROM tracks;
/* comment*/    --comment iki alternatif var

--run hepsini calistirir ama hizli calistigi icin son komutu goruyoruz genelde, execute secilen satiri calistirir
--strg + farenin tekeri yazilari buyutuyor
/*===================================================
													  SELECT
===================================================*/
	/* tracks tablosundaki track isimlerini (name) sorgulayınız */
	SELECT name FROM tracks;
	
	
	/* tracks tablosundaki besteci(Composer) ve şarkı isimlerini (name) sorgulayınız.*/
	SELECT Composer, name FROM tracks;
	
	/* tracks tablosundaki tüm bilgileri sorgulayınız */
	SELECT * FROM tracks;
	
	
/*===================================================
													DISTINCT
===================================================*/
	/*tracks tablosundaki composer bilgileri sorgulayınız (TEKRARLI OLABİLİR)*/
	SELECT Composer FROM tracks;  --3553 data
	
	/*tracks tablosundaki composer bilgileri sorgulayınız (TEKRARSIZ) */
	SELECT DISTINCT Composer FROM tracks;     --853 
SELECT Composer, name FROM tracks;   --3503
SELECT DISTINCT Composer, name FROM tracks;  --3423

	/*tracks tablosundaki AlbumId ve MediaTypeId bigilerini TEKRARSIZ olarak 
	sorgulayınız */
	SELECT DISTINCT AlbumId,MediaTypeId FROM tracks;
	
/*===================================================
													WHERE
===================================================*/


	/*Composer'ı Jimi Hendrix olan şarkıların isimlerini (name) sorgulayiniz*/
SELECT  name FROM tracks WHERE  Composer= 'Jimi Hendrix'; 

/* invoices tablosunda Total değeri 10$ dan büyük olan faturaların tüm bilgilerini 
	sorgulayiniz */
	
	SELECT * FROM invoices WHERE total >10 ;
	-- SELECT CustomerId, BillingAddress,total FROM invoices WHERE total >10 ;

/*===================================================
													LIMIT
===================================================*/
SELECT* FROM invoices WHERE total>10 LIMIT 4;
/*invoices tablosunda Total değeri 10$'dan büyük olan ilk 4 kayıt'ın InvoiceId, 
	InvoiceDate ve total bilgilerini sorgulayiniz */
SELECT InvoiceId, InvoiceDate, total FROM invoices WHERE total>10 LIMIT 4;
/*===================================================
													ORDER BY
===================================================*/

	/*invoices tablosunda Total değeri 10$'dan büyük olan kayıtları Total değerine göre 
	ARTAN sırada sıralayarak sorgulayiniz */
SELECT * FROM invoices WHERE total >10 
ORDER BY total ASC;
/*invoices tablosunda Total değeri 10$'dan büyük olan kayıtlardan işlem tarihi 
	(InvoiceDate) en yeni olan 10 kaydın tüm bilgilerini listeyiniz */ 
	SELECT * FROM invoices
	WHERE total >10
	ORDER BY InvoiceDate DESC
	LIMIT 10;
	

