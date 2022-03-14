--Q: what is the name of the cheapest product?(use fist_value)
select * from product.product

select top 1
first_value(product_name) over( order by list_price asc) as cheapest_product
from product.product  
------

select distinct category_id, 
first_value(product_name) over( partition by category_id order by list_price asc) as cheapest_product
from product.product


select * from product.product order by list_price

--Q: How to add list price of the cheapest product?


select distinct
last_value(product_name) over( order by list_price desc rows between unbounded preceding and unbounded following) as cheapest_product
from product.product 

/* Lag() & Lead() Functions

Lag() : Returns the value in previous rows for each row of sorted column values.

Lead():returns the value in next rows for each row of sorted column values.*/

--Q: write a query that returns the order date of the one previous sale of each staff(use the LAG function)

select a.order_id, a.staff_id, b.first_name, b.last_name, a.order_date,
LAG(a.order_date) over (partition by a.staff_id order by a.order_date) as previous_order_date 
from sale.orders a, sale.staff b
where a.staff_id= b.staff_id
order by a.staff_id, order_id
-----
select a.order_id, a.staff_id, b.first_name, b.last_name, a.order_date,
isnull( cast(LAG(a.order_date,1) over (partition by a.staff_id order by a.order_date)as varchar(20)),'first_order') as previous_order_date 
from sale.orders a, sale.staff b
where a.staff_id= b.staff_id
order by a.staff_id, order_id

--Q: write a query that returns the order date of the one next sale of each staff(use the lead function)

select a.order_id, a.staff_id, b.first_name, b.last_name, a.order_date,
Lead(a.order_date) over (partition by a.staff_id order by a.order_date) as previous_order_date 
from sale.orders a, sale.staff b
where a.staff_id= b.staff_id
order by a.staff_id, order_id
------
select a.order_id, a.staff_id, b.first_name, b.last_name, a.order_date,
isnull( cast(Lead(a.order_date,1) over (partition by a.staff_id order by a.order_date)as varchar(20)),'last_order') as previous_order_date 
from sale.orders a, sale.staff b
where a.staff_id= b.staff_id
order by a.staff_id, order_id

--Q: write a query taht returns the difference in the order count between the current month and the next month by year.

select year(order_date), 
month(order_date) as ord_month, count(order_id) as cnt_order,
lead(month(order_date)) over(partition by year(order_date) order by year(order_date)) as next_month,
lead(count(order_id)) over (partition by year(order_date) order by year(order_date)) as next_month_order_cnt,
count(order_id)-lead(count(order_id)) over ( order by year(order_date)) as order_diff
from sale.orders
group by year(order_date), month(order_date)
order by 1, 2 asc
------
with T1 as
(
select year(order_date), 
month(order_date) as ord_month, count(order_id) over( partition by year(order_date), month(order_date)) cnt_order
from sale.orders
)
select *,
        lead(ord_month) over (partition by ord_year order by order_year, ord_month) next_month,
		lead(cnt_order) over (partition by ord_year order by order_year, ord_month) next_month,



/* Numeric Functions 
Row_Number()
Rank()
Dense_Rank()*/ 

--Assign an ordinal number to the product prices for each category in ascending order
--1. Herbir kategori içinde ürünlerin fiyat siralamasini yapiniz (artan fiyata göre 1'den baslayip birer birer artacak)


SELECT category_id, list_price, 
ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY list_price) AS ROW_NUM
FROM product.product




SELECT category_id, list_price, 
		ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY list_price) AS ROW_NUM,
		RANK() OVER (PARTITION BY category_id ORDER BY list_price) AS RANK_,
		DENSE_RANK() OVER (PARTITION BY category_id ORDER BY list_price) AS DENSE
FROM product.product
-------

--Write a query that returns the order date of the one previous sale of each staff (use the LAG function)
--1. Herbir personelin bir önceki satisinin siparis tarihini yazdiriniz (LAG fonksiyonunu kullanýnýz)


SELECT	DISTINCT A.order_id, B.staff_id, B.first_name, B.last_name, order_date, 
		LAG(order_date, 1) OVER(PARTITION BY B.staff_id ORDER BY order_id) previous_order_date
FROM	sale.orders A, sale.staff B
WHERE	A.staff_id = B.staff_id
;

--Write a query that returns how many days are between the third and fourth order dates of each staff.
--Her bir personelin üçüncü ve dördüncü siparisleri arasindaki gün farkini bulunuz.

WITH T1 AS
(
SELECT	DISTINCT A.order_id, B.staff_id, B.first_name, B.last_name, order_date, 
		LAG(order_date, 1) OVER(PARTITION BY B.staff_id ORDER BY order_id) previous_order_date,
		ROW_NUMBER() OVER (PARTITION BY B.staff_id ORDER BY order_id) ord_number
FROM	sale.orders A, sale.staff B
WHERE	A.staff_id = B.staff_id
) 
SELECT *, DATEDIFF ( DAY, previous_order_date, order_date ) day_diff
FROM	T1
WHERE ord_number = 4