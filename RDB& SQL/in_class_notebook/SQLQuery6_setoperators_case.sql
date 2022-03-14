/*    Union Operator / Union all    */
/*
SELECT column1, column2, ...
  FROM table_A
UNION / UNION ALL
SELECT column1, column2, ...
  FROM table_B
  */


 -- The UNION ALL clause is used to print all the records including duplicate records when combining the two tables.



--Q:List Customer's last names in Charlotte and Aurora

-- Charlotte şehrindeki müşteriler ile Aurora şehrindeki müşterilerin soyisimlerini listeleyin

select last_name 
from sale.customer
where city= 'Charlotte'
union 
select last_name 
from sale.customer
where city= 'Aurora'

----

select last_name 
from sale.customer
where city= 'Charlotte'
union all 
select last_name 
from sale.customer
where city= 'Aurora'

-- IN logical operatörü kullanılarak da yapılabilir.

SELECT	last_name
FROM	sale.customer
WHERE	city IN ('Charlotte', 'Aurora')

--SOME IMPORTANT RULES OF UNION / UNION ALL

--Even if the contents of to be unified columns are different, the data type must be the same.

-- NOT: Sütunların içeriği farklı da olsa veritipinin aynı olması yeterlidir.


SELECT	*
FROM	product.brand
UNION
SELECT	*
FROM	product.category

----------

SELECT	city, 'STATE' AS STATE
FROM	sale.store

UNION ALL

SELECT	state, 1 as city
FROM	sale.store

--The number of columns to be unified must be the same in both queries.

-- Her iki sorguda da aynı sayıda column olması lazım.

SELECT	city, 'Clean' AS street
FROM	sale.store
UNION ALL
SELECT	city
FROM	sale.store;

