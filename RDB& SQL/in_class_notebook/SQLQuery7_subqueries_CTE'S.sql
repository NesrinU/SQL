/*      Subquaries            */
/*

A subquery is a SELECT statement that is nested within another statement. 

A subquery may be used in:

SELECT clause
FROM clause
WHERE clause

There are some rules when using subquery:
-A subquery must be enclosed in parentheses.
-An ORDER BY clause is not allowed to use in a subquery.
-The BETWEEN operator can't be used with a subquery. But you can use BETWEEN within the subquery.*/





/*Single-Row Subqueries

Single-row subqueries return one row with only one column 
and are used with single-row operators such as =, >, >=, <=, <>, !=  */

--Q: write a query that returns the total list price by each order ids

select  distinct order_id ,
        (select  sum(quantity*list_price) 
		from sale.order_item B 
		where A.order_id= B.order_id) as list_prc
from sale.order_item A

--Q: Bring all the staff from the store that Davis Thomas works

select * 
from sale.staff
where first_name= 'Davis'
and last_name = 'Thomas'

select *
from sale.staff
where store_id = (
					select store_id 
					from sale.staff
					where first_name= 'Davis'
					and last_name = 'Thomas' )


--Q: list the staff that charles cussana is the manager of 

select * 
from sale.staff
where first_name= 'Charles'
and last_name = 'Cussona'

select *
from sale.staff
where manager_id= (
					select staff_id 
					from sale.staff
					where first_name= 'Charles'
                    and last_name = 'Cussona')

--Q: write a query that returns customers in the city where 'The BFLO Store' is located.

select city  from sale.store
where store_name='The BFLO Store'

select * 
from sale.customer
where city= (
             select city  from sale.store
             where store_name='The BFLO Store'
			 )

--Q: list bikes that are more expensive than the 'Pro-Series 49-Class Full HD Outdoor LED TV (Silver)' bike 

select *
from product.product
where list_price> (
					select list_price
					from product.product
					where product_name='Pro-Series 49-Class Full HD Outdoor LED TV (Silver)'
					)

--Q:list customers whoose order dates are before Hassan Pope 

select A.customer_id, a.first_name, a.last_name , b.order_id, b.order_date 
from sale.customer A, sale.orders B
where A.customer_id= B.customer_id
and order_date < (
                  select order_date 
				  from sale.customer A, sale.orders B
				  where A.customer_id= B.customer_id               
				  and first_name= 'Hassan'
				  and last_name= 'Pope'
				  )


select order_date 
from sale.customer A, sale.orders B
where A.customer_id= B.customer_id               
and first_name= 'Hassan'
and last_name= 'Pope'




/*Multiple-Row Subqueries

Multiple-row subqueries return sets of rows 
and are used with multiple-row operators such as IN, NOT IN, ANY, ALL.*/

  --Q: List all customers who orders on the same dates as Elanor Deleon
  -- Elanor	Deleon isimli müşterinin alışveriş yaptığı tarihte/tarihlerde alışveriş yapan tüm müşterileri listeleyin.
-- Müşteri adı, soyadı ve sipariş tarihi bilgilerini listeleyin.
  select *
  from sale.customer a, sale.orders b
  where a.customer_id= b.customer_id
  and b.order_date in (
					  select b.order_date
					  from sale.customer a, sale.orders b
					  where a.first_name='Elanor'
					  and a.last_name= 'Deleon'
					  and a.customer_id= B.customer_id
					  )
-------
  select first_name, last_name
  from sale.customer a, sale.orders b
  where a.customer_id= b.customer_id
  and b.order_date in (
					  select b.order_date
					  from sale.customer a, sale.orders b
					  where a.first_name='Elanor'
					  and a.last_name= 'Deleon'
					  and a.customer_id= B.customer_id
					  )
 except
 select 'Elanor',  'Deleon'

 ---------



  select *
  from sale.customer a, sale.orders b
  where a.customer_id= b.customer_id
  and b.order_date in (
                      select b.order_date
					  from sale.customer a, sale.orders b
					  where a.first_name='Charlesetta'
					  and a.last_name= 'Warner'
					  and a.customer_id= B.customer_id
					  )

