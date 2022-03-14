--What is the sales quantity of product according to the brands and sort them highest-lowest

select b.[brand_name], p.product_name, count(o.[quantity]) [Sales Quantitiy of Product]
from [product].[brand] b
inner join [product].[product] p
on b.brand_id = p.brand_id
inner join [sale].[order_item] o
on p.product_id = o.product_id
group by b.brand_name, p.product_name
order by [Sales Quantitiy of Product] desc;


--Select the top 5 most expensive products

select top 5 [product_name], [list_price]
from [product].[product]
order by [list_price] desc;

--What are the categories that each brand has

select b.[brand_name], c.[category_name]
from [product].[brand] b
inner join [product].[product] p
on b.brand_id = p.brand_id
inner join [product].[category] c
on p.category_id = c.category_id
group by b.brand_name, c.category_name


--Select the avg prices according to brands and categories

select b.[brand_name], c.[category_name], avg(p.[list_price]) as [Avg Price]
from [product].[brand] b
inner join [product].[product] p
on b.brand_id = p.brand_id
inner join [product].[category] c
on p.category_id = c.category_id
group by b.brand_name, c.category_name


--Select the annual amount of product produced according to brands

select p.[model_year],b.[brand_name], count(p.[product_name])
from [product].[brand] b
inner join [product].[product] p
on b.brand_id = p.brand_id
group by p.[model_year],b.[brand_name]
order by p.[model_year]




--Select the store which has the most sales quantity in 2018


select top 1 s.[store_name], sum(i.[quantity])
from [sale].[store] s
inner join [sale].[orders] o
on s.store_id = o.store_id
inner join [sale].[order_item] i
on o.order_id = i.order_id
where  datename(year, o.[order_date]) = '2018' -- year(o.[order_date])
group by s.[store_name] 
order by sum(i.[quantity]) desc;




--Select the store which has the most sales amount in 2018


select top 1 s.[store_name], sum(i.[list_price]) as sales_amount_2018
from [sale].[store] s
inner join [sale].[orders] o
on s.store_id = o.store_id
inner join [sale].[order_item] i
on o.order_id = i.order_id
where  datename(year, o.[order_date]) = '2018' -- year(o.[order_date])
group by s.[store_name] 
order by sum(i.[list_price]) desc;



--Select the personnel which has the most sales amount in 2018

select top 1 s.[first_name], s.[last_name], sum(i.[list_price]) as sales_amount_2018
from [sale].[staff] s
inner join [sale].[orders] o
on s.staff_id = o.staff_id
inner join [sale].[order_item] i
on o.order_id = i.order_id
where  datename(year, o.[order_date]) = '2018'
group by s.[first_name], s.[last_name] 
order by sum(i.[list_price]) desc;


--week_10

--Q: Report cumulative total turnover by months in each year in pivot table format.
-- Pivot tablo formatinda her yil aylara göre kümülatif toplam ciroyu raporlayin.
 
 select *
 from (
  select distinct year(order_date) years , month(order_date) months, 
  sum(list_price*quantity) over( partition by year(order_date) order by month(order_date)) as total_sale
  from sale.orders a, sale.order_item b
  where a.order_id= b.order_id
)  X 
PIVOT 
(
SUM(total_sale) 
FOR years
IN ([2018],[2019],[2020])
) as
PIVOT_TABLE
order by months


--What percentage of customers purchasing a product have purchased the same product again?
--Bir ürünü satin alan müsterilerin yüzde kaçi ayni ürünü tekrar satin aldi?

-----

with T1 as
(
select  product_id,
sum(case when  counts >=2 then 1 else 0 end) as customer_counts ,
count(customer_id) as totl_customer
from 
(
select  distinct  b.product_id,  a.customer_id,
count(a.customer_id) over( partition by b.product_id, a.customer_id ) as counts
from sale.orders a, sale.order_item b
where  a.order_id = b.order_id) as X
group by product_id )
select product_id, cast(1.0*customer_counts/totl_customer as numeric(3,2)) per_of_cust_pur
from T1;

-----
SELECT	soi.product_id,COUNT(so.customer_id), COUNT(DISTINCT so.customer_id),
		CAST(1.0*(COUNT(so.customer_id) - COUNT(DISTINCT so.customer_id))/COUNT(so.customer_id) AS DECIMAL(3,2)) per_of_cust_pur
FROM	sale.order_item soi, sale.orders so
		WHERE	soi.order_id = so.order_id
GROUP BY soi.product_id;


----

with cte as
(
select distinct B.product_id,A.customer_id,
COUNT(A.customer_id) over (partition by B.product_id, A.customer_id order by B.product_id) as cnt
from sale.orders as A, sale.order_item as B
where A.order_id=B.order_id
)
select product_id, COUNT(*), sum(case when cnt>1 then 1 else 0 end) as mm
from cte
group by product_id
order by product_id



/*From the following table of user IDs, actions, and dates, 
write a query to return the publication and cancellation rate for each user.
Asagidaki kullanici kimlikleri, eylemler ve tarihler tablosundan, 
her kullanici için yayin ve iptal oranini döndürmek için bir sorgu yazin.*/

create table publication
(
[user_id]  int,
[action]   varchar(50),
[Date]   date  
);

insert into publication ([user_id] , [action], [Date] )
Values ( 1, 'Start', '1-1-22'),
       ( 1, 'Cancel', '1-2-22'),
	   ( 2, 'Start', '1-3-22'),
	   ( 2, 'Publish', '1-4-22'),
	   ( 3, 'Start', '1-5-22'),
	   ( 3, 'Cancel', '1-6-22'),
	   ( 1, 'Start', '1-7-22'),
	   ( 1, 'Publish', '1-8-22');

 select * from publication




  select [user_id],
 cast(1.0*sum (case when [action] = 'Publish' then 1 else 0 end)
 /sum(case when [action]= 'Start' then 1 else 0 end) as numeric (2,1)) as  Publish_rate ,

 cast(1.0*sum (case when [action]= 'Cancel'  then 1 else 0 end) /
 sum(case when [action]= 'Start' then 1 else 0 end) as numeric (2,1)) as Cancel_rate
 from publication 
 group by [user_id]

 select cast(1.0 *5 as numeric (3,2))
 select convert( decimal (3,2) , 5 )