--Q:Write a query that returns customers who name is ‘Thomas’ or surname is ‘Thomas’. (Don't use 'OR')

select first_name, last_name
from sale.customer
where first_name= 'Thomas'
Union all
select first_name, last_name
from sale.customer
where last_name= 'Thomas'

----
select first_name, last_name
from sale.customer
where first_name= 'Thomas'
Union
select first_name, last_name
from sale.customer
where last_name= 'Thomas'
----
select *
from
(
SELECT	first_name, last_name
FROM	sale.customer
) a,
(
SELECT	first_name, last_name
FROM	sale.customer
) b
where a.first_name=b.last_name


 /*    Intersect Operator

SELECT column1, column2, ...
  FROM table_A
INTERSECT
SELECT column1, column2, ...
  FROM table_B
  */

  --Q: Write a query that returns brands that have products for both 2018 and 2019.

  select a.brand_id, a.brand_name
  from product.brand a, product.product b
  where a.brand_id= b.brand_id
  and model_year= '2018'
  intersect
   select a.brand_id, a.brand_name
  from product.brand a, product.product b
  where a.brand_id= b.brand_id
  and model_year= '2019'

  ----
SELECT	*
FROM	product.brand
WHERE	brand_id IN (
					SELECT	brand_id
					FROM	product.product
					WHERE	model_year = 2018
					INTERSECT
					SELECT	brand_id
					FROM	product.product
					WHERE	model_year = 2019
					)

--Q: Write a query that returns customers who have orders for both 2018, 2019, and 2020

SELECT	first_name, last_name
FROM	sale.customer
WHERE	customer_id IN (
						SELECT	customer_id
						FROM	sale.orders
						WHERE	order_date BETWEEN '2018-01-01' AND '2018-12-31'
						INTERSECT
						SELECT	customer_id
						FROM	sale.orders
						WHERE	order_date BETWEEN '2019-01-01' AND '2019-12-31'
						INTERSECT
						SELECT	customer_id
						FROM	sale.orders
						WHERE	order_date BETWEEN '2020-01-01' AND '2020-12-31'
						)

-----
select a.customer_id, first_name, last_name
from sale.customer a, sale.orders b
where a.customer_id= b.customer_id
and order_date like '2018%'
intersect
select a.customer_id, first_name, last_name
from sale.customer a, sale.orders b
where a.customer_id= b.customer_id
and order_date like '2019%'
intersect
select a.customer_id, first_name, last_name
from sale.customer a, sale.orders b
where a.customer_id= b.customer_id
and order_date like '2020%'


  /*   Except Operator

SELECT column1, column2, ...
  FROM table_A
EXCEPT
SELECT column1, column2, ...
  FROM table_B*/

--Q: Write a query that returns brands that have a 2018 model product but not a 2019 model product.
-- 2018 model bisiklet markalarından hangilerinin 2019 model bisikleti yoktur?
-- brand_id ve brand_name değerlerini listeleyin


SELECT	*
FROM	product.brand
WHERE	brand_id IN (
					SELECT	brand_id
					FROM	product.product
					WHERE	model_year = 2018
					EXCEPT
					SELECT	brand_id
					FROM	product.product
					WHERE	model_year = 2019
					)

-----
SELECT	a.brand_id, b.brand_name
FROM	product.product a, product.brand b
WHERE	a.brand_id= b.brand_id
and model_year = 2018
EXCEPT
SELECT	a.brand_id, b.brand_name
FROM	product.product a, product.brand b
WHERE	a.brand_id= b.brand_id
and     model_year = 2019

--Q: Write a query that returns only products ordered in 2019 (not ordered in other years).
--Sadece 2019 yılında sipariş verilen diğer yıllarda sipariş verilmeyen ürünleri getiriniz.

SELECT	product_id, product_name
FROM	product.product
WHERE	product_id IN (
						SELECT	B.product_id
						FROM	sale.orders A, sale.order_item B
						WHERE	A.order_id = B.order_id AND
								A.order_date BETWEEN '2019-01-01' AND '2019-12-31'
						EXCEPT
						SELECT	B.product_id
						FROM	sale.orders A, sale.order_item B
						WHERE	A.order_id = B.order_id AND
								A.order_date not BETWEEN '2019-01-01' AND '2019-12-31'
						)

----
select a.product_id, product_name 
from product.product a , sale.order_item b, sale.orders c
where a.product_id= b.product_id
and b.order_id= c.order_id
and order_date between '2019-01-01' and '2019-12-31'
except
select a.product_id, product_name 
from product.product a , sale.order_item b, sale.orders c
where a.product_id= b.product_id
and b.order_id= c.order_id
and order_date not between '2019-01-01' and '2019-12-31' 

----
select a.product_id, product_name 
from product.product a , sale.order_item b, sale.orders c
where a.product_id= b.product_id
and b.order_id= c.order_id
and year(c.order_date) = '2019'
except
select a.product_id, product_name 
from product.product a , sale.order_item b, sale.orders c
where a.product_id= b.product_id
and b.order_id= c.order_id
and year(c.order_date) = '2020'
except
select a.product_id, product_name 
from product.product a , sale.order_item b, sale.orders c
where a.product_id= b.product_id
and b.order_id= c.order_id
and year(c.order_date) = '2018'

-- List customers who ordered products in the computer accessories, speakers, and mp4 player categories in the same order.
-- Aynı siparişte hem mp4 player, hem Computer Accessories hem de Speakers kategorilerinde ürün sipariş veren müşterileri bulunuz.

SELECT	A.first_name, A.last_name
FROM	sale.customer A, sale.orders B
WHERE	A.customer_id = B.customer_id AND
		B.order_id IN	(
						SELECT	A.order_id
						FROM	sale.order_item A, product.product B
						WHERE	A.product_id = B.product_id AND
								B.category_id = (SELECT	category_id
												FROM	product.category
												WHERE	category_name = 'Computer Accessories')
						INTERSECT
						SELECT	A.order_id
						FROM	sale.order_item A, product.product B
						WHERE	A.product_id = B.product_id AND
								B.category_id = (SELECT	category_id
												FROM	product.category
												WHERE	category_name = 'Speakers')
						INTERSECT
						SELECT	A.order_id
						FROM	sale.order_item A, product.product B
						WHERE	A.product_id = B.product_id AND
								B.category_id = (SELECT	category_id
												FROM	product.category
												WHERE	category_name = 'mp4 player')
						)


  /*     Case Expression   */

  /* Simple CASE Expression

  CASE case_expression
  WHEN when_expression_1 THEN result_expression_1
  WHEN when_expression_1 THEN result_expression_1
  ...
  [ ELSE else_result_expression ]
END */

--Q: Generate a new column containing what ist the meaning of the values in the Order_Status column 
-- 1= Pending; 2= processing; 3= Rejected ; 4= Completed 

select order_id, order_status,
case order_status 
		when 1 then 'Pending'
		when 2 then 'Processing'
		when 3 then 'Rejected'
		else 'Completed'
END AS order_status_desc
from sale.orders
order by 2


 

/* Searched CASE Expression

CASE
  WHEN condition_1 THEN result_1
  WHEN condition_2 THEN result_2
  WHEN condition_N THEN result_N
  [ ELSE result ]
END

exaple : 
When salary < $55,000 THEN 'Low'
When salary is between $55,000 and $80,000 THEN 'Middle'
When salary > $80,000 THEN 'High' */


--Q: Add a column to the sale.staff table containing the store names of the employees.
-- 1= Davi Techno Retail; 2=The BFLO Store; 3= Burkes Outlet

SELECT first_name,last_name,store_id,
CASE
	WHEN store_id = 1 THEN 'Davi Techno Retail'
	WHEN store_id = 2 THEN 'The BFLO Store'
	WHEN store_id = 3 THEN 'Burkes Outlet'   --(else then 'Burkes Outlet')
END AS store_name
FROM sale.staff

--Q- Cresate a new column containing the labels of customers ' email service providers (Gmail, Hotmail, Yahoo or Other)  

select first_name,last_name, email, 
case
    when email  like '%@hotmail%'  then 'Hotmail' 
	when email  like '%@gmail%' then 'Gmail'
	when email  like '%@yahoo%' then 'Yahoo'
	else 'Other'
	END AS email_service_provider
FROM sale.customer

--alternative
select first_name, last_name,email,
case
WHEN PATINDEX ('%gmail%',email) > 0 THEN 'Gmail'
	WHEN PATINDEX( '%hotmail%',email) > 0 THEN 'Hotmail'
	WHEN PATINDEX( '%yahoo%',email) > 0 THEN 'Yahoo'
	ELSE 'Other'
END AS email_service_provider
FROM sale.customer;

--ne kadar oldugunu bulmak icin 

select first_name, last_name,email,
case
WHEN PATINDEX ('%gmail%',email) > 0 THEN 'Gmail'
	WHEN PATINDEX( '%hotmail%',email) > 0 THEN 'Hotmail'
	WHEN PATINDEX( '%yahoo%',email) > 0 THEN 'Yahoo'
	ELSE 'Other'
END AS email_service_provider
FROM sale.customer
group by case
WHEN PATINDEX ('%gmail%',email) > 0 THEN 'Gmail'
	WHEN PATINDEX( '%hotmail%',email) > 0 THEN 'Hotmail'
	WHEN PATINDEX( '%yahoo%',email) > 0 THEN 'Yahoo'
	ELSE 'Other'
END 

--Q: List customers ordered products in the computer accessories , speakers, and mp4 player categories in the same order.

select E.first_name, E.last_name
from sale.orders as A, sale.order_item as B, product.product as C, product.category as D, sale.customer as E
where A.order_id=B.order_id and B.product_id=C.product_id and  E.customer_id=A.customer_id and C.category_id=D.category_id
and D.category_name='Computer Accessories'
intersect
select E.first_name, E.last_name
from sale.orders as A, sale.order_item as B, product.product as C, product.category as D, sale.customer as E
where A.order_id=B.order_id and B.product_id=C.product_id and  E.customer_id=A.customer_id and C.category_id=D.category_id
and D.category_name='mp4 player'
intersect
select E.first_name, E.last_name
from sale.orders as A, sale.order_item as B, product.product as C, product.category as D, sale.customer as E
where A.order_id=B.order_id and B.product_id=C.product_id and  E.customer_id=A.customer_id and C.category_id=D.category_id
and D.category_name='Speakers'

-- alternative 

select A.customer_id, A.first_name, A.last_name, C.order_id,
		sum(case when E.category_name= 'mp4 player' then 1 else 0 end) as C1,
		sum(case when E.category_name= 'Speakers' then 1 else 0 end) as C2,
		sum(case when E.category_name= 'Computer Accessories' then 1 else 0 end) as C3

from sale.customer A, sale.orders B , sale.order_item C, product.product D, product.category E
where A.customer_id= B.customer_id
and B.order_id= C.order_id
and C.product_id= D.product_id
and D.category_id= E.category_id
group by 
       A.customer_id, A.first_name, A.last_name, C.order_id
having 
      sum(case when E.category_name= 'mp4 player' then 1 else 0 end) > 0
	  and
	  sum(case when E.category_name= 'Speakers' then 1 else 0 end) >0
	  and
	  sum(case when E.category_name= 'Computer Accessories' then 1 else 0 end) >0

-----
select  A.first_name, A.last_name
from sale.customer A, sale.orders B , sale.order_item C, product.product D, product.category E
where A.customer_id= B.customer_id
and B.order_id= C.order_id
and C.product_id= D.product_id
and D.category_id= E.category_id
group by 
       A.customer_id, A.first_name, A.last_name, C.order_id
having 
      sum(case when E.category_name= 'mp4 player' then 1 else 0 end) > 0
	  and
	  sum(case when E.category_name= 'Speakers' then 1 else 0 end) >0
	  and
	  sum(case when E.category_name= 'Computer Accessories' then 1 else 0 end) >0


/*Q: write a query that returns the number dustributions of the others in the previous query result, 
according to the days of the week
önceki sorgu sonucunda diğerlerinin sayı dağılımlarını döndüren bir sorgu yazın,haftanın günlerine göre*/

SELECT [Sunday], [Monday], [Tuesday],[Wednesday],[Thursday],[Friday],[Saturday]
FROM 
(
select order_id, dayss
from (SELECT
       CASE DATEPART(WEEKDAY, order_date)
        WHEN 1 THEN 'Sunday' 
        WHEN 2 THEN 'Monday' 
        WHEN 3 THEN 'Tuesday' 
        WHEN 4 THEN 'Wednesday' 
        WHEN 5 THEN 'Thursday' 
        WHEN 6 THEN 'Friday' 
        WHEN 7 THEN 'Saturday' 
      END AS dayss,order_id
     FROM     sale.orders) as tt
) AS SourceTable
PIVOT 
(
 count(order_id)
 FOR dayss
 IN ([Sunday], [Monday], [Tuesday],[Wednesday],[Thursday],[Friday],[Saturday])
) AS pivot_table;

--alternative

select DATENAME(WEEKDAY, order_date) as dayofwek , count(order_id) cnt_order
from sale.orders
group by DATENAME(WEEKDAY, order_date)
----
select SUM(case when DATENAME(WEEKDAY, order_date)= 'Monday' then 1 else 0 end) as  MONDAY,
       SUM(case when DATENAME(WEEKDAY, order_date)= 'Tuesday' then 1 else 0 end) TUESDAY,
	   SUM(case when DATENAME(WEEKDAY, order_date)= 'Wednesday' then 1 else 0 end) WEDNESDAY,
	   SUM(case when DATENAME(WEEKDAY, order_date)= 'Thursday' then 1 else 0 end) THURSDAY,
	   SUM(case when DATENAME(WEEKDAY, order_date)= 'Friday' then 1 else 0 end) FRIDAY,
	   SUM(case when DATENAME(WEEKDAY, order_date)= 'Saturday' then 1 else 0 end) SATURDAY,
	   SUM(case when DATENAME(WEEKDAY, order_date)= 'Sunday' then 1 else 0 end) SUNDAY
from sale.orders
where DATE



--Q- List counts of orders on the weekend and weekdays. (First weekend)



/*Q-Classify staff according to the count of orders they receive as follows:

a) 'High-Performance Employee' if the number of orders is greater than 400
b) 'Normal-Performance Employee' if the number of orders is between 100 and 400
c) 'Low-Performance Employee' if the number of orders is between 1 and 100
d) 'No Order' if the number of orders is 0
Then, list employees' first name, last name, employee class, and count of orders in ascending order.*/

select * from sale.staff
select * from sale.orders

select  a.first_name, a.last_name, 
case 
when count(b.order_id)> 400 then 'High-Performance Employee' 
when count(b.order_id) between 100 and 400 then 'Normal-Performance Employee' 
when count(b.order_id) between 1 and 100 then 'Low-Performance Employee'
when count(b.order_id)= 0 then 'No Order'
end as employee_class, 
count(b.order_id) as cnt 
from sale.staff a
left join sale.orders b 
on a.staff_id = b.staff_id
group by a.staff_id , a.first_name, a.last_name
order by count(b.order_id)


select a.staff_id , a.first_name, a.last_name , count(b.order_id) as cnt 
from sale.staff a
left join sale.orders b 
on a.staff_id = b.staff_id
group by a.staff_id, a.first_name, a.last_name



select staff_id , count(order_id) as cnt 
from  sale.orders 
group by staff_id
order by staff_id