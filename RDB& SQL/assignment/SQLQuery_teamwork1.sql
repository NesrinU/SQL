/* Answer the following questions according to SampleRetail Database*/

-- 1)What is the sales quantity of product according to the brands and sort them highest-lowest?

select a.brand_id, a.brand_name, sum(c.quantity) cnt
from product.brand a, product.product b, sale.order_item c
where a.brand_id= b.brand_id 
and b.product_id= c.product_id
group by a.brand_name, a.brand_id
order by sum(c.quantity) desc


-- 2)Select the top 5 most expensive products.

select TOP 5 a.product_name , avg(b.list_price) max_price
from product.product a, sale.order_item b
where  a.product_id= b.product_id
group by a.product_name
order by  avg(b.list_price) desc

select top 5 [product_name], [list_price]
from [product].[product]
order by [list_price] desc;



-- 3)What are the categories that each brand has?



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

-- 4)Select the avg prices according to brands and categories.

select a.brand_name , b.category_id, avg(c.list_price) avr_price
from product.brand a, product.product b , sale.order_item c
where a.brand_id= b.brand_id
and b.product_id= c.product_id
group by brand_name, category_id
order by 1, 2

-- 5)Select the annual amount of product produced according to brands.

select a.brand_name , b.model_year, sum(c.quantity) summ
from product.brand a, product.product b, product.stock c
where a.brand_id= b.brand_id
and b.product_id= c.product_id
group by brand_name, model_year
order by 1, 2


-- 6)Select the store which has the most sales quantity in 2018.

 select Top 1 B.store_id, SUM(C.quantity) as total_quantity
from sale.store as A, sale.orders as B, sale.order_item as C
where A.store_id=B.store_id and B.order_id=C.order_id and DATEPART(year, B.order_date)='2018'
group by B.store_id
order by total_quantity desc


-- 7)Select the store which has the most sales amount in 2018

 select Top 1 B.store_id, SUM(c.list_price*c.quantity) as total_quantity
from sale.store as A, sale.orders as B, sale.order_item as C
where A.store_id=B.store_id and B.order_id=C.order_id and DATEPART(year, B.order_date)='2018'
group by B.store_id
order by total_quantity desc



-- 8)Select the personnel which has the most sales amount in 2018

select Top 10 B.staff_id, A.first_name,A.last_name, SUM(C.quantity*C.list_price) as total_sales
from sale.staff as A, sale.orders as B, sale.order_item as C
where A.staff_id=B.staff_id and B.order_id=C.order_id and DATEPART(year, B.order_date)='2018'
group by B.staff_id,A.first_name,A.last_name
order by total_sales desc

