/*
1. Answer the following questions according to SampleRetail Database
1. Beantworten Sie die folgenden Fragen gemäß SampleRetail Database
What is the sales quantity of product according to the brands and sort them highest-lowest?
Wie hoch ist die Verkaufsmenge des Produkts nach den Marken und 
sortieren Sie sie am höchsten und am niedrigsten?
*/


select C.brand_id, C.brand_name, sum(A.quantity) as total_sales
from sale.order_item as A,product.product as B,product.brand as C
where A.product_id=B.product_id and B.brand_id=C.brand_id
group by C.brand_id,C.brand_name
order by total_sales desc

/*
Select the top 5 most expensive products.
Wählen Sie die 5 teuersten Produkte aus.
*/
select TOP 5  A.product_id, B.product_name, avg(A.list_price) as exp_prices
from sale.order_item as A, product.product as B
where A.product_id=B.product_id
group by A.product_id, B.product_name
order by  exp_prices DESC

select TOP 5  B.product_id, B.product_name, avg(B.list_price) as exp_prices
from  product.product as B
group by B.product_id, B.product_name
order by  exp_prices DESC

/*
What are the categories that each brand has?
Welche Kategorien hat jede Marke?
*/
select  distinct A.brand_name, C.category_name
from product.brand as A,product.product as B, product.category as C
where A.brand_id=B.brand_id and B.category_id=C.category_id
order by A.brand_name asc, C.category_name asc


select A.brand_name, C.category_name
from product.brand as A,
	(select distinct D.brand_id, D.category_id
	from product.product as D) as B, product.category as C
where A.brand_id=B.brand_id and B.category_id=C.category_id
order by A.brand_name asc, C.category_name asc

/*
Select the avg prices according to brands and categories.
Wählen Sie die Durchschnittspreise nach Marken und Kategorien aus.
*/
select  A.brand_name, C.category_name, AVG( B.list_price) as avg_price
from product.brand as A,product.product as B, product.category as C 
where A.brand_id=B.brand_id and B.category_id=C.category_id
group by A.brand_name, C.category_name
order by A.brand_name asc, C.category_name asc

select  A.brand_name, C.category_name, AVG(D.list_price) as avg_price
from product.brand as A,product.product as B, product.category as C, 
	(select distinct F.product_id, F.list_price
	from sale.order_item as F) as D
where A.brand_id=B.brand_id and B.category_id=C.category_id and D.product_id=B.product_id
group by A.brand_name, C.category_name
order by  A.brand_name asc, C.category_name asc

/*
Select the annual amount of product produced according to brands.
Wählen Sie die jährlich produzierte Produktmenge nach Marken aus.
*/
select C.brand_name, B.model_year, sum(A.quantity)
from product.stock as A, product.product as B, product.brand as C
where B.brand_id=C.brand_id and A.product_id=B.product_id
group by  C.brand_name, B.model_year
order by  C.brand_name

/*
Select the store which has the most sales quantity in 2018.
Wählen Sie das Geschäft mit der höchsten Verkaufsmenge im Jahr 2018 aus.
*/

select Top 1 B.store_id, SUM(C.quantity) as total_quantity
from sale.store as A, sale.orders as B, sale.order_item as C
where A.store_id=B.store_id and B.order_id=C.order_id and DATEPART(year, B.order_date)='2018'
group by B.store_id
order by total_quantity desc



/*
Select the store which has the most sales amount in 2018
Wählen Sie das Geschäft mit den meisten Verkäufen im Jahr 2018
*/
select Top 10 B.store_id, SUM(C.quantity*C.list_price) as total_sales
from sale.store as A, sale.orders as B, sale.order_item as C
where A.store_id=B.store_id and B.order_id=C.order_id and DATEPART(year, B.order_date)='2018'
group by B.store_id
order by total_sales desc

/*
Select the personnel which has the most sales amount in 2018
Wählen Sie das Personal mit den meisten Umsätzen im Jahr 2018 aus
*/
select Top 10 B.staff_id, A.first_name,A.last_name, SUM(C.quantity*C.list_price) as total_sales
from sale.staff as A, sale.orders as B, sale.order_item as C
where A.staff_id=B.staff_id and B.order_id=C.order_id and DATEPART(year, B.order_date)='2018'
group by B.staff_id,A.first_name,A.last_name
order by total_sales desc


/*
1. What is the difference between WHERE and HAVING clause in SQL?
1. Was ist der Unterschied zwischen der WHERE- und der HAVING-Klausel in SQL?
	'Where' führt Einschränkungen für 'Tabellen' ein, 
	die in 'From' angegeben sind, während 'Having' Beschränkungen 
	für die Aggregatfunktion basierend auf der Gruppierung auferlegt.

2. What is an SQL View?
2. Was ist eine SQL-View?
	In einer Datenbank ist eine Ansicht die Ergebnismenge einer gespeicherten Abfrage der Daten.
3. What is a primary key and a foreign key?
3. Was ist ein primary key und ein foreign key?
	Ein Primary key wird verwendet, um sicherzustellen, 
	dass die Daten in der jeweiligen Spalte eindeutig sind. 
	Ein Foreign Key ist eine Spalte oder eine Gruppe von 
	Spalten in einer relationalen Datenbanktabelle, die eine 
	Verknüpfung zwischen Daten in zwei Tabellen herstellt.
4. What is the difference/s between UNION and UNION ALL?
4. Was ist der/die Unterschied/e zwischen UNION und UNION ALL?
	Der einzige Unterschied zwischen Union und Union All besteht darin, 
	dass Union die Zeilen extrahiert, die in der Abfrage angegeben werden, 
	während Union All alle Zeilen einschließlich der Duplikate (wiederholte Werte) 
	aus beiden Abfragen extrahiert.

*/