--Q: List the products ordered the last 10 orders in Buffalo city.
-- Buffalo şehrinde son 10 siparişten sipariş verilen ürünleri listeleyin.

select distinct product_name
from product.product a, sale.order_item b, ( 
											  select top(10) order_id
											  from sale.orders a, sale.customer b
											  where  a.customer_id= b.customer_id
											  and city= 'Buffalo'
											  order by order_id desc
											  ) c
where 
a.product_id= b.product_id
and b.order_id= c.order_id

-----
SELECT product_name
FROM sale.customer A,sale.orders B,sale.order_item C,product.product D
WHERE A.customer_id = B.customer_id 
AND B.order_id = C.order_id 
AND C.product_id = D.product_id 
AND C.order_id IN (
					SELECT distinct TOP 10  C.order_id
					FROM sale.customer A,sale.orders B,sale.order_item C,product.product D
					WHERE city = 'Buffalo' 
					AND A.customer_id = B.customer_id 
					AND B.order_id = C.order_id 
					AND C.product_id = D.product_id
					ORDER BY C.order_id DESC)

--Q: List products out of 'Game', 'gps', or 'Home Theater' categories and made in 2021.

select a.product_name
from product.product a, product.category b
where a.category_id= b.category_id
and   a.model_year= '2021'
and   b.category_name not in ( 'Game', 'gps', 'Home Theater') 

--Q: list products made in 2020 and its prices more than all products in the 
-- Receivers Amplifiers category

select product_name, model_year, list_price
from product.product 
where  model_year= '2020'
and  list_price > 

all( select a.list_price 
from product.product a, product.category b
where a.category_id= b.category_id
and b.category_name = 'Receivers Amplifiers')

--Q: list products made in 2020 and its prices more than any products in the 
-- Receivers Amplifiers category

select product_name, model_year, list_price
from product.product 
where  model_year= '2020'
and  list_price > 

any( select a.list_price 
from product.product a, product.category b
where a.category_id= b.category_id
and b.category_name = 'Receivers Amplifiers')
order by 3


/*Correlated Subqueries
If a subquery references columns in the outer query 
or to put it another way if a subquery uses values from the outer query, 
that subquery is called a correlated subquery. */





/*  EXISTS   */

select *
from sale.customer
where EXISTS ( 
               select 1
			  )

select *
from sale.customer
where EXISTS ( 
               select 1
			   from sale.customer where customer_id< 0
			  )

select *
from sale.orders A
where exists (
             select *
			 from sale.orders B
			 where order_date > '2020-01-01'
			 and a.order_id= b.order_id
			 )
 -------
 
 select *
from sale.orders A
where exists (
             select *
			 from sale.orders B
			 where order_date > '2020-01-01'
			 )

 SELECT *
FROM sale.customer
WHERE exists ( select NULL)

/*NOT EXISTS
 when we want to get employees who are not in the result of the inner query,
 we can use NOT EXISTS, which negates the logic of the EXISTS operator.*/

 select *
from sale.customer
where NOT EXISTS ( 
               select 1
			  )

select *
from sale.orders A
where not exists (
             select *
			 from sale.orders B
			 where order_date > '2020-01-01'
			 and a.order_id= b.order_id
			 )

select *
from sale.orders A
where order_id not in (
             select order_id
			 from sale.orders B
			 where order_date > '2020-01-01'
			 and a.order_id= b.order_id
			 )

--Q: write a query that returns State where 'Apple - Pre-Owned iPad 3 - 32GB - White' product is not ordered

select distinct state from sale.customer



select distinct state 
from sale.customer X
where not exists (
                  select 1
				  from sale.customer A,sale.orders B,  sale.order_item C, product.product  D
				  where 
				  A.customer_id=B.customer_id
				  and B.order_id= C.order_id
				  and C.product_id= D.product_id
				  and product_name= 'Apple - Pre-Owned iPad 3 - 32GB - White'
				  and A.state= X.state
				  )
