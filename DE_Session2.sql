
/*===================================================
														LIMIT
====================================================*/
 	/*invoices tablosunda Total değeri 10$'dan büyük olan ilk 4 kayıt'ın InvoiceId, 
	InvoiceDate ve total bilgilerini sorgulayiniz */
	SELECT InvoiceId, InvoiceDate,total 
	FROM invoices 
	WHERE total < 10 
	LIMIT 4;
	
	SELECT * FROM invoices
	WHERE total >10
	ORDER BY InvoiceDate DESC
	LIMIT 10;
	/*===================================================
													ORDER BY
====================================================*/
	
	/*invoices tablosunda Total değeri 10$'dan büyük olan kayıtları Total değerine göre 
	ARTAN sırada sıralayarak sorgulayiniz */
	select * 
	from invoices 
	where total> 10
	order by total ASC;     -- order by default olarak asc gibi calisir
	
	/*invoices tablosunda Total değeri 10$'dan büyük olan kayıtlardan işlem tarihi 
	(InvoiceDate) 	en yeni olan 10 kaydın tüm bilgilerini listeyiniz */
    select * 
	from invoices 
	where total> 10
	order by InvoiceDate DESC
	limit 10;
	/*===================================================
						LOGICAL OPERATORS (AND; OR; NOT)
     ====================================================*/
	 
	
	 
	 /* invoices tablosunda billingstate sütunu NS olmayan tüm verileri sorgulayiniz*/
	 
	select * 
	from invoices 
	where not BillingState= 'NS';     -- 'null'lari da almiyor
	
		/* invoices tablosunda BillingState sutunu NS olmayan VEYA NULL olan tüm verileri 
	sorgulayınız.*/
	
	select * 
	from invoices 
	where not BillingState= 'NS'or BillingState IS NULL;
	
	SELECT BillingState
	FROM invoices
	WHERE not "NS"
	order by BillingCity ASC;
	
	 	/* invoices tablosunda ülkesi (BillingCountry) USA olmayan kayıtları total değerine
	göre  AZALAN sırada listeyiniz */ 
	select * 
	from invoices
	WHERE NOT BillingCountry = 'USA'
	ORDER BY total DESC;
	
	/* invoices tablosunda, ülkesi (BillingCountry) USA veya Germany olan kayıtları, 
	InvoiceId sırasına göre artan sırada listeyiniz */ 
	SELECT * 
	FROM invoices
	WHERE BillingCountry = 'USA' or BillingCountry = 'Germany'
	ORDER BY InvoiceId;
	
	/* invoices tablosunda fatura tarihi (InvoiceDate) 01-01-2012 ile 02-01-2013 
	tarihleri arasındaki faturaların tüm bilgilerini listeleyiniz */
	

	select *
	from invoices
	where InvoiceDate>='2012-01-01' and InvoiceDate<= '2013-01-02 00:00:00';
	
	select *
	from invoices
	where InvoiceDate>='2012-01-01' and InvoiceDate<= '2013-01-02';     --saati belirtmezsek eksik veriyor veriyi
	
	select *
	from invoices
	where InvoiceDate>='2012-01-01 00:00:00' and InvoiceDate<= '2013-01-02 00:00:00';


	select *
	from invoices
	where InvoiceDate>="2012-01-01 00:00:00" and InvoiceDate<= "2013-01-02 00:00:00";   --tek tirnak cift tirnak bazen farkli sonuc verebilir ya da cift tirnakta calismayabilir
	
	/* invoices tablosunda fatura tarihi (InvoiceDate) 2009 ila 2011 tarihleri arasındaki
 en yeni faturayı listeleyen sorguyu yazınız */
 
	select *
	from invoices
	where InvoiceDate between '2009-01-01' and '2011-01-01' 
	order by InvoiceDate DESC limit 1;
	/* students tablosunda grade sütunu 89 ile 96 arasinda olan ogrencilerin tum bilgilerini sorgulayiniz */
	select *
	from students
	where grade between 89 and 96   --rakamlari tirnaksiz yaziyoruz
	order by Grade;
	
	/*===================================================
					   IN
====================================================*/
	/* customers tablosunda Belgium, Norway veya  Canada  ülkelerinden sipariş veren
		müşterilerin FirstName ve LastName bilgilerini listeyiniz	*/
		
	select FirstName, LastName, country
	from customers
	where country IN ('Belgium', 'Norway', 'Canada');
	
	/*===================================================
					 LIKE
====================================================*/
	/* tracks tablosunda Composer sutunu Bach ile biten kayıtların Name bilgilerini 
	listeyen sorguyu yazınız*/
	
	select name ,Composer
	from tracks
	where Composer like '%Bach';
	
	select FirstName, LastName, country
	from customers
	where country like 'B%' or  country like 'U%';
	
	/* albulms tablosunda Title (başlık) sutununda Greatest içeren kayıtların tüm bilgilerini 
	listeyen sorguyu yazınız*/
	select * 
	from albums
	where Title like '%Greatest%';
	
		/* invoices tablosunda, 2010 ve 2019 arası bir tarihte (InvoiceDate) Sadece şubat
	aylarında gerçekleşmiş olan faturaların	tüm bilgilerini listeleyen sorguyu yazınız*/
	select *
	from invoices
	where InvoiceDate 
	like '201_-02%';
	
	/* customers tablosunda, isimleri (FirstName) üç harfli olan müşterilerin FirstName, 
	LastName ve City bilgilerini	listeleyen sorguyu yazınız*/
	select FirstName, LastName, city
	from customers
	where FirstName like '___';
	
	/* customers tablosunda, soyisimleri Sch veya Go ile başlayan müşterilerin FirstName, 
	LastName ve City bilgilerini listeleyen sorguyu yazınız*/
	select FirstName, LastName, city
	from customers
	where LastName like 'Sch%' or LastName like 'Go%';
	
	
	