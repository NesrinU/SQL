----
--Percentile_cont

--percentile_disc

select list_price,
PERCENTILE_CONT(0.75) within group (order by list_price) over () median1,
PERCENTILE_DISC(0.75) within group (order by list_price) over () median2
from product.product

select list_price,
PERCENTILE_CONT(0.50) within group (order by list_price) over () median1,
PERCENTILE_DISC(0.50) within group (order by list_price) over () median2
from product.product

------------

--Q: write a query that returns the cumulative distribution of the list price in product table by brand.
--product tablosundaki list pricelarin 

SELECT brand_id, list_price,
ROUND(CUME_DIST () OVER(PARTITION BY brand_id ORDER BY list_price),3) as CUM_DST
FROM product.product

from product.product


--Q:Write a query that returns both of the followings:
--The average product price of orders.
--Average net amount.
--Aşağıdakilerin her ikisini de döndüren bir sorgu yazın:
--Siparişlerin ortalama ürün fiyatı.
--Ortalama net tutar.

select distinct order_idct , 
AVG(list_price) over (partition by order_id) avg_price_of_prod,
avg(quantity*list_price*(1-discount)) over() 
from sale.order_item

--Q: List orders for which the avarage product price is higher than the average net amount.

with T1 as
(
select distinct order_id , 
AVG(list_price) over (partition by order_id) avg_price_of_prod,
avg(quantity*list_price*(1-discount)) over() avg_net_amount
from sale.order_item
)
select * 
from T1 
where avg_price_of_prod> avg_net_amount


with T1 as
(select distinct order_id,avg(list_price) over (partition by order_id order by order_id asc) avg_per_order
from[sale].[order_item] 
)
select *, (select distinct avg(list_price*quantity*(1-discount)) over () sum_per_order
from[sale].[order_item] ) avg_net_amount
from T1
where avg_per_order > (select distinct avg(list_price*quantity*(1-discount)) over () sum_per_order
from[sale].[order_item] )

--Q:Calculate the stores' weekly cumulative number of orders for 2018
--mağazaların 2018 yılına ait haftalık kümülatif sipariş sayılarını hesaplayınız

select distinct a.store_id, a.store_name, datepart(week,b.order_date) week_of_year , 
count(b.order_id) over (partition by  datepart(week,b.order_date), a.store_id)   cnt_order_by_week,
count(b.order_id) over (partition by   a.store_id order by datepart(wk, order_date))
from sale.store a , sale.orders b
where a.store_id= b.store_id
and year(b.order_date)= '2018'
order by 1, 3


-----
select distinct a.store_id, a.store_name, order_date, 
count(b.order_id) over (partition by  order_date, a.store_id)   cnt_order_by_week,
count(b.order_id) over (partition by   a.store_id order by order_date)
from sale.store a , sale.orders b
where a.store_id= b.store_id
and year(b.order_date)= '2018'
order by 1, 3

----
select list_price , sum(list_price) over (order by list_price rows between unbounded preceding and current row)
from product.product

--Q:--Calculate 7-day moving average of the number of products sold between '2018-03-12' and '2018-04-12'.
--'2018-03-12' ve '2018-04-12' arasında satılan ürün sayısının 7 günlük hareketli ortalamasını hesaplayın.

with T1 as
(
select distinct a.order_date , sum(quantity) over (partition by a.order_date) cnt_product
from sale.orders a, sale.order_item b
where a.order_id= b.order_id
and a.order_date between '2018-03-12' and '2018-04-12'
)
select order_date, cnt_product,
       avg(cnt_product) over (order by order_date rows between 6 preceding and current row)
from T1