----
select distinct C.state
from product.product as A, sale.order_item as B, sale.customer as C, sale.orders as D
where A.product_id=B.product_id and B.order_id=D.order_id and C.customer_id=D.customer_id and
C.state not in (select C.state
				from product.product as A, sale.order_item as B, sale.customer as C, sale.orders as D
				where A.product_name='Apple - Pre-Owned iPad 3 - 32GB - White' and
				A.product_id=B.product_id and B.order_id=D.order_id and C.customer_id=D.customer_id)


--Q:Write a query that returns customers did not place an order before 2020-01-01. 
--If there is a customer placed an order before 2020-01-01 in this query, the query should not return any results.

Select X.customer_id, Y.order_id
from sale.customer X
left join sale.orders Y 
on X.customer_id= Y.customer_id
where not exists (
				select * 
				from  sale.orders B
				where   B.order_date< '2020-01-01'
				and X.customer_id= B.customer_id )

-----
Select X.customer_id
from sale.customer X
inner join sale.orders Y 
on X.customer_id= Y.customer_id
where not exists (
				select * 
				from  sale.orders B
				where   B.order_date<= '2020-01-01'
				and X.customer_id= B.customer_id )
intersect




 /*   Common Table Expressions (CTE's)  / WITH clause or WITH queries 

 Common Table Expression (CTE) is a temporary result set that you can reference 
 or use within another SELECT, INSERT, DELETE, or UPDATE statements.

Common Table Expression exists for the duration of a single statement.
That means they are only usable inside of the query they belong to. 
It is similar to views. In this manner, it's defined as "statement scoped views". 

***Ordinary Common Table Expressions:

WITH query_name [(column_name1, ...)] AS
    (SELECT ...) -- CTE Definition
SELECT * FROM query_name; -- SQL_Statement  */

--Q:List customers who have an order prior to the last order of a customer named Mark Barry and are resident of the Austin city.
-- Mark Barry isimli müşterinin son siparişinden önce sipariş vermiş
--ve Austin şehrinde ikamet eden müşterileri listeleyin.

with T1 as 
(
select max(order_date) max_ord_date
from sale.customer A, sale.orders B
where A.customer_id= B.customer_id
and A.first_name= 'Mark'
and A.last_name= 'Barry'
)
select * 
from T1, sale.orders Y, sale.customer Z
where Y.customer_id= Z.customer_id
and Y.order_date< T1.max_ord_date
order by order_date desc

--Q: list all customers who orders on the same date as Elanor Deleon

with T1 as 
(
select order_date
from sale.customer A, sale.orders B
where A.customer_id= B.customer_id
and A.first_name= 'Elanor'
and A.last_name= 'Deleon'
)
select first_name, last_name 
from T1, sale.orders Y, sale.customer Z
where Y.customer_id= Z.customer_id
and Y.order_date =  T1.order_date



/*
***Recursive Common Table Expressions

WITH table_name (column_list)
AS
(
    -- Anchor member
    initial_query  
    UNION ALL
    -- Recursive member that references table_name.
    recursive_query  
)
-- references table_name
SELECT *
FROM table_name   */

select 0
union all
select 1
union all
select 2


WITH T1
    AS (SELECT 0 AS n -- anchor member
        UNION ALL
        SELECT n + 1 -- recursive member
        FROM   T1
        WHERE  n < 8) -- terminator
SELECT n
FROM T1;

--Q: write a query that returns all staff with their manager_ids



--Q: List customers without less than a $500 order and reside in the city of Charleston.
--List customers' first name and last name ( both of the last name and first name in ascending order). 

select a.first_name, a.last_name
from sale.customer as a, sale.orders as b, sale.order_item as c
where a.customer_id= b.customer_id
and b.order_id= c.order_id
and a.city= 'Charleston'
group by a.first_name, a.last_name
having sum(c.list_price) > 500
order by 2, 1

--Q: List the store names in ascending order that did not have an order between "2018-07-22" and "2018-07-28".                         
