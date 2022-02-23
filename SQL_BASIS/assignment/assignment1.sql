/*Assignment - 1
Instructions:  
There are multiple questions.
Use chinook database to answer the questions.
Please paste your answers (statements) as a plain text using the related question number.
Good Luck!*/
--Questions:
--1. Write a query that displays InvoiceId, CustomerId and total dollar amount for each invoice, sorted first by CustomerId (in ascending order), and then by total dollar amount  (in descending order).

select InvoiceId, CustomerId, total dollar from invoices order by  CustomerId ASC , total DESC;


/*2. Write a query that displays InvoiceId, CustomerId and total dollar amount for each invoice, but this time sorted first by total dollar amount (in descending order), and then by CustomerId (in ascending order).*/

select InvoiceId, CustomerId, total dollar from invoices order by total DESC, CustomerId ASC;

/*3. Compare the results of these two queries above. How are the results different when you switch the column you sort on first? (Explain it in your own words.)

/*3.Answer
ilk sorguda önce MüşteriKimliği'ne göre (CustomerId) artan düzende sıraladi , ardindan ayni id numarasina sahip faturalari (invoice) tutarlarina gore azalan sekilde siraladi.ikinci soruda ise once tutarlari azalan sekilde siraladi , ayni tutara sahip faturalari customerid'lerine gore artan sekilde siraladi.*/

/*4. Write a query to pull the first 10 rows and all columns from the invoices table that have a dollar amount of total greater than or equal to 10.*/

	SELECT * FROM invoices
	WHERE total >=10
	LIMIT 10;

/*5. Write a query to pull the first 5 rows and all columns from the invoices table that have a dollar amount of total less than 10.*/

	SELECT * FROM invoices
	WHERE total < 10
	LIMIT 5;

/*6. Find all track names that start with 'B' and end with 's'.*/

    SELECT * FROM tracks WHERE Name LIKE 'B%s';



/*7. Use the invoices table to find all information regarding invoices whose billing address is USA or Germany or Norway or Canada and invoice date is at any point in 2010, sorted from newest to oldest.*/

    SELECT * FROM invoices
	WHERE BillingCountry in ('USA', 'Germany', 'Norway', 'Canada') AND  InvoiceDate LIKE '2010%'
    ORDER BY InvoiceDate DESC ;

