﻿--Q1: By using view get the average sales by staffs and years using the AVG() aggregate function?
--VIEW kullanarak, AVG() toplama işlevini kullanarak personele ve yıllara göre ortalama satışları elde edin?
create view avg_sale_staff_year as
(
select a.first_name, a.last_name, datepart(year, b.order_date ) as [year], 
avg(c.list_price*c.quantity) as avg_per_year
from sale.staff a, sale.orders b, sale.order_item c
where a.staff_id= b.staff_id
and b.order_id= c.order_id
group by a.first_name, a.last_name, datepart(year, b.order_date )
)

select *
from avg_sale_staff_year
order by 1,2,3

select distinct a.first_name, a.last_name, datepart(year, b.order_date ) as [year], 
avg(c.list_price*c.quantity) over(partition by a.first_name, a.last_name, datepart(year, b.order_date )) as avg_per_year
from sale.staff a, sale.orders b, sale.order_item c
where a.staff_id= b.staff_id
and b.order_id= c.order_id

CREATE VIEW Weekly_Agenda_8_1 AS


--Q2: Select the annual amount of product produced according to brands (use window functions).

select distinct b.brand_name, a.model_year, 
count(a.product_id) over(partition by  b.brand_name, a.model_year)
from product.product a, product.brand b
where a.brand_id= b.brand_id

------
SELECT DISTINCT B.brand_name, P.model_year,



--Q3: Select the least 3 products in stock according to stores.
with cte as
(
select a.store_name, b.product_name,
sum(c.quantity) over(partition by a.store_name, b.product_name ) as quant
from sale.store a, product.product b, product.stock c
where a.store_id= c.store_id
and b.product_id= c.product_id
)
select *, 
rank() over(partition by store_name, product_name, quant order by quant)
from cte 
where quant > 0
order by store_name, quant asc

------

SELECT A.store_name, C.product_name, SUM(B.quantity) product_quantity

SELECT *

------
SELECT	*


--Q4: Return the average number of sales orders in 2020 sales.(for each staff)

SELECT staff_id, COUNT(order_id) num_sales

WITH new_sales AS



------





--Q5: Assign a rank to each product by list price in each brand and get products with rank less than or equal to three.

with cte as
(
select product_id , product_name, brand_id, list_price,
rank() over(partition by brand_id order by list_price desc ) as ranking 
from product.product 
)
select *
from cte
where ranking <= 3


-----SELECT * FROM (