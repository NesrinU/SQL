/*       
GROUP BY with HAVING
  

SELECT column_1, aggregate_function(column_2)
FROM table_name
GROUP BY column_1
HAVING search_condition;

--HAVING is like WHERE but operates on grouped records returned by a GROUP BY.

-- HAVING and WHERE clauses can be in the same query.

☝ Important: HAVING is for aggregate data and WHERE is for non-aggregate data. 
The WHERE clause operates on the data before the aggregation and 
the HAVING clause operates on the data after the aggregation. */ 


-- Q-write a query that checks if any product id is repeated in more than one row in the products table 

select product_id, count(product_id) as pro_count
from product.product
group by product_id
having count(product_id)>1


select product_name, count(product_id) as pro_count
from product.product
group by product_name
having count(product_id)>1

-- Q-write a query that returns category ids with a maximum list price above 4000 or a minumum list price below 500.

select category_id, max(list_price) as maxprice, min(list_price) as minprice
from  [product].[product]
GROUP BY category_id
HAVING max(list_price)> 4000 or min(list_price) <400

-- and olursa 
select category_id, max(list_price) as maxprice, min(list_price) as minprice
from  [product].[product]
GROUP BY category_id
HAVING max(list_price)> 4000 and min(list_price) <400

--Q wite a query that returns the net price paid by the customer for each ordr. ( don't negelect discounts and quantities)

select * from [sale].[order_item]

select order_id, sum(list_price*quantity*(1-discount)) as net_price
from sale.order_item
group by order_id

select order_id, sum(convert(decimal(7,2),list_price)*quantity*(1-discount))
from sale.order_item
group by order_id


--Q- Please write a query to return only the order ids that have an average amount of more than $2000.
--Your result set should include order_id. Sort the order_id in ascending order.

select * from sale.order_item

select order_id
from sale.order_item
group by order_id 
having AVG(list_price) > 2000




/* GROUPING SETS

SELECT
    column1,
    column2,
    aggregate_function (column3)
FROM
    table_name
GROUP BY
    GROUPING SETS (
        (column1, column2),
        (column1),
        (column2),
        ()
);
*/

--- summary Table
create view summary_view as
select b.brand_name, c.category_name, a.model_year, ROUND (SUM(d.list_price* d.quantity* (1-d.discount)), 2) total_net_price
from product.product a, product.brand b, product.category c, sale.order_item d
where a.brand_id= b.brand_id
and a.category_id= c.category_id
and a.product_id = d.product_id
group by b.brand_name, c.category_name, a.model_year

select * from summary_view

select brand_name , category_name, sum(total_net_price)
from summary_view
group by 
     GROUPING SETS(
	              (brand_name),
				  (),
				  (category_name),
				  (brand_name, category_name)
				  )






/* PIVOT 

SELECT [column_name], [pivot_value1], [pivot_value2], ...[pivot_value_n]
FROM 
table_name
PIVOT 
(
 aggregate_function(aggregate_column)
 FOR pivot_column
 IN ([pivot_value1], [pivot_value2], ... [pivot_value_n])
) AS pivot_table_name;
*/

--Q write a query that returns total sakes amount by categories and model years 

select *
from summary_view


select category_name, model_year, sum(total_net_price) sum_pr
from summary_view
group by category_name, model_year
order by 1, 2

SELECT *
FROM
	(
	SELECT	category_name, model_year, total_net_price
	FROM	summary_view
	) A
PIVOT
(
SUM (total_net_price)
FOR category_name
IN ( [Audio & Video Accessories]
	,[Bluetooth]
	,[Car Electronics]
	,[Computer Accessories]
	,[Earbud]
	,[gps]
	,[Hi-Fi Systems]
	,[Home Theater]
	,[mp4 player]
	,[Receivers Amplifiers]
	,[Speakers]
	,[Televisions & Accessories] )
) AS PIVOT_TABLE


SELECT *
FROM
	(
	SELECT	category_name, model_year, total_net_price
	FROM	summary_view
	) A
PIVOT
(
SUM (total_net_price)
FOR model_year
IN ([2018],
    [2019],
	[2021])
) AS PIVOT_TABLE


--Q- write a query that returns the number distributions of the orders according to the days of the week 

select * from sale.orders

select order_id , datename(weekday, order_date) as [dayofweek] from sale.orders 

SELECT *
FROM
(
SELECT order_id, DATENAME(DW,order_date) AS [dayofweek]
FROM sale.orders
) A
PIVOT
(
COUNT(order_id) 
FOR [dayofweek] 
IN ([Sunday],[Monday],[Tuesday],[Wednesday],[Thursday],[Friday],[Saturday])
 ) 
AS pivot_table



SELECT *
FROM
(
SELECT order_id, DATENAME(DW,order_date) AS [dayofweek]
FROM sale.orders
where order_date= '2020-01-19'
) A
PIVOT
(
COUNT(order_id) 
FOR [dayofweek] 
IN ([Sunday],[Monday],[Tuesday],[Wednesday],[Thursday],[Friday],[Saturday])
 ) 
AS pivot_table


--Write a query that returns the count of orders of each day between '2020-01-19' and '2020-01-25'. Report the result using Pivot Table.

SELECT *
FROM
(
SELECT order_id, DATENAME(DW,order_date) AS [dayofweek]
FROM sale.orders
where order_date between  '2020-01-19' and '2020-01-25'
) A
PIVOT
(
COUNT(order_id) 
FOR [dayofweek] 
IN ([Sunday],[Monday],[Tuesday],[Wednesday],[Thursday],[Friday],[Saturday])
 ) 
AS pivot_table



--ROLLUP

/*
SELECT
    d1,
    d2,
    d3,
    aggregate_function(c4)
FROM
    table_name
GROUP BY
    ROLLUP (d1, d2, d3);


Groups for ROLLUP:
1) d1, d2, d3
2) d1, d2, NULL
3) d1, NULL, NULL
4) NULL, NULL, NULL
*/

select brand_name , category_name, sum(total_net_price)
from summary_view
group by 
      rollup(brand_name, category_name)
order by category_name



---cube

/*'SELECT' operatöründe belirtilen tüm alanlar için tüm olası gruplama kombinasyonlarını yapar.
 Sütunların yazıldığı sıra önemli değildir.

 SELECT
    d1,
    d2,
    d3,
    aggregate_function (c4)
FROM
    table_name
GROUP BY
    CUBE (d1, d2, d3);


Groups for CUBE:
1. d1, d2, d3
2. d1, d2, NULL
3. d1, d3, NULL
4. d2, d3, NULL
5. d1, NULL, NULL
6. d2, NULL, NULL
7. d3, NULL, NULL
8. NULL, NULL, NULL

*/

select brand_name , category_name, sum(total_net_price)
from summary_view
group by 
      cube(brand_name, category_name)
order by category_name


select brand_name , category_name, model_year , sum(total_net_price)
from summary_view
group by 
      cube(brand_name, category_name, model_year)
order by model_year

select * from summary_view

select brand_name , model_year , sum(total_net_price) net_pr, avg(total_net_price) avr_pr
from summary_view
group by 
      cube(brand_name, model_year)
order by 1,2


