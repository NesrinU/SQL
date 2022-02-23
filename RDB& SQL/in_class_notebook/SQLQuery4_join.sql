/* INNER JOIN: Returns the common records in both tables.
LEFT JOIN: Returns all records from the left table and matching records from the right table.
RIGHT JOIN: Returns all records from the right table and matching records from the left table.
FULL OUTER JOIN: Returns all records of both left and right tables.
CROSS JOIN: Returns the Cartesian product of records in joined tables.
SELF JOIN: A join of a table to itself.*/

/*INNER JOIN: Her iki tablodaki ortak kayıtları döndürür.

SELECT columns
  FROM table_A
  INNER JOIN table_B ON join_conditions

  join_conditions= table_A.column = table_B.column.

SELECT columns
  FROM table_A
  INNER JOIN table_B 
    ON join_conditions1 AND join_conditions2
  INNER JOIN table_C
    ON join_conditions3 OR join_conditions4
...*/

select product_id, product_name, 
product.product.category_id, category_name
from product.product
inner join product.category
on product.product.category_id= product.category.category_id;

select *
from product.product
inner join product.category
on product.product.category_id= product.category.category_id;

-- or 

select a.product_id, b.category_id, b.category_name
from product.product as a
inner join product.category as b
on a.category_id= b.category_id

--or 

select a.product_id, b.category_id, b.category_name
from product.product as a
join product.category as b
on a.category_id= b.category_id

-- or

SELECT A.product_id, B.category_id, B.category_name
FROM	PRODUCT.product A, product.category B
WHERE	A.category_id = B.category_id
AND		category_name = 'Speakers'

-- select employee name, surname, store names

select first_name, last_name, B.store_name
from sale.staff A, sale.store B
where A.store_id= B.store_id

--or

select a.first_name, a.last_name, b.store_name
from sale.staff as a
inner join sale.store as b
on a.store_id = b.store_id;

--Q3) write a query that returns count of the orders of the states by months.
-- State'lerin aylik siparis sayilarini hesaplayiniz

select count ( distinct [state]) from sale.customer

select * from sale.customer

select [state] ,
year( order_date) as ord_year,  
month(order_date) as ord_month
from sale.customer a, sale.orders b
where a.customer_id= b.customer_id
order by 1,2,3


select [state] ,
   year( order_date) as ord_year,  
   month(order_date) as ord_month,
   COUNT (distinct b.order_id) as cnt_order
from sale.customer a, sale.orders b
where a.customer_id= b.customer_id
group by [state], year(b.order_date), month(b.order_date)
order by 1, 2, 3





--Write a query that returns the order date of the product named "Sony - 5.1-Ch. 3D / Smart Blu-ray Home Theater System - Black". 
select * from [product].[product]

select * from [sale].[orders]

select * from [sale].[order_item]

select c.order_date
from product.product as a
INNER JOIN  sale.order_item as b
ON a.product_id = b.product_id
inner join sale.orders as c
on b.order_id= c.order_id
where a.product_name = 'Sony - 5.1-Ch. 3D / Smart Blu-ray Home Theater System - Black'


select * from [sale].[order_item]

select * from [product].[brand]


/*Write a query that returns orders of the products branded "Seagate".
It should be listed Product names and order IDs of all the products ordered or not ordered. (order_id in ascending order)*/

SELECT b.product_name,  c.order_id
from product.brand as a
left join product.product as b
	ON b.brand_id = a.brand_id
left join  sale.order_item as c
   ON b.product_id= c.product_id	
WHERE a.brand_name = 'Seagate'
ORDER BY c.order_id asc



/* LEFT JOIN: Soldaki tablodaki tüm kayıtları ve sağdaki tablodaki eşleşen kayıtları döndürür.  = LEFT OUTER JOIN

SELECT columns
  FROM table_A
  LEFT JOIN table_B ON join_conditions

**Belirli bir satır için eşleşme bulunamazsa, NULL döndürülür.*/

-- write a query that returns products taht have never been ordered
-- select product id, product name, orderid

select a.product_id, a.product_name, b.order_id
from product.product as a
left join sale.order_item as b
on a.product_id= b.product_id
where b.order_id is null
order by 1


----ürün bilgilerini stock moktarlari ile birlikte listeleyin 
-- beklenen product tablosunda olup stock bilgisi olmayanlari da getirin

select a.product_id, a.product_name, b.store_id, b.product_id, b.quantity
from product.product as a
left join product.stock as b 
on a.product_id= b.product_id 
where a.product_id> 310




/*RIGHT JOIN: Sağdaki tablodaki tüm kayıtları ve soldaki tablodaki eşleşen kayıtları döndürür.

SELECT columns
  FROM table_A
  RIGHT JOIN table_B ON join_conditions*/


 select b.product_id, b.product_name, a.store_id, a.product_id, a.quantity
from product.stock as a
right join product.product as b 
on a.product_id= b.product_id 
where b.product_id> 310

-- calisanlarin aldiklarin siparis bilgileri


SELECT A.staff_id,A.first_name,A.last_name,B.order_id
FROM sale.staff AS A
LEFT JOIN sale.orders AS B
ON A.staff_id = B.staff_id
ORDER BY b.order_id



/*FULL OUTER JOIN: Hem sol hem de sağ tabloların tüm kayıtlarını döndürür.

SELECT columns
  FROM table_A
  FULL OUTER JOIN table_B ON join_conditions */

-- write a query that returns stock and order information together for all products(top 100)
--product_id, store_id, quantity, order_id, list-price
-- urunlerin stok miktarlarini ve siprais bilgilerini birlikte listeleyin

select  a.*, b.product_name, c.order_id
from product.stock a
full outer join product.product b
on a.product_id= b.product_id
full outer join sale.order_item c
on b.product_id= c.product_id


/* CROSS JOIN: Birleştirilmiş tablolardaki kayıtların Kartezyen çarpımını döndürür.

SELECT columns
  FROM table_A
  CROSS JOIN table_B

 SELECT columns
  FROM table_A, table_B */

 -- 
 select a.product_id , b.store_id, 0 as quantity
 from 
 (select product_id 
 from product.product
 where product_id not in (select product_id from product.stock) ) a
 cross join product.stock b
 order by 1


select * from product.stock
order by 2



/*SELF JOIN: Bir tablonun kendisine katılması.

SELECT columns
  FROM table A 
  JOIN table B 
  WHERE join_conditions */

-- write a query tha returns the staffs with their managers.

 select a.staff_id , a.first_name , a.last_name, a.manager_id, b.first_name
 from sale.staff a , sale.staff b
 where a.manager_id= b.staff_id

-- write a query tha returns the 1st and 2nd degree managers of all staff


  ------- VIEW --------------- CREATE , DROP and  ALTER 
/*

CREATE VIEW view_name AS
  SELECT columns
  FROM tables
  [WHERE conditions]; */

--  DROP VIEW view_name; 